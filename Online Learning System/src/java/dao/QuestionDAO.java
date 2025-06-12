package dao;
import context.DBContextF;
import model.Question;
import model.QuestionOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class QuestionDAO extends DBContextF {

    public List<Question> getQuestionsByQuizId(int quizId) throws ClassNotFoundException {
        List<Question> questions = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            String sql = "SELECT QuestionID, QuizID, QuestionContent, QuestionType FROM Questions WHERE QuizID = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, quizId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Question question = new Question();
                question.setQuestionID(rs.getInt("QuestionID"));
                question.setQuizID(rs.getInt("QuizID"));
                question.setQuestionContent(rs.getString("QuestionContent"));
                question.setQuestionType(rs.getString("QuestionType"));
                // Lấy các lựa chọn cho mỗi câu hỏi
                question.setOptions(getOptionsByQuestionId(question.getQuestionID()));
                questions.add(question);
            }
        } catch (SQLException e) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources(conn, ps, rs);
        }
        return questions;
    }

    public List<QuestionOption> getOptionsByQuestionId(int questionId) throws ClassNotFoundException {
        List<QuestionOption> options = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            String sql = "SELECT OptionID, QuestionID, OptionContent, IsCorrect FROM QuestionOptions WHERE QuestionID = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, questionId);
            rs = ps.executeQuery();
            while (rs.next()) {
                QuestionOption option = new QuestionOption();
                option.setOptionID(rs.getInt("OptionID"));
                option.setQuestionID(rs.getInt("QuestionID"));
                option.setOptionContent(rs.getString("OptionContent"));
                option.setIsCorrect(rs.getBoolean("IsCorrect"));
                options.add(option);
            }
        } catch (SQLException e) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources(conn, ps, rs);
        }
        return options;
    }
    
    public Question getQuestionById(int questionId) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Question question = null;
        try {
            conn = getConnection();
            String sql = "SELECT QuestionID, QuizID, QuestionContent, QuestionType FROM Questions WHERE QuestionID = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, questionId);
            rs = ps.executeQuery();
            if (rs.next()) {
                question = new Question();
                question.setQuestionID(rs.getInt("QuestionID"));
                question.setQuizID(rs.getInt("QuizID"));
                question.setQuestionContent(rs.getString("QuestionContent"));
                question.setQuestionType(rs.getString("QuestionType"));
                question.setOptions(getOptionsByQuestionId(question.getQuestionID())); // Lấy luôn options
            }
        } catch (SQLException e) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources(conn, ps, rs);
        }
        return question;
    }

    public int addQuestion(Question question) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int generatedId = -1;
        String sql = "INSERT INTO Questions (QuizID, QuestionContent, QuestionType) VALUES (?, ?, ?)";
        try {
            conn = getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, question.getQuizID());
            ps.setString(2, question.getQuestionContent());
            ps.setString(3, question.getQuestionType());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                    // Thêm các lựa chọn sau khi có QuestionID
                    for (QuestionOption option : question.getOptions()) {
                        addQuestionOption(conn, generatedId, option);
                    }
                }
            }
            conn.commit();
        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, "Lỗi khi thêm Question mới", e);
        } finally {
            closeResources(conn, ps, rs);
        }
        return generatedId;
    }

    private void addQuestionOption(Connection conn, int questionId, QuestionOption option) throws SQLException {
        String sql = "INSERT INTO QuestionOptions (QuestionID, OptionContent, IsCorrect) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, questionId);
            ps.setString(2, option.getOptionContent());
            ps.setBoolean(3, option.isIsCorrect());
            ps.executeUpdate();
        }
    }

    public boolean updateQuestion(Question question) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean success = false;
        String sql = "UPDATE Questions SET QuestionContent = ?, QuestionType = ? WHERE QuestionID = ?";
        try {
            conn = getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction

            // 1. Cập nhật câu hỏi chính
            ps = conn.prepareStatement(sql);
            ps.setString(1, question.getQuestionContent());
            ps.setString(2, question.getQuestionType());
            ps.setInt(3, question.getQuestionID());
            int affectedRows = ps.executeUpdate();
            ps.close();

            if (affectedRows > 0) {
                // 2. Xóa tất cả các lựa chọn cũ của câu hỏi này
                String deleteOptionsSql = "DELETE FROM QuestionOptions WHERE QuestionID = ?";
                ps = conn.prepareStatement(deleteOptionsSql);
                ps.setInt(1, question.getQuestionID());
                ps.executeUpdate();
                ps.close();

                // 3. Thêm lại các lựa chọn mới
                for (QuestionOption option : question.getOptions()) {
                    addQuestionOption(conn, question.getQuestionID(), option);
                }
                success = true;
            }
            conn.commit();
        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, "Lỗi khi cập nhật Question", e);
        } finally {
            closeResources(conn, ps, null);
        }
        return success;
    }

    public void deleteQuestion(int questionId) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction

            // Xóa QuestionOptions trước
            String deleteOptionsSql = "DELETE FROM QuestionOptions WHERE QuestionID = ?";
            ps = conn.prepareStatement(deleteOptionsSql);
            ps.setInt(1, questionId);
            ps.executeUpdate();
            ps.close();

            // Xóa Questions
            String deleteQuestionSql = "DELETE FROM Questions WHERE QuestionID = ?";
            ps = conn.prepareStatement(deleteQuestionSql);
            ps.setInt(1, questionId);
            ps.executeUpdate();

            conn.commit();
        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, "Lỗi khi xóa Question", e);
        } finally {
            closeResources(conn, ps, null);
        }
    }

    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            Logger.getLogger(QuestionDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }
}