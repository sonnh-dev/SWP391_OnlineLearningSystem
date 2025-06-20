package model.course;

/**
 *
 * @author sonpk
 */
public class UserCourse {

    private int userID;
    private int courseID;
    private int packageID;
    private String enrollDate;
    private double progress;
    private String status;
    private String validFrom;
    private String validTo;

    public UserCourse() {
    }

    public UserCourse(int userID, int courseID, int packageID, String enrollDate, double progress, String status, String validFrom, String validTo) {
        this.userID = userID;
        this.courseID = courseID;
        this.packageID = packageID;
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

    public int getPackageID() {
        return packageID;
    }

    public void setPackageID(int packageID) {
        this.packageID = packageID;
    }

    public String getEnrollDate() {
        return enrollDate;
    }

    public void setEnrollDate(String enrollDate) {
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
