/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author phucn
 */
public class QuizAttempt {

    private int attemptId;
    private int userId;
    private int quizId;
    private Date startTime;
    private Date endTime;
    private double score;
    private Boolean isPassed; // Dùng Boolean để có thể NULL nếu chưa hoàn thành

    // Constructors
    public QuizAttempt() {
    }

    public QuizAttempt(int attemptId, int userId, int quizId, Date startTime, Date endTime, double score, Boolean isPassed) {
        this.attemptId = attemptId;
        this.userId = userId;
        this.quizId = quizId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.score = score;
        this.isPassed = isPassed;
    }

    // Getters and Setters
    public int getAttemptId() {
        return attemptId;
    }

    public void setAttemptId(int attemptId) {
        this.attemptId = attemptId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public Boolean getIsPassed() {
        return isPassed;
    }

    public void setIsPassed(Boolean isPassed) {
        this.isPassed = isPassed;
    }
}
