package model.course;

/**
 *
 * @author sonpk
 */
public class CourseReviewMedia {

    private int mediaID;
    private int reviewID;
    private String mediaURL;
    private boolean video;
    private String caption;

    public CourseReviewMedia() {
    }

    public CourseReviewMedia(int mediaID, int reviewID, String mediaURL, boolean video, String caption) {
        this.mediaID = mediaID;
        this.reviewID = reviewID;
        this.mediaURL = mediaURL;
        this.video = video;
        this.caption = caption;
    }

    public int getMediaID() {
        return mediaID;
    }

    public void setMediaID(int mediaID) {
        this.mediaID = mediaID;
    }

    public int getReviewID() {
        return reviewID;
    }

    public void setReviewID(int reviewID) {
        this.reviewID = reviewID;
    }

    public String getMediaURL() {
        return mediaURL;
    }

    public void setMediaURL(String mediaURL) {
        this.mediaURL = mediaURL;
    }

    public boolean isVideo() {
        return video;
    }

    public void setVideo(boolean video) {
        this.video = video;
    }

    public String getCaption() {
        return caption;
    }

    public void setCaption(String caption) {
        this.caption = caption;
    }

}
