
package model;

public class Blog {
    private int id;
    private String title;
    private String summary;
    private String content;
    private int authorID;
    private String date;
    private String tags;
    private String imageUrl;
    private int totalView;

    public Blog() {
    }

    public Blog(int id, String title, String summary, String content, int authorID, String date, String tags, String imageUrl, int totalView) {
        this.id = id;
        this.title = title;
        this.summary = summary;
        this.content = content;
        this.authorID = authorID;
        this.date = date;
        this.tags = tags;
        this.imageUrl = imageUrl;
        this.totalView = totalView;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getAuthorID() {
        return authorID;
    }

    public void setAuthorID(int authorID) {
        this.authorID = authorID;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
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


}
