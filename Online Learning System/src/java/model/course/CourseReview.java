package model.course;

import java.util.Date;

/**
 *
 * @author sonpk
 */
public class CourseReview {

    private int reviewID;
    private int userID;
    private int courseID;
    private boolean recommended;
    private String comment;
    private Date createdAt;

    public CourseReview() {
    }

    public CourseReview(int reviewID, int userID, int courseID, boolean isRecommended, String comment, Date createdAt) {
        this.reviewID = reviewID;
        this.userID = userID;
        this.courseID = courseID;
        this.recommended = isRecommended;
        this.comment = comment;
        this.createdAt = createdAt;
    }

    public int getReviewID() {
        return reviewID;
    }

    public void setReviewID(int reviewID) {
        this.reviewID = reviewID;
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

    public boolean isRecommended() {
        return recommended;
    }

    public void setRecommended(boolean recommended) {
        this.recommended = recommended;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

}
