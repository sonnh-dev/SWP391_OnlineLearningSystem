package model;

/**
 *
 * @author sonpk
 */
public class Lesson {

    private int lessonID;
    private int chapterID;
    private String title;
    private boolean isFree;
    private int lessonOrder;
 private Boolean status;  

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }
    public Lesson() {
    }

    public Lesson(int lessonID, int chapterID, String title, boolean isFree, int lessonOrder) {
        this.lessonID = lessonID;
        this.chapterID = chapterID;
        this.title = title;
        this.isFree = isFree;
        this.lessonOrder = lessonOrder;
    }

    public int getLessonID() {
        return lessonID;
    }

    public void setLessonID(int lessonID) {
        this.lessonID = lessonID;
    }

    public int getChapterID() {
        return chapterID;
    }

    public void setChapterID(int chapterID) {
        this.chapterID = chapterID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public boolean isIsFree() {
        return isFree;
    }

    public void setIsFree(boolean isFree) {
        this.isFree = isFree;
    }

    public int getLessonOrder() {
        return lessonOrder;
    }

    public void setLessonOrder(int lessonOrder) {
        this.lessonOrder = lessonOrder;
    }
}
