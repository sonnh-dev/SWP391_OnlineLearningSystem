package controller.subjectLesson;

import dao.ChapterDao1;
import dao.LessonDao1;
import dao.LessonContentDao1;
import dao.QuizDao1;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Chapter;
import model.Lesson;
import model.LessonContent;
import model.Quiz;

import java.io.IOException;

/**
 *
 * @author ADMIN
 */
public class UpdateLessonServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Lấy tham số từ form
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));
        String type = request.getParameter("type");
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        boolean isSuccessful = false;

        try {
            switch (type) {
                case "Subject Topic": {
                    String name = request.getParameter("lessonName"); // tương ứng Title
                    int order = Integer.parseInt(request.getParameter("order"));

                    Chapter chapter = new Chapter();
                    chapter.setChapterID(lessonId); // Sử dụng lessonId làm ChapterID
                    chapter.setTitle(name);
                    chapter.setChapterOrder(order);
                    chapter.setCourseID(subjectId);
                    chapter.setStatus(true);
                    isSuccessful = new ChapterDao1().updateChapter(chapter);
                    break;
                }
                case "Lesson": {
                    String name = request.getParameter("lessonName");
                    int order = Integer.parseInt(request.getParameter("order"));
                    int chapterId = Integer.parseInt(request.getParameter("chapterId")); // Lấy từ database hoặc form ẩn
                    String videoUrl = request.getParameter("videoUrl");
                    String htmlContent = request.getParameter("content");

                    Lesson lesson = new Lesson();
                    lesson.setLessonID(lessonId);
                    lesson.setTitle(name);
                    lesson.setLessonOrder(order);
                    lesson.setChapterID(chapterId);
                    lesson.setIsFree(true); // Giữ nguyên hoặc lấy từ database
                    lesson.setStatus(true);

                    LessonDao1 lessonDao = new LessonDao1();
                    isSuccessful = lessonDao.updateLesson(lesson);

                    if (isSuccessful) {
                        LessonContent content = new LessonContent();
                        content.setLessonID(lessonId);
                        content.setVideoURL(videoUrl);
                        content.setDocContent(htmlContent);
                        isSuccessful = new LessonContentDao1().updateLessonContent(content);
                    }
                    break;
                }
                case "Quiz": {
                    String name = request.getParameter("lessonName");
                    int order = Integer.parseInt(request.getParameter("order"));
                    String quizSubject = request.getParameter("quizSubject");
                    String quizLevel = request.getParameter("quizLevel");
                    int numQuestions = Integer.parseInt(request.getParameter("numQuestions"));
                    int durationMinutes = Integer.parseInt(request.getParameter("durationMinutes"));
                    float passRate = Float.parseFloat(request.getParameter("passRate"));
                    String quizType = request.getParameter("quizType");

                    Quiz quiz = new Quiz();
                    quiz.setLessonID(null); // Sử dụng lessonId làm QuizID
                    quiz.setCourseID(subjectId);
                    quiz.setQuizName(name);
                    quiz.setSubject(quizSubject);
                    quiz.setLevel(quizLevel);
                    quiz.setNumQuestions(numQuestions);
                    quiz.setDurationMinutes(durationMinutes);
                    quiz.setPassRate(passRate);
                    quiz.setQuizType(quizType);
                    quiz.setQuestionOrder(order);
                    quiz.setStatus(true);

                    isSuccessful = new QuizDao1().updateQuiz(quiz);
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (isSuccessful) {
            response.sendRedirect("LessonListServlet?subjectId=" + subjectId);
        } else {
            response.getWriter().write("Error occurred while updating data.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Update lesson servlet";
    }
}