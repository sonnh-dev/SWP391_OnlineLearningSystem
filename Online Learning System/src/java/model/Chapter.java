/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author sonpk
 */
public class Chapter {

    private int chapterID;
    private int courseID;
    private String title;
    private int chapterOrder;

    public Chapter() {
    }

    public Chapter(int chapterID, int courseID, String title, int chapterOrder) {
        this.chapterID = chapterID;
        this.courseID = courseID;
        this.title = title;
        this.chapterOrder = chapterOrder;
    }

    public int getChapterID() {
        return chapterID;
    }

    public void setChapterID(int chapterID) {
        this.chapterID = chapterID;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getChapterOrder() {
        return chapterOrder;
    }

    public void setChapterOrder(int chapterOrder) {
        this.chapterOrder = chapterOrder;
    }
}
