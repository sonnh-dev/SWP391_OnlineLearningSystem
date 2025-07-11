/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.DBContextF;
import java.sql.Statement;
import model.Quiz;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Question;
import model.QuestionOption;
import model.QuizAttempt;
import model.QuizAttemptDetail;

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
                if (conn != null) {
                    conn.rollback(); // Rollback nếu có lỗi
                }
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
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            Logger.getLogger(QuizDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }
// Trong QuizDAO.java

    public QuizAttempt getQuizAttemptById(int attemptId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        QuizAttempt attempt = null;
        String sql = "SELECT AttemptID, UserID, QuizID, StartTime, EndTime, Score, IsPassed "
                + "FROM QuizAttempts WHERE AttemptID = ?";
        try {
            con = dbContext.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, attemptId);
            rs = ps.executeQuery();
            if (rs.next()) {
                attempt = new QuizAttempt(
                        rs.getInt("AttemptID"),
                        rs.getInt("UserID"),
                        rs.getInt("QuizID"),
                        rs.getTimestamp("StartTime"),
                        rs.getTimestamp("EndTime"),
                        rs.getDouble("Score"),
                        rs.getBoolean("IsPassed")
                );
            }
        } finally {
            closeResources(rs, ps, con);
        }
        return attempt;
    }

    public Quiz getQuizById1(int quizId) {
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
    private DBContextF dbContext;

    public QuizDAO() {
        dbContext = new DBContextF();
    }

    public QuizAttempt getLastQuizAttempt(int userId, int quizId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        QuizAttempt attempt = null;
        String sql = "SELECT TOP 1 AttemptID, UserID, QuizID, StartTime, EndTime, Score, IsPassed "
                + "FROM QuizAttempts WHERE UserID = ? AND QuizID = ? ORDER BY StartTime DESC"; // Order by StartTime to get last
        try {
            con = dbContext.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, quizId);
            rs = ps.executeQuery();
            if (rs.next()) {
                attempt = new QuizAttempt(
                        rs.getInt("AttemptID"),
                        rs.getInt("UserID"),
                        rs.getInt("QuizID"),
                        rs.getTimestamp("StartTime"),
                        rs.getTimestamp("EndTime"),
                        rs.getDouble("Score"),
                        rs.getBoolean("IsPassed") // Get as Boolean to handle NULL
                );
            }
        } finally {
            closeResources(rs, ps, con);
        }
        return attempt;
    }

// ...
    public List<Question> getQuestionsForQuiz(int quizId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT q.QuestionID, q.QuestionContent, q.QuestionType, q.AnswerKey, qo.OptionID, qo.OptionContent, qo.IsCorrect "
                + // Thêm q.AnswerKey
                "FROM Questions q LEFT JOIN QuestionOptions qo ON q.QuestionID = qo.QuestionID "
                + // Dùng LEFT JOIN để lấy cả câu tự luận không có options
                "WHERE q.QuizID = ? ORDER BY q.QuestionID, qo.OptionID"; // Sắp xếp để nhóm câu hỏi
        try {
            con = dbContext.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, quizId);
            rs = ps.executeQuery();

            Question currentQuestion = null;
            while (rs.next()) {
                int qid = rs.getInt("QuestionID");
                if (currentQuestion == null || currentQuestion.getQuestionID() != qid) {
                    // Tạo câu hỏi mới khi chuyển sang câu hỏi khác
                    currentQuestion = new Question(
                            qid,
                            rs.getString("QuestionContent"),
                            rs.getString("QuestionType"),
                            rs.getString("AnswerKey") // Lấy AnswerKey
                    );
                    questions.add(currentQuestion);
                }

                // Chỉ thêm Option nếu đây là câu hỏi trắc nghiệm và có Option
                currentQuestion.addOption(new QuestionOption(
                        rs.getInt("OptionID"),
                        rs.getInt("QuestionID"), // Thêm dòng này
                        rs.getString("OptionContent"),
                        rs.getBoolean("IsCorrect")
                ));
            }
        } finally {
            closeResources(rs, ps, con);
        }
        return questions;
    }
// src/com/yourcompany/dao/QuizDAO.java
// ...
// Phương thức này hiện tại chỉ trả về SelectedOptionID.
// Để hỗ trợ tự luận, bạn có thể tạo một phương thức trả về List<QuizAttemptDetail>
// Hoặc thay đổi Map này để chứa cả text. Ví dụ:
// Add or update the following method inside your QuizDAO class

    public List<QuizAttemptDetail> getQuizAttemptDetailsForAttempt(int attemptId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<QuizAttemptDetail> details = new ArrayList<>();
        String sql = "SELECT AttemptDetailID, AttemptID, QuestionID, SelectedOptionID, UserAnswerText, IsMarked, UploadedFilePath "
                + "FROM QuizAttemptDetails WHERE AttemptID = ?";
        try {
            con = dbContext.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, attemptId);
            rs = ps.executeQuery();
            while (rs.next()) {
                QuizAttemptDetail detail = new QuizAttemptDetail(
                        rs.getInt("AttemptDetailID"),
                        rs.getInt("AttemptID"),
                        rs.getInt("QuestionID"),
                        rs.getObject("SelectedOptionID") != null ? rs.getInt("SelectedOptionID") : null,
                        rs.getString("UserAnswerText"),
                        rs.getBoolean("IsMarked")
                );
                detail.setUploadedFilePath(rs.getString("UploadedFilePath"));
                details.add(detail);
            }
        } finally {
            closeResources(rs, ps, con);
        }
        return details;
    }

// src/com/yourcompany/dao/QuizDAO.java
// ...
    public void saveUserAnswers(int attemptId, int questionId, List<Integer> selectedOptionIds, String userAnswerText, String uploadedFilePath) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement deletePs = null;
        PreparedStatement insertPs = null;
        try {
            con = dbContext.getConnection();
            con.setAutoCommit(false); // Bắt đầu transaction

            // Xóa câu trả lời cũ của câu hỏi này trong attempt hiện tại
            String deleteSql = "DELETE FROM QuizAttemptDetails WHERE AttemptID = ? AND QuestionID = ?";
            deletePs = con.prepareStatement(deleteSql);
            deletePs.setInt(1, attemptId);
            deletePs.setInt(2, questionId);
            deletePs.executeUpdate();

            // Lưu câu trả lời mới
            if (selectedOptionIds != null && !selectedOptionIds.isEmpty()) {
                // Lưu cho câu hỏi trắc nghiệm
                String insertOptionSql = "INSERT INTO QuizAttemptDetails (AttemptID, QuestionID, SelectedOptionID) VALUES (?, ?, ?)";
                insertPs = con.prepareStatement(insertOptionSql);
                for (Integer optionId : selectedOptionIds) {
                    insertPs.setInt(1, attemptId);
                    insertPs.setInt(2, questionId);
                    insertPs.setInt(3, optionId);
                    insertPs.addBatch();
                }
                insertPs.executeBatch();
            } else if ((userAnswerText != null && !userAnswerText.trim().isEmpty()) || (uploadedFilePath != null && !uploadedFilePath.isEmpty())) {
                // Lưu cho câu hỏi tự luận (có thể có file hoặc không)
                String insertTextSql = "INSERT INTO QuizAttemptDetails (AttemptID, QuestionID, UserAnswerText, UploadedFilePath) VALUES (?, ?, ?, ?)";
                insertPs = con.prepareStatement(insertTextSql);
                insertPs.setInt(1, attemptId);
                insertPs.setInt(2, questionId);
                insertPs.setString(3, userAnswerText != null ? userAnswerText.trim() : null);
                insertPs.setString(4, uploadedFilePath != null ? uploadedFilePath.trim() : null);
                insertPs.executeUpdate();
            }

            con.commit(); // Hoàn tất transaction
        } catch (SQLException e) {
            if (con != null) {
                con.rollback(); // Rollback nếu có lỗi
            }
            throw e;
        } finally {
            if (con != null) {
                con.setAutoCommit(true); // Trở về auto-commit mặc định
            }
            closeResources(null, deletePs, null);
            closeResources(null, insertPs, con);
        }
    }

    public int createNewQuizAttempt(int userId, int quizId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int attemptId = -1;
        String sql = "INSERT INTO QuizAttempts (UserID, QuizID, StartTime) VALUES (?, ?, GETDATE()); SELECT SCOPE_IDENTITY() AS AttemptID;";
        try {
            con = dbContext.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, quizId);
            ps.executeUpdate();

            rs = ps.getGeneratedKeys(); // Dùng getGeneratedKeys() cho IDENTITY column
            if (rs.next()) {
                attemptId = rs.getInt(1); // Lấy giá trị của cột đầu tiên (AttemptID)
            }
        } finally {
            closeResources(rs, ps, con);
        }
        return attemptId;
    }

    public void saveUserAnswers(int attemptId, int questionId, List<Integer> selectedOptionIds) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement deletePs = null;
        PreparedStatement insertPs = null;
        try {
            con = dbContext.getConnection();
            con.setAutoCommit(false); // Bắt đầu transaction

            // Xóa câu trả lời cũ của câu hỏi này trong attempt hiện tại
            String deleteSql = "DELETE FROM QuizAttemptDetails WHERE AttemptID = ? AND QuestionID = ?";
            deletePs = con.prepareStatement(deleteSql);
            deletePs.setInt(1, attemptId);
            deletePs.setInt(2, questionId);
            deletePs.executeUpdate();

            // Lưu câu trả lời mới
            if (selectedOptionIds != null && !selectedOptionIds.isEmpty()) {
                String insertSql = "INSERT INTO QuizAttemptDetails (AttemptID, QuestionID, SelectedOptionID) VALUES (?, ?, ?)";
                insertPs = con.prepareStatement(insertSql);
                for (Integer optionId : selectedOptionIds) {
                    insertPs.setInt(1, attemptId);
                    insertPs.setInt(2, questionId);
                    insertPs.setInt(3, optionId);
                    insertPs.addBatch();
                }
                insertPs.executeBatch();
            }
            con.commit(); // Hoàn tất transaction
        } catch (SQLException e) {
            if (con != null) {
                con.rollback(); // Rollback nếu có lỗi
            }
            throw e;
        } finally {
            if (con != null) {
                con.setAutoCommit(true); // Trở về auto-commit mặc định
            }
            closeResources(null, deletePs, null); // Close deletePs
            closeResources(null, insertPs, con); // Close insertPs and main connection
        }
    }

    public Map<Integer, List<Integer>> getUserAnswersForAttempt(int attemptId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Map<Integer, List<Integer>> userAnswersMap = new HashMap<>();
        String sql = "SELECT QuestionID, SelectedOptionID FROM QuizAttemptDetails WHERE AttemptID = ?";
        try {
            con = dbContext.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, attemptId);
            rs = ps.executeQuery();
            while (rs.next()) {
                int questionId = rs.getInt("QuestionID");
                int selectedOptionId = rs.getInt("SelectedOptionID");
                userAnswersMap.computeIfAbsent(questionId, k -> new ArrayList<>()).add(selectedOptionId);
            }
        } finally {
            closeResources(rs, ps, con);
        }
        return userAnswersMap;
    }

    public Map<Integer, List<Integer>> getCorrectAnswersForQuiz(int quizId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Map<Integer, List<Integer>> correctAnswersMap = new HashMap<>();
        String sql = "SELECT q.QuestionID, qo.OptionID FROM Questions q JOIN QuestionOptions qo ON q.QuestionID = qo.QuestionID WHERE q.QuizID = ? AND qo.IsCorrect = 1";
        try {
            con = dbContext.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, quizId);
            rs = ps.executeQuery();
            while (rs.next()) {
                int questionId = rs.getInt("QuestionID");
                int correctOptionId = rs.getInt("OptionID");
                correctAnswersMap.computeIfAbsent(questionId, k -> new ArrayList<>()).add(correctOptionId);
            }
        } finally {
            closeResources(rs, ps, con);
        }
        return correctAnswersMap;
    }

    public void updateQuizAttemptResult(int attemptId, double score, boolean isPassed) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement ps = null;
        String sql = "UPDATE QuizAttempts SET EndTime = GETDATE(), Score = ?, IsPassed = ? WHERE AttemptID = ?";
        try {
            con = dbContext.getConnection();
            ps = con.prepareStatement(sql);
            ps.setDouble(1, score);
            ps.setBoolean(2, isPassed);
            ps.setInt(3, attemptId);
            ps.executeUpdate();
        } finally {
            closeResources(null, ps, con);
        }
    }

    // Helper method to close resources
    private void closeResources(AutoCloseable... resources) {
        for (AutoCloseable res : resources) {
            try {
                if (res != null) {
                    res.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public Quiz getQuizById2(int quizId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Quiz quiz = null;
        String sql = "SELECT QuizID, QuizName, Subject, Level, NumQuestions, DurationMinutes, PassRate, QuizType FROM Quizzes WHERE QuizID = ?";
        try {
            con = dbContext.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, quizId);
            rs = ps.executeQuery();
            if (rs.next()) {
                quiz = new Quiz(
                        rs.getInt("QuizID"),
                        rs.getString("QuizName"),
                        rs.getString("Subject"),
                        rs.getString("Level"),
                        rs.getInt("NumQuestions"),
                        rs.getInt("DurationMinutes"),
                        rs.getDouble("PassRate"),
                        rs.getString("QuizType")
                );
            }
        } finally {
            closeResources(rs, ps, con);
        }
        return quiz;
    }

    public List<Quiz> getQuizByLessonID(int lessonID) {
        List<Quiz> quizzes = new ArrayList<>();
        String sql = "SELECT * FROM Quizzes WHERE LessonID = ?";

        try (Connection con = dbContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, lessonID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setQuizID(rs.getInt("QuizID"));
                    quiz.setLessonID(rs.getInt("LessonID"));
                    quiz.setCourseID(rs.getInt("CourseID"));
                    quiz.setQuizName(rs.getString("QuizName"));
                    quiz.setSubject(rs.getString("Subject"));
                    quiz.setLevel(rs.getString("Level"));
                    quiz.setNumQuestions(rs.getInt("NumQuestions"));
                    quiz.setDurationMinutes(rs.getInt("DurationMinutes"));
                    quiz.setPassRate(rs.getDouble("PassRate"));
                    quiz.setQuizType(rs.getString("QuizType"));
                    quiz.setQuestionOrder(rs.getInt("QuestionOrder"));
                    quiz.setCreatedAt(rs.getDate("CreatedAt"));
                    quiz.setUpdatedAt(rs.getDate("UpdatedAt"));
                    quiz.setStatus(rs.getBoolean("Status"));
                    quizzes.add(quiz);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
        }

        return quizzes;
    }
}
