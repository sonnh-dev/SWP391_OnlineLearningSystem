/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import dao.ChapterDao;
import dao.CourseLessionActivityDao;
import dao.LessonContentDao;
import dao.LessonDao;
import dao.QuizDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Chapter;
import model.CheckLesson;
import model.Lesson;
import model.LessonContent;
import model.Quiz;

/**
 *
 * @author sonpk
 */
@WebServlet(name = "LessionViewServlet", urlPatterns = {"/LessonView"})
public class LessionViewServlet extends HttpServlet {

    ChapterDao chapterDao = new ChapterDao();
    LessonDao lessonDao = new LessonDao();
    LessonContentDao lessonContentDao = new LessonContentDao();
    CourseLessionActivityDao courseLessionActivityDao = new CourseLessionActivityDao();
    QuizDAO quizDao = new QuizDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Account auth = null;
        if (session != null) {
            auth = (Account) session.getAttribute("auth");
        }
        int userID;
        if (auth != null) {
            userID = auth.getId();
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing or invalid userID");
            return;
        }

        int courseID = Integer.parseInt(request.getParameter("courseID"));

        // ===== Process tracking =====
        int completedLesson = courseLessionActivityDao.getProcessByUserAndCourse(userID, courseID);
        int totalLesson = lessonDao.countLessonsByCourse(courseID);
        int percentCompleted = totalLesson == 0 ? 0 : (completedLesson * 100) / totalLesson;
        request.setAttribute("completedCount", completedLesson);
        request.setAttribute("totalLessons", totalLesson);
        request.setAttribute("percentCompleted", percentCompleted);

        // ===== Get chapter and lesson + quizz
        List<Chapter> chapter = chapterDao.getChaptersByCourseID(courseID);

        Map<Chapter, List<CheckLesson>> chapterContentMap = new LinkedHashMap<>();
        for (Chapter chap : chapter) {
            List<CheckLesson> contentList = new ArrayList<>();
            List<Lesson> lessons = lessonDao.getLessonsByChapterID(chap.getChapterID());
            for (Lesson lesson : lessons) {
                LessonContent content = lessonContentDao.getLessonContentByLessonID(lesson.getLessonID());
                lesson.setLessonContent(content);
                contentList.add(new CheckLesson("lesson", lesson));

                List<Quiz> quizzes = quizDao.getQuizByLessonID(lesson.getLessonID());
                for (Quiz quiz : quizzes) {
                    contentList.add(new CheckLesson("quiz", quiz));
                }
            }
            chapterContentMap.put(chap, contentList);
        }
        // catch lession
        String lessonIDStr = request.getParameter("lessonID");
        if (lessonIDStr != null && !lessonIDStr.isEmpty()) {
            int lessonID = Integer.parseInt(lessonIDStr);
            Lesson selectedLesson = lessonDao.getLessonByID(lessonID);
            if (selectedLesson != null) {
                LessonContent content = lessonContentDao.getLessonContentByLessonID(lessonID);
                selectedLesson.setLessonContent(content);
                request.setAttribute("selectedLesson", selectedLesson);
            }

        }
        request.setAttribute("chapter", chapter);
        request.setAttribute("chapterContent", chapterContentMap);
        request.setAttribute("courseID", courseID);
        
        request.getRequestDispatcher("lessonView.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int userID;
        Account auth = null;
        if (session != null) {
            auth = (Account) session.getAttribute("auth");
        }
        if (auth != null) {
            userID = auth.getId();
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing or invalid userID");
            return;
        }
        int courseID = Integer.parseInt(request.getParameter("courseID"));
        int lessonID = Integer.parseInt(request.getParameter("lessonID"));

        courseLessionActivityDao.markLessonAsCompleted(userID, lessonID, courseID);

        // Quay lại trang lesson
        response.sendRedirect("LessonView?courseID=" + courseID + "&lessonID=" + lessonID);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
