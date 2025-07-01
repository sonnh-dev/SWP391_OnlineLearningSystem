/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author phucn
 */
public class Option {
    private int optionId;
    private String optionContent;
    private boolean isCorrect;

    // Constructors
    public Option() {}

    public Option(int optionId, String optionContent, boolean isCorrect) {
        this.optionId = optionId;
        this.optionContent = optionContent;
        this.isCorrect = isCorrect;
    }

    // Getters and Setters
    public int getOptionId() { return optionId; }
    public void setOptionId(int optionId) { this.optionId = optionId; }
    public String getOptionContent() { return optionContent; }
    public void setOptionContent(String optionContent) { this.optionContent = optionContent; }
    public boolean isCorrect() { return isCorrect; }
    public void setCorrect(boolean correct) { isCorrect = correct; }
}
