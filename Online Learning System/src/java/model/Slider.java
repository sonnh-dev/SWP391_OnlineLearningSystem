package model;

public class Slider {

    private int sliderID;
    private int courseID;
    private String sliderTitle;
    private String sliderContent;
    private String sliderURL;

    public Slider() {
    }

    public Slider(int sliderID, int courseID, String sliderTitle, String sliderContent, String sliderURL) {
        this.sliderID = sliderID;
        this.courseID = courseID;
        this.sliderTitle = sliderTitle;
        this.sliderContent = sliderContent;
        this.sliderURL = sliderURL;
    }

    public int getSliderID() {
        return sliderID;
    }

    public void setSliderID(int sliderID) {
        this.sliderID = sliderID;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public String getSliderTitle() {
        return sliderTitle;
    }

    public void setSliderTitle(String sliderTitle) {
        this.sliderTitle = sliderTitle;
    }

    public String getSliderContent() {
        return sliderContent;
    }

    public void setSliderContent(String sliderContent) {
        this.sliderContent = sliderContent;
    }

    public String getSliderURL() {
        return sliderURL;
    }

    public void setSliderURL(String sliderURL) {
        this.sliderURL = sliderURL;
    }

}
