/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import context.DBContextF;
import java.sql.Statement;
import java.sql.Date; 
import model.Quiz;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author phucn
 */
public class QuizDAO extends DBContextF {
    public List<Quiz> getAllQuizzes(String searchName, String subject, String quizType, int offset, int pageSize) {
        List<Quiz> quizzes = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        StringBuilder sql = new StringBuilder("SELECT QuizID, QuizName, Subject, Level, NumQuestions, DurationMinutes, PassRate, QuizType FROM Quizzes WHERE 1=1");

        // Thêm điều kiện lọc và tìm kiếm
        if (searchName != null && !searchName.isEmpty()) {
            sql.append(" AND QuizName LIKE ?");
        }
        if (subject != null && !subject.isEmpty()) {
            sql.append(" AND Subject = ?");
        }
        if (quizType != null && !quizType.isEmpty()) {
            sql.append(" AND QuizType = ?");
        }

        sql.append(" ORDER BY QuizID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql.toString());
            int paramIndex = 1;

            if (searchName != null && !searchName.isEmpty()) {
                ps.setString(paramIndex++, "%" + searchName + "%");
            }
            if (subject != null && !subject.isEmpty()) {
                ps.setString(paramIndex++, subject);
            }
            if (quizType != null && !quizType.isEmpty()) {
                ps.setString(paramIndex++, quizType);
            }

            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, pageSize);

            rs = ps.executeQuery();
            while (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setQuizID(rs.getInt("QuizID"));
                quiz.setQuizName(rs.getString("QuizName"));
                quiz.setSubject(rs.getString("Subject"));
                quiz.setLevel(rs.getString("Level"));
                quiz.setNumQuestions(rs.getInt("NumQuestions"));
                quiz.setDurationMinutes(rs.getInt("DurationMinutes"));
                quiz.setPassRate(rs.getDouble("PassRate"));
                quiz.setQuizType(rs.getString("QuizType"));
                quizzes.add(quiz);
            }
        } catch (SQLException e) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, ps, rs);
        }
        return quizzes;
    }
    
    public int getTotalQuizCount(String searchName, String subject, String quizType) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int total = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Quizzes WHERE 1=1");

        if (searchName != null && !searchName.isEmpty()) {
            sql.append(" AND QuizName LIKE ?");
        }
        if (subject != null && !subject.isEmpty()) {
            sql.append(" AND Subject = ?");
        }
        if (quizType != null && !quizType.isEmpty()) {
            sql.append(" AND QuizType = ?");
        }

        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql.toString());
            int paramIndex = 1;
            if (searchName != null && !searchName.isEmpty()) {
                ps.setString(paramIndex++, "%" + searchName + "%");
            }
            if (subject != null && !subject.isEmpty()) {
                ps.setString(paramIndex++, subject);
            }
            if (quizType != null && !quizType.isEmpty()) {
                ps.setString(paramIndex++, quizType);
            }
            rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, ps, rs);
        }
        return total;
    }

    public boolean hasAttempts(int quizId) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean hasAttempts = false;
        try {
            conn = getConnection();
            String sql = "SELECT COUNT(*) FROM QuizAttempts WHERE QuizID = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, quizId);
            rs = ps.executeQuery();
            if (rs.next()) {
                hasAttempts = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, ps, rs);
        }
        return hasAttempts;
    }

    public void deleteQuiz(int quizId) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction

            // Xóa QuestionOptions trước
            String deleteOptionsSql = "DELETE FROM QuestionOptions WHERE QuestionID IN (SELECT QuestionID FROM Questions WHERE QuizID = ?)";
            ps = conn.prepareStatement(deleteOptionsSql);
            ps.setInt(1, quizId);
            ps.executeUpdate();
            ps.close();

            // Xóa Questions
            String deleteQuestionsSql = "DELETE FROM Questions WHERE QuizID = ?";
            ps = conn.prepareStatement(deleteQuestionsSql);
            ps.setInt(1, quizId);
            ps.executeUpdate();
            ps.close();

            // Xóa QuizAttempts
            String deleteAttemptsSql = "DELETE FROM QuizAttempts WHERE QuizID = ?";
            ps = conn.prepareStatement(deleteAttemptsSql);
            ps.setInt(1, quizId);
            ps.executeUpdate();
            ps.close();

            // Xóa Quiz
            String deleteQuizSql = "DELETE FROM Quizzes WHERE QuizID = ?";
            ps = conn.prepareStatement(deleteQuizSql);
            ps.setInt(1, quizId);
            ps.executeUpdate();

            conn.commit(); // Commit transaction nếu tất cả thành công
        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback(); // Rollback nếu có lỗi
            } catch (SQLException ex) {
                Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, ps, null);
        }
    }
    
    // Phương thức trợ giúp để đóng tài nguyên
    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }
     public Quiz getQuizById(int quizId) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Quiz quiz = null;
        try {
            conn = getConnection();
            String sql = "SELECT QuizID, LessonID, CourseID, QuizName, Subject, Level, NumQuestions, DurationMinutes, PassRate, QuizType, QuestionOrder, CreatedAt, UpdatedAt FROM Quizzes WHERE QuizID = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, quizId);
            rs = ps.executeQuery();
            if (rs.next()) {
                quiz = new Quiz();
                quiz.setQuizID(rs.getInt("QuizID"));
                quiz.setLessonID(rs.getObject("LessonID", Integer.class)); // Sử dụng getObject để xử lý NULL
                quiz.setCourseID(rs.getObject("CourseID", Integer.class));
                quiz.setQuizName(rs.getString("QuizName"));
                quiz.setSubject(rs.getString("Subject"));
                quiz.setLevel(rs.getString("Level"));
                quiz.setNumQuestions(rs.getInt("NumQuestions"));
                quiz.setDurationMinutes(rs.getInt("DurationMinutes"));
                quiz.setPassRate(rs.getDouble("PassRate"));
                quiz.setQuizType(rs.getString("QuizType"));
                quiz.setQuestionOrder(rs.getObject("QuestionOrder", Integer.class));
                quiz.setCreatedAt(rs.getDate("CreatedAt"));
                quiz.setUpdatedAt(rs.getDate("UpdatedAt"));
            }
        } catch (SQLException e) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, ps, rs);
        }
        return quiz;
    }

    public int addQuiz(Quiz quiz) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int generatedId = -1;
        String sql = "INSERT INTO Quizzes (LessonID, CourseID, QuizName, Subject, Level, NumQuestions, DurationMinutes, PassRate, QuizType, QuestionOrder, CreatedAt, UpdatedAt) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), GETDATE())";
        try {
            conn = getConnection();
            // Lấy ID tự tăng sau khi insert
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setObject(1, quiz.getLessonID()); // Sử dụng setObject cho Integer (NULLable)
            ps.setObject(2, quiz.getCourseID());
            ps.setString(3, quiz.getQuizName());
            ps.setString(4, quiz.getSubject());
            ps.setString(5, quiz.getLevel());
            ps.setInt(6, quiz.getNumQuestions());
            ps.setInt(7, quiz.getDurationMinutes());
            ps.setDouble(8, quiz.getPassRate());
            ps.setString(9, quiz.getQuizType());
            ps.setObject(10, quiz.getQuestionOrder());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getInt(1); // Lấy ID của Quiz vừa thêm
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, "Lỗi khi thêm Quiz mới", e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, ps, rs);
        }
        return generatedId;
    }

    public boolean updateQuiz(Quiz quiz) {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean success = false;
        String sql = "UPDATE Quizzes SET LessonID = ?, CourseID = ?, QuizName = ?, Subject = ?, Level = ?, NumQuestions = ?, DurationMinutes = ?, PassRate = ?, QuizType = ?, QuestionOrder = ?, UpdatedAt = GETDATE() WHERE QuizID = ?";
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setObject(1, quiz.getLessonID());
            ps.setObject(2, quiz.getCourseID());
            ps.setString(3, quiz.getQuizName());
            ps.setString(4, quiz.getSubject());
            ps.setString(5, quiz.getLevel());
            ps.setInt(6, quiz.getNumQuestions());
            ps.setInt(7, quiz.getDurationMinutes());
            ps.setDouble(8, quiz.getPassRate());
            ps.setString(9, quiz.getQuizType());
            ps.setObject(10, quiz.getQuestionOrder());
            ps.setInt(11, quiz.getQuizID());

            int affectedRows = ps.executeUpdate();
            success = affectedRows > 0;
        } catch (SQLException e) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, "Lỗi khi cập nhật Quiz", e);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, ps, null);
        }
        return success;
    }
    
}
