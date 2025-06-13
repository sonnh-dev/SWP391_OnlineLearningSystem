package model.course;

public class CourseAdditional {

    private int courseID;
    private String contentURL;
    private Boolean isVideo;
    private String caption;
    private String content;

    public CourseAdditional() {
    }

    public CourseAdditional(int courseID, String contentURL, Boolean isVideo, String caption, String content) {
        this.courseID = courseID;
        this.contentURL = contentURL;
        this.isVideo = isVideo;
        this.caption = caption;
        this.content = content;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public String getContentURL() {
        return contentURL;
    }

    public void setContentURL(String contentURL) {
        this.contentURL = contentURL;
    }

    public Boolean getIsVideo() {
        return isVideo;
    }

    public void setIsVideo(Boolean isVideo) {
        this.isVideo = isVideo;
    }

    public String getCaption() {
        return caption;
    }

    public void setCaption(String caption) {
        this.caption = caption;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

}
