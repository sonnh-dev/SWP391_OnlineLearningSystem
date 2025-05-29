package model;

public class BlogContent {

    private int blogID;
    private String content;

    public BlogContent() {
    }

    public BlogContent(int blogID, String content) {
        this.blogID = blogID;
        this.content = content;
    }

    public int getBlogID() {
        return blogID;
    }

    public void setBlogID(int blogID) {
        this.blogID = blogID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
