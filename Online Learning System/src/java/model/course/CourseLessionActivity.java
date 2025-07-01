package model.course;

/**
 *
 * @author sonpk
 */
public class CourseLessionActivity {

    private int activityID;
    private int userID;
    private int courseID;
    private int lessonID;
    private boolean isCompleted;

    public CourseLessionActivity() {
    }

    public CourseLessionActivity(int activityID, int userID, int courseID, int lessonID, boolean isCompleted) {
        this.activityID = activityID;
        this.userID = userID;
        this.courseID = courseID;
        this.lessonID = lessonID;
        this.isCompleted = isCompleted;
    }

    public int getActivityID() {
        return activityID;
    }

    public void setActivityID(int activityID) {
        this.activityID = activityID;
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

    public int getLessonID() {
        return lessonID;
    }

    public void setLessonID(int lessonID) {
        this.lessonID = lessonID;
    }

    public boolean isIsCompleted() {
        return isCompleted;
    }

    public void setIsCompleted(boolean isCompleted) {
        this.isCompleted = isCompleted;
    }

}
