/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author phucn
 */
public class QuestionOption {
     private int optionID;
    private int questionID;
    private String optionContent;
    private boolean isCorrect;

    public int getOptionID() {
        return optionID;
    }

    public void setOptionID(int optionID) {
        this.optionID = optionID;
    }

    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public String getOptionContent() {
        return optionContent;
    }

    public void setOptionContent(String optionContent) {
        this.optionContent = optionContent;
    }

    public boolean isIsCorrect() {
        return isCorrect;
    }

    public void setIsCorrect(boolean isCorrect) {
        this.isCorrect = isCorrect;
    }

    public QuestionOption() {
    }

    public QuestionOption(int optionID, int questionID, String optionContent, boolean isCorrect) {
        this.optionID = optionID;
        this.questionID = questionID;
        this.optionContent = optionContent;
        this.isCorrect = isCorrect;
    }
}
