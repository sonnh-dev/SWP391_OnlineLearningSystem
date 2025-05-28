
package model;

public class Blog {
    private int blogID;
    private int userID;
    private String title;
    private String date;
    private String category;
    private String imageUrl;
    private int totalView;
    private String summary;

    public Blog() {
    }

    public Blog(int blogID, int userID, String title, String date, String category, String imageUrl, int totalView, String summary) {
        this.blogID = blogID;
        this.userID = userID;
        this.title = title;
        this.date = date;
        this.category = category;
        this.imageUrl = imageUrl;
        this.totalView = totalView;
        this.summary = summary;
    }

    public int getBlogID() {
        return blogID;
    }

    public void setBlogID(int blogID) {
        this.blogID = blogID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getTotalView() {
        return totalView;
    }

    public void setTotalView(int totalView) {
        this.totalView = totalView;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

}
