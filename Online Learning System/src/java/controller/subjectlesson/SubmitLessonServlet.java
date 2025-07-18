package controller.subjectLesson;

import dao.ChapterDao1;
import dao.LessonDao1;
import dao.QuizDao1;
import dao.LessonContentDao1;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Chapter;
import model.Lesson;
import model.LessonContent;
import model.Quiz;

import java.io.IOException;


public class SubmitLessonServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        String name = request.getParameter("name"); // tương ứng Title
        int order = Integer.parseInt(request.getParameter("order")); // tương ứng LessonOrder hoặc ChapterOrder
        int subjectId = Integer.parseInt(request.getParameter("subjectId")); // là CourseID
        boolean isSuccessful = false;

        try {
            switch (type) {
                case "Subject Topic": {
                    Chapter chapter = new Chapter();
                    chapter.setTitle(name);
                    chapter.setChapterOrder(order);
                    chapter.setCourseID(subjectId);
                    chapter.setStatus(true);
                    isSuccessful = new ChapterDao1().insertChapter(chapter);
                    break;
                }
                case "Lesson": {
                    int chapterId = Integer.parseInt(request.getParameter("chapterId"));
                    String videoUrl = request.getParameter("videoUrl");
                    String htmlContent = request.getParameter("docContent");

                    Lesson lesson = new Lesson();
                    lesson.setTitle(name);
                    lesson.setLessonOrder(order);
                    lesson.setChapterID(chapterId);
                    lesson.setIsFree(true); // bạn có thể thay đổi tuỳ UI
                    lesson.setStatus(true);

                    LessonDao1 lessonDao = new LessonDao1();
                    int lessonId = lessonDao.insertLesson(lesson);

                    if (lessonId > 0) {
                        LessonContent content = new LessonContent();
                        content.setLessonID(lessonId);
                        content.setVideoURL(videoUrl);
                        content.setDocContent(htmlContent);
                        isSuccessful = new LessonContentDao1().insertLessonContent(content);
                    }
                    break;
                }
                case "Quiz": {
                    int chapterId = Integer.parseInt(request.getParameter("chapterId"));

                    Quiz quiz = new Quiz();
                    quiz.setLessonID(null); // hoặc bạn có thể tạo 1 lesson r gán
                    quiz.setCourseID(subjectId);
                    quiz.setQuizName(name);
                    quiz.setSubject(request.getParameter("quizSubject"));
                    quiz.setLevel(request.getParameter("quizLevel"));
                    quiz.setNumQuestions(Integer.parseInt(request.getParameter("numQuestions")));
                    quiz.setDurationMinutes(Integer.parseInt(request.getParameter("durationMinutes")));
                    quiz.setPassRate(Float.parseFloat(request.getParameter("passRate")));
                    quiz.setQuizType(request.getParameter("quizType"));
                    quiz.setQuestionOrder(order);
                    quiz.setStatus(true);

                    isSuccessful = new QuizDao1().insertQuiz(quiz);
                    break;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        if (isSuccessful) {
            response.sendRedirect("LessonListServlet?subjectId=" + subjectId);
        } else {
            response.getWriter().write("Error occurred while saving data.");
        }
    }
}
