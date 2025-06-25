package model.course;

import java.util.Date;
import java.util.List;

/**
 *
 * @author sonpk
 */
public class CourseList {
    private int courseID;
    private String title;
    private String category;
    private int lectures;
    private String imageURL;
    private String courseShortDescription;
    private Date updateDate;
    private int totalEnrollment;
    private int rating;
    private List<CoursePackage> coursePackage;

    public CourseList() {
    }

    public CourseList(int courseID, String title, String category, int lectures, String imageURL, String courseShortDescription, Date updateDate, int totalEnrollment, int rating, List<CoursePackage> coursePackage) {
        this.courseID = courseID;
        this.title = title;
        this.category = category;
        this.lectures = lectures;
        this.imageURL = imageURL;
        this.courseShortDescription = courseShortDescription;
        this.updateDate = updateDate;
        this.totalEnrollment = totalEnrollment;
        this.rating = rating;
        this.coursePackage = coursePackage;
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

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public List<CoursePackage> getCoursePackage() {
        return coursePackage;
    }

    public void setCoursePackage(List<CoursePackage> coursePackage) {
        this.coursePackage = coursePackage;
    }
    
    
}
