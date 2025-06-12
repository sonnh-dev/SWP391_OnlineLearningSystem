package model;

import java.util.List;

public class Question {

    private int questionID;
    private int quizID;
    private String questionContent;
    private String questionType;
    private List<QuestionOption> options; // Danh sách các lựa chọn cho câu hỏi này

    public Question() {
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

    public List<QuestionOption> getOptions() {
        return options;
    }

    public void setOptions(List<QuestionOption> options) {
        this.options = options;
    }
}
