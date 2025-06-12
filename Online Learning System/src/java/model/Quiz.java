/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Date;
/**
 *
 * @author phucn
 */
public class Quiz {
      private int quizID;
    private Integer lessonID; // Có thể NULL
    private Integer courseID; // Có thể NULL
    private String quizName;
    private String subject;
    private String level;
    private int numQuestions;
    private int durationMinutes;
    private double passRate;
    private String quizType;
    private Integer questionOrder; // Có thể NULL
    private Date createdAt;

    public int getQuizID() {
        return quizID;
    }

    public void setQuizID(int quizID) {
        this.quizID = quizID;
    }

    public Integer getLessonID() {
        return lessonID;
    }

    public void setLessonID(Integer lessonID) {
        this.lessonID = lessonID;
    }

    public Integer getCourseID() {
        return courseID;
    }

    public void setCourseID(Integer courseID) {
        this.courseID = courseID;
    }

    public String getQuizName() {
        return quizName;
    }

    public void setQuizName(String quizName) {
        this.quizName = quizName;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public int getNumQuestions() {
        return numQuestions;
    }

    public void setNumQuestions(int numQuestions) {
        this.numQuestions = numQuestions;
    }

    public int getDurationMinutes() {
        return durationMinutes;
    }

    public void setDurationMinutes(int durationMinutes) {
        this.durationMinutes = durationMinutes;
    }

    public double getPassRate() {
        return passRate;
    }

    public void setPassRate(double passRate) {
        this.passRate = passRate;
    }

    public String getQuizType() {
        return quizType;
    }

    public void setQuizType(String quizType) {
        this.quizType = quizType;
    }

    public Integer getQuestionOrder() {
        return questionOrder;
    }

    public void setQuestionOrder(Integer questionOrder) {
        this.questionOrder = questionOrder;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Quiz() {
    }

    public Quiz(int quizID, Integer lessonID, Integer courseID, String quizName, String subject, String level, int numQuestions, int durationMinutes, double passRate, String quizType, Integer questionOrder, Date createdAt, Date updatedAt) {
        this.quizID = quizID;
        this.lessonID = lessonID;
        this.courseID = courseID;
        this.quizName = quizName;
        this.subject = subject;
        this.level = level;
        this.numQuestions = numQuestions;
        this.durationMinutes = durationMinutes;
        this.passRate = passRate;
        this.quizType = quizType;
        this.questionOrder = questionOrder;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    private Date updatedAt;
}
