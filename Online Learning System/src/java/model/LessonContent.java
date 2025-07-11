/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author sonpk
 */
public class LessonContent {

    private int lessonID;
    private String docContent;
    private String videoURL;

    public LessonContent() {
    }

    public LessonContent(int lessonID, String docContent, String videoURL) {
        this.lessonID = lessonID;
        this.docContent = docContent;
        this.videoURL = videoURL;
    }

    public int getLessonID() {
        return lessonID;
    }

    public void setLessonID(int lessonID) {
        this.lessonID = lessonID;
    }

    public String getDocContent() {
        return docContent;
    }

    public void setDocContent(String docContent) {
        this.docContent = docContent;
    }

    public String getVideoURL() {
        return videoURL;
    }

    public void setVideoURL(String videoURL) {
        this.videoURL = videoURL;
    }

}
