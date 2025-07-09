/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author phucn
 */
public class QuizAttemptDetail {

    private int attemptDetailId;
    private int attemptId;
    private int questionId;
    private Integer selectedOptionId; // NULL nếu câu hỏi tự luận hoặc chưa chọn
    private String userAnswerText; // Cho câu hỏi tự luận
    private boolean isMarked; // Đánh dấu để xem lại
    private String uploadedFilePath;

    public String getUploadedFilePath() {
        return uploadedFilePath;
    }

    public void setUploadedFilePath(String uploadedFilePath) {
        this.uploadedFilePath = uploadedFilePath;
    }

    // Constructors
    public QuizAttemptDetail() {
    }

    public QuizAttemptDetail(int attemptDetailId, int attemptId, int questionId, Integer selectedOptionId, String userAnswerText, boolean isMarked) {
        this.attemptDetailId = attemptDetailId;
        this.attemptId = attemptId;
        this.questionId = questionId;
        this.selectedOptionId = selectedOptionId;
        this.userAnswerText = userAnswerText;
        this.isMarked = isMarked;
    }

    // Getters and Setters
    public int getAttemptDetailId() {
        return attemptDetailId;
    }

    public void setAttemptDetailId(int attemptDetailId) {
        this.attemptDetailId = attemptDetailId;
    }

    public int getAttemptId() {
        return attemptId;
    }

    public void setAttemptId(int attemptId) {
        this.attemptId = attemptId;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public Integer getSelectedOptionId() {
        return selectedOptionId;
    }

    public void setSelectedOptionId(Integer selectedOptionId) {
        this.selectedOptionId = selectedOptionId;
    }

    public String getUserAnswerText() {
        return userAnswerText;
    }

    public void setUserAnswerText(String userAnswerText) {
        this.userAnswerText = userAnswerText;
    }

    public boolean isMarked() {
        return isMarked;
    }

    public void setMarked(boolean marked) {
        isMarked = marked;
    }
}
