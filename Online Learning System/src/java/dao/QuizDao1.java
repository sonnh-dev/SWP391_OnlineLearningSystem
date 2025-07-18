package dao;

import context.context2;
import java.sql.*;
import model.Quiz;

public class QuizDao1 {

    public boolean insertQuiz(Quiz quiz) {
        String sql = "INSERT INTO Quizzes (LessonID, CourseID, QuizName, Subject, Level, NumQuestions, DurationMinutes, PassRate, QuizType, QuestionOrder, Status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (quiz.getLessonID() == null) {
                ps.setNull(1, Types.INTEGER);
            } else {
                ps.setInt(1, quiz.getLessonID());
            }
            ps.setInt(2, quiz.getCourseID());
            ps.setString(3, quiz.getQuizName());
            ps.setString(4, quiz.getSubject());
            ps.setString(5, quiz.getLevel());
            ps.setInt(6, quiz.getNumQuestions());
            ps.setInt(7, quiz.getDurationMinutes());
            ps.setFloat(8, (float) quiz.getPassRate());
            ps.setString(9, quiz.getQuizType());
            ps.setInt(10, quiz.getQuestionOrder());
            ps.setBoolean(11, quiz.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static Quiz getById(int id) {
        String sql = "SELECT * FROM Quizzes WHERE QuizID = ?";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setQuizID(rs.getInt("QuizID"));
                quiz.setLessonID((Integer) rs.getObject("LessonID")); // nullable
                quiz.setCourseID(rs.getInt("CourseID"));
                quiz.setQuizName(rs.getString("QuizName"));
                quiz.setSubject(rs.getString("Subject"));
                quiz.setLevel(rs.getString("Level"));
                quiz.setNumQuestions(rs.getInt("NumQuestions"));
                quiz.setDurationMinutes(rs.getInt("DurationMinutes"));
                quiz.setPassRate(rs.getDouble("PassRate"));
                quiz.setQuizType(rs.getString("QuizType"));
                quiz.setQuestionOrder(rs.getInt("QuestionOrder"));
                quiz.setStatus(rs.getBoolean("Status"));
                return quiz;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateQuiz(Quiz quiz) {
        String sql = "UPDATE Quizzes SET LessonID=?, CourseID=?, QuizName=?, Subject=?, Level=?, NumQuestions=?, DurationMinutes=?, PassRate=?, QuizType=?, QuestionOrder=?, Status=? " +
                     "WHERE QuizID=?";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (quiz.getLessonID() == null) {
                ps.setNull(1, Types.INTEGER);
            } else {
                ps.setInt(1, quiz.getLessonID());
            }
            ps.setInt(2, quiz.getCourseID());
            ps.setString(3, quiz.getQuizName());
            ps.setString(4, quiz.getSubject());
            ps.setString(5, quiz.getLevel());
            ps.setInt(6, quiz.getNumQuestions());
            ps.setInt(7, quiz.getDurationMinutes());
            ps.setDouble(8, quiz.getPassRate());
            ps.setString(9, quiz.getQuizType());
            ps.setInt(10, quiz.getQuestionOrder());
            ps.setBoolean(11, quiz.getStatus());
            ps.setInt(12, quiz.getQuizID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteQuiz(int id) {
        String sql = "DELETE FROM Quizzes WHERE QuizID = ?";
        try (Connection conn = context2.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
