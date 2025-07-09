package model;

import java.util.ArrayList;
import java.util.List;

public class Question {

    public List<Integer> getUserSelectedOptionIds() {
        return userSelectedOptionIds;
    }
    private String explanation;
    private int questionID;
    private int quizID;
    private String questionContent;
    private String questionType;
    private List<QuestionOption> options;
//    private List<Option> options;
    private List<Integer> userSelectedOptionIds;
    private String userAnswerText;
    private String answerKey;
    private boolean isMarked;
    private String uploadedFilePath;

    public String getUploadedFilePath() {
        return uploadedFilePath;
    }

    public void setUploadedFilePath(String uploadedFilePath) {
        this.uploadedFilePath = uploadedFilePath;
    }

    public boolean isMarked() { // Getter for boolean isMarked
        return isMarked;
    }

    public String getExplanation() {
        return explanation;
    }

    public void setExplanation(String explanation) {
        this.explanation = explanation;
    }

    public boolean isIsMarked() {
        return isMarked;
    }

    public void setIsMarked(boolean isMarked) {
        this.isMarked = isMarked;
    }

    public void setMarked(boolean marked) { // Setter for isMarked
        isMarked = marked;
    }

    public String getUserAnswerText() {
        return userAnswerText;
    }

    public void setUserAnswerText(String userAnswerText) {
        this.userAnswerText = userAnswerText;
    }

    public String getAnswerKey() {
        return answerKey;
    }

    public void setAnswerKey(String answerKey) {
        this.answerKey = answerKey;
    }

    public void addUserSelectedOptionId(int optionId) {
        this.userSelectedOptionIds.add(optionId);
    }

    public void setUserSelectedOptionIds(List<Integer> optionIds) {
        this.userSelectedOptionIds.clear();
        if (optionIds != null) {
            this.userSelectedOptionIds.addAll(optionIds);
        }
    }

    public boolean isUserSelected(int optionId) {
        return userSelectedOptionIds.contains(optionId);
    }

    public Question() {
        this.options = new ArrayList<>();
        this.userSelectedOptionIds = new ArrayList<>();
        this.isMarked = false; // Default to not marked
    }

    public Question(int questionId, String questionContent, String questionType,
            String explanation, String answerKey, boolean isMarked) {
        this(questionId, questionContent, questionType, answerKey, isMarked); // Gọi constructor phía dưới
        this.explanation = explanation;
    }

    public Question(int questionId, String questionContent, String questionType,
            String answerKey, boolean isMarked) {
        this(); // Gọi constructor mặc định để khởi tạo List
        this.questionID = questionId;
        this.questionContent = questionContent;
        this.questionType = questionType;
        this.answerKey = answerKey;
        this.isMarked = isMarked; // Khởi tạo từ tham số
    }

    public Question(String questionContent, String questionType, String answerKey) {
        this.questionContent = questionContent;
        this.questionType = questionType;
        this.answerKey = answerKey;
    }

    public Question(int questionId, String questionContent, String questionType) {
        this();
        this.questionID = questionId;
        this.questionContent = questionContent;
        this.questionType = questionType;
    }

    // Constructor đầy đủ hơn
    public Question(int questionId, String questionContent, String questionType, String answerKey) {
        this(); // Gọi constructor mặc định để khởi tạo List
        this.questionID = questionId;
        this.questionContent = questionContent;
        this.questionType = questionType;
        this.answerKey = answerKey;
    }

    public void addOption(QuestionOption option) {
        this.options.add(option);
    }

    public List<QuestionOption> getOptions() {
        return options;
    }

    public void setOptions(List<QuestionOption> options) {
        this.options = options;
    }

    // Constructor, Getters, Setters
    public Question(int questionID, int quizID, String questionContent, String questionType) {
        this.questionID = questionID;
        this.quizID = quizID;
        this.questionContent = questionContent;
        this.questionType = questionType;
    }

    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public int getQuizID() {
        return quizID;
    }

    public void setQuizID(int quizID) {
        this.quizID = quizID;
    }

    public String getQuestionContent() {
        return questionContent;
    }

    public void setQuestionContent(String questionContent) {
        this.questionContent = questionContent;
    }

    public String getQuestionType() {
        return questionType;
    }

    public void setQuestionType(String questionType) {
        this.questionType = questionType;
    }

}
