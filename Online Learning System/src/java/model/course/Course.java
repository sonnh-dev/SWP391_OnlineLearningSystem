
package model.course;

import java.util.Date;

public class Course {
    private int courseID;
    private String title;
    private String category;
    private int lectures;
    private String imageURL;
    private String courseShortDescription;
    private String description;
    private Date updateDate;
    private int totalEnrollment;

    public Course() {
    }

    public Course(int courseID, String title, String category, int lectures, String imageURL, String courseShortDescription, String description, Date updateDate, int totalEnrollment) {
        this.courseID = courseID;
        this.title = title;
        this.category = category;
        this.lectures = lectures;
        this.imageURL = imageURL;
        this.courseShortDescription = courseShortDescription;
        this.description = description;
        this.updateDate = updateDate;
        this.totalEnrollment = totalEnrollment;
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

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getLectures() {
        return lectures;
    }

    public void setLectures(int lectures) {
        this.lectures = lectures;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getCourseShortDescription() {
        return courseShortDescription;
    }

    public void setCourseShortDescription(String courseShortDescription) {
        this.courseShortDescription = courseShortDescription;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public int getTotalEnrollment() {
        return totalEnrollment;
    }

    public void setTotalEnrollment(int totalEnrollment) {
        this.totalEnrollment = totalEnrollment;
    }

}