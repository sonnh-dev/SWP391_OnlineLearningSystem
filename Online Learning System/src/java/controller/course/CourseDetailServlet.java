package controller.course;

import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.*;
import model.course.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.*;

@WebServlet(name = "CourseDetails", urlPatterns = {"/CourseDetail"})
@MultipartConfig
public class CourseDetailServlet extends HttpServlet {

    private final CourseDao courseDao = new CourseDao();
    private final CoursePackageDao coursePackageDao = new CoursePackageDao();
    private final CourseAdditionalDao courseAdditionalDao = new CourseAdditionalDao();
    private final CourseReviewDao reviewDao = new CourseReviewDao();
    private final CourseReviewMediaDao mediaDao = new CourseReviewMediaDao();
    private final UserDAO userDao = new UserDAO();
    private final LessonDao lessonDao = new LessonDao();
    private final ChapterDao chapterDao = new ChapterDao();

    private void setUserIfLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Account auth = (Account) session.getAttribute("auth");
            if (auth != null) {
                request.setAttribute("user", userDao.getLoginUser(auth));
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        setUserIfLoggedIn(request);
        // CourseID và thông tin cơ bản
        int courseID = Integer.parseInt(request.getParameter("courseID"));
        Course course = courseDao.getCourseByID(courseID);
        request.setAttribute("course", course);
        request.setAttribute("price", coursePackageDao.getCheapestCoursePackagesByCourse(course));
        request.setAttribute("courseAdditional", courseAdditionalDao.getCourseAdditionalByCourseID(courseID));

        // Chapter & Lesson
        List<Chapter> chapters = chapterDao.getChaptersByCourseID(courseID);
        Map<Integer, List<Lesson>> lessonMap = new HashMap<>();
        for (Chapter chapter : chapters) {
            lessonMap.put(chapter.getChapterID(), lessonDao.getLessonsByChapterID(chapter.getChapterID()));
        }
        request.setAttribute("chapters", chapters);
        request.setAttribute("lessonMap", lessonMap);

        // Featured courses
        List<Course> featuredSubjects = courseDao.get4HotestCoursesofDifferentCategories();
        request.setAttribute("category", courseDao.getAllCategories());
        request.setAttribute("featuredSubjects", featuredSubjects);
        Map<Integer, CoursePackage> minPackage = new HashMap<>();
        for (Course c : featuredSubjects) {
            minPackage.put(c.getCourseID(), coursePackageDao.getCheapestCoursePackagesByCourse(c));
        }
        request.setAttribute("minPackage", minPackage);

        // Xử lý review (filter + phân trang)
        String filter = request.getParameter("filter");
        int pageSize = 5;
        int page = Optional.ofNullable(request.getParameter("page")).map(p -> {
            try {
                return Integer.valueOf(p);
            } catch (NumberFormatException e) {
                return 1;
            }
        }).orElse(1);

        //Tổng số reviews
        int totalView = reviewDao.countReviewsByCourseIdAndFilter(courseID, "all");
        request.setAttribute("totalReviews", totalView);

        // Tổng số review theo filter
        int totalFilterReviews = reviewDao.countReviewsByCourseIdAndFilter(courseID, filter);
        request.setAttribute("filterTotalReview", totalFilterReviews);

        // % được recommend (trong tất cả review)
        int recommendedCount = reviewDao.countReviewsByCourseIdAndFilter(courseID, "recommended");
        int recommendPercentage = totalView == 0 ? 0 : recommendedCount * 100 / totalView;
        request.setAttribute("recommendPercentage", recommendPercentage);

        //Phân trang
        int totalPages = (int) Math.ceil((double) totalFilterReviews / pageSize);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        //Danh sách reviews đã filter
        List<CourseReview> filteredReviews = reviewDao.getReviewsByCourseIdAndFilter(courseID, filter, page, pageSize);
        request.setAttribute("courseReviews", filteredReviews);

        //Media và user cho mỗi reviews
        Map<Integer, List<CourseReviewMedia>> reviewMediaMap = new HashMap<>();
        Map<Integer, User> userMap = new HashMap<>();
        int recommendCount = 0;
        for (CourseReview review : filteredReviews) {
            reviewMediaMap.put(review.getReviewID(), mediaDao.getMediaByReviewId(review.getReviewID()));
            try {
                userMap.put(review.getUserID(), userDao.getUserById(review.getUserID()));
            } catch (ClassNotFoundException e) {
            }
            if (review.isRecommended()) {
                recommendCount++;
            }
        }
        request.setAttribute("userMap", userMap);
        request.setAttribute("reviewMediaMap", reviewMediaMap);

        //request tới trang jsp
        request.getRequestDispatcher("courseDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra đăng nhập
        setUserIfLoggedIn(request);
        HttpSession session = request.getSession(false);
        Account auth = (Account) session.getAttribute("auth");
        if (auth == null) {
            return;
        }
        //Lấy thông tin reviews từ js
        int userId = userDao.getLoginUser(auth).getUserId();
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        String recommend = request.getParameter("recommend");
        String comment = request.getParameter("comment");
        String[] captions = request.getParameterValues("mediaCaptions");

        // Load file media xuống sever
        String uploadPath = new File(getServletContext()
                .getRealPath("/")).getParentFile().getParentFile().getParentFile()
                .toPath().resolve("MediaFeature/courseReview").toAbsolutePath().toString();
        List<String> savedPaths = new ArrayList<>();
        for (Part part : request.getParts()) {
            if ("mediaFiles".equals(part.getName()) && part.getSize() > 0) {
                String fileName = UUID.randomUUID() + "_" + Paths.get(part.getSubmittedFileName()).getFileName();
                File file = new File(uploadPath, fileName);
                part.write(file.getAbsolutePath());
                savedPaths.add("media/courseReview/" + fileName);
            }
        }

        CourseReview review = new CourseReview(0, userId, courseId, "yes".equalsIgnoreCase(recommend), comment, null);
        int reviewID = reviewDao.addReviewAndGetReviewID(review);
        for (int i = 0; i < savedPaths.size(); i++) {
            String path = savedPaths.get(i);
            String caption = (captions != null && i < captions.length) ? captions[i] : "";
            boolean isVideo = path.toLowerCase().endsWith(".mp4") || path.contains("video");
            mediaDao.addMediaToReview(new CourseReviewMedia(0, reviewID, path, isVideo, caption));
        }

        response.sendRedirect("CourseDetail?courseID=" + courseId);
    }
    @Override
    public String getServletInfo() {
        return "Course detail display and review submission servlet";
    }
}
