package model;

import java.util.ArrayList;
import java.util.List;

public class Question {

    public List<Integer> getUserSelectedOptionIds() {
        return userSelectedOptionIds;
    }

    private int questionID;
    private int quizID;
    private String questionContent;
    private String questionType;
    private List<QuestionOption> options;
//    private List<Option> options;
    private List<Integer> userSelectedOptionIds;

    public Question() {
        this.options = new ArrayList<>();
        this.userSelectedOptionIds = new ArrayList<>();
    }

    public Question(int questionId, String questionContent, String questionType) {
        this();
        this.questionID = questionId;
        this.questionContent = questionContent;
        this.questionType = questionType;
    }

    // Methods to manage options and user answers
//    public void addOption(Option option) {
//        this.options.add(option);
//    }
    public void addOption(QuestionOption option) {
        this.options.add(option);
    }

    public List<QuestionOption> getOptions() {
        return options;
    }

    public void setOptions(List<QuestionOption> options) {
        this.options = options;
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

//    public List<QuestionOption> getOptions() {
//        return options;
//    }
//
//    public void setOptions(List<QuestionOption> options) {
//        this.options = options;
//    }
}
