/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Lesson;

/**
 *
 * @author sonpk
 */
public class LessonDao extends DBContext {

    public List<Lesson> getLessonsByChapterID(int chapterID) {
        List<Lesson> lessons = new ArrayList<>();
        String sql = "SELECT * FROM Lesson WHERE ChapterID = ? ORDER BY LessonOrder";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, chapterID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Lesson lesson = new Lesson();
                lesson.setLessonID(rs.getInt("LessonID"));
                lesson.setChapterID(rs.getInt("ChapterID"));
                lesson.setTitle(rs.getString("Title"));
                lesson.setIsFree(rs.getBoolean("IsFree"));
                lesson.setLessonOrder(rs.getInt("LessonOrder"));
                lessons.add(lesson);
            }
        } catch (SQLException e) {
        }
        return lessons;
    }

    public Lesson getLessonByID(int lessonID) {
        Lesson lesson = null;
        String sql = "SELECT * FROM Lesson WHERE LessonID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, lessonID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lesson = new Lesson();
                lesson.setLessonID(rs.getInt("LessonID"));
                lesson.setChapterID(rs.getInt("ChapterID"));
                lesson.setTitle(rs.getString("Title"));
                lesson.setIsFree(rs.getBoolean("IsFree"));
                lesson.setLessonOrder(rs.getInt("LessonOrder"));
            }
        } catch (SQLException e) {
        }
        return lesson;
    }

    public int countLessonsByCourse(int courseID) {
        int count = 0;
        String sql = "SELECT COUNT(*) AS total FROM Lesson l JOIN Chapter c ON l.ChapterID = c.ChapterID WHERE c.CourseID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
        }

        return count;
    }

}
