package model.course;

import java.util.Date;

/**
 *
 * @author sonpk
 */
public class UserCourse {

    private int userID;
    private int courseID;
    private String title;
    private String imageURL;
    private String description;
    private String pkgName;
    private Double price;
    private Date enrollDate;
    private double progress;
    private String status;
    private String validFrom;
    private String validTo;

    public UserCourse() {
    }

    public UserCourse(int userID, int courseID, String title, String imageURL, String description, String pkgName, Double price, Date enrollDate, double progress, String status, String validFrom, String validTo) {
        this.userID = userID;
        this.courseID = courseID;
        this.title = title;
        this.imageURL = imageURL;
        this.description = description;
        this.pkgName = pkgName;
        this.price = price;
        this.enrollDate = enrollDate;
        this.progress = progress;
        this.status = status;
        this.validFrom = validFrom;
        this.validTo = validTo;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
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

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPkgName() {
        return pkgName;
    }

    public void setPkgName(String pkgName) {
        this.pkgName = pkgName;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Date getEnrollDate() {
        return enrollDate;
    }

    public void setEnrollDate(Date enrollDate) {
        this.enrollDate = enrollDate;
    }

    public double getProgress() {
        return progress;
    }

    public void setProgress(double progress) {
        this.progress = progress;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(String validFrom) {
        this.validFrom = validFrom;
    }

    public String getValidTo() {
        return validTo;
    }

    public void setValidTo(String validTo) {
        this.validTo = validTo;
    }

}
