/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// dao/LessonHierarchyDao.java
package dao;

import model.*;
import java.sql.*;
import java.util.*;

public class LessonHierarchyDao extends context2 {

    public List<Chapter> getLessonHierarchyByCourse(int courseId, Integer chapterId, String status, String search) {
    List<Chapter> chapters = new ArrayList<>();

    String sql = "SELECT c.ChapterID, c.Title AS ChapterTitle, c.ChapterOrder, " +
                 "l.LessonID, l.Title AS LessonTitle, l.LessonOrder, l.IsFree, " +
                 "q.QuizID, q.QuizName, q.QuestionOrder, q.QuizType " +
                 "FROM Chapter c " +
                 "LEFT JOIN Lesson l ON c.ChapterID = l.ChapterID " +
                 "LEFT JOIN Quizzes q ON l.LessonID = q.LessonID " +
                 "WHERE c.CourseID = ?";

    // Bổ sung điều kiện động
    if (chapterId != null && chapterId > 0) {
        sql += " AND c.ChapterID = ?";
    }

    if (search != null && !search.trim().isEmpty()) {
        sql += " AND (l.Title LIKE ? OR q.QuizName LIKE ?)";
    }

    sql += " ORDER BY c.ChapterOrder, l.LessonOrder, q.QuestionOrder";

    try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
        int index = 1;
        ps.setInt(index++, courseId);

        if (chapterId != null && chapterId > 0) {
            ps.setInt(index++, chapterId);
        }

        if (search != null && !search.trim().isEmpty()) {
            String searchWildcard = "%" + search + "%";
            ps.setString(index++, searchWildcard);
            ps.setString(index++, searchWildcard);
        }

        ResultSet rs = ps.executeQuery();
        Map<Integer, Chapter> chapterMap = new LinkedHashMap<>();
        Map<Integer, Lesson> lessonMap = new HashMap<>();

        while (rs.next()) {
            int cid = rs.getInt("ChapterID");
            Chapter chapter = chapterMap.getOrDefault(cid, new Chapter());
            if (!chapterMap.containsKey(cid)) {
                chapter.setId(cid);
                chapter.setTitle(rs.getString("ChapterTitle"));
                chapter.setOrder(rs.getInt("ChapterOrder"));
                chapter.setLessons(new ArrayList<>());
                chapterMap.put(cid, chapter);
            }

            int lessonId = rs.getInt("LessonID");
            if (lessonId > 0) {
                boolean isFree = rs.getBoolean("IsFree");
                String lessonStatus = isFree ? "Active" : "Inactive";

                // Kiểm tra status nếu được lọc
                if (status == null || status.equals("All") || lessonStatus.equalsIgnoreCase(status)) {
                    Lesson lesson = lessonMap.getOrDefault(lessonId, new Lesson());
                    if (!lessonMap.containsKey(lessonId)) {
                        lesson.setId(lessonId);
                        lesson.setTitle(rs.getString("LessonTitle"));
                        lesson.setOrder(rs.getInt("LessonOrder"));
                        lesson.setStatus(lessonStatus);
                        lesson.setQuizzes(new ArrayList<>());
                        lessonMap.put(lessonId, lesson);
                        chapter.getLessons().add(lesson);
                    }

                    int quizId = rs.getInt("QuizID");
                    if (quizId > 0) {
                        Quiz quiz = new Quiz();
                        quiz.setId(quizId);
                        quiz.setName(rs.getString("QuizName"));
                        quiz.setOrder(rs.getInt("QuestionOrder"));
                        quiz.setStatus("Inactive"); // Nếu có cột status thì dùng rs.getString
                        lesson.getQuizzes().add(quiz);
                    }
                }
            }
        }

        chapters.addAll(chapterMap.values());

    } catch (Exception e) {
        e.printStackTrace();
    }

    return chapters;
}
}
