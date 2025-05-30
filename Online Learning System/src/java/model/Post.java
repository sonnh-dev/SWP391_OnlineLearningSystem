/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class Post {
    private int blogID;
    private int userID;
    private String title;
    private Date date;
    private String category;
    private String imageURL;
    private int totalView;
    private String summary;

    // Constructors
    public Post() {}

    public Post(int blogID, int userID, String title, Date date, String category, String imageURL, int totalView, String summary) {
        this.blogID = blogID;
        this.userID = userID;
        this.title = title;
        this.date = date;
        this.category = category;
        this.imageURL = imageURL;
        this.totalView = totalView;
        this.summary = summary;
    }

    // Getters and Setters
    public int getBlogID() { return blogID; }
    public void setBlogID(int blogID) { this.blogID = blogID; }

    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getImageURL() { return imageURL; }
    public void setImageURL(String imageURL) { this.imageURL = imageURL; }

    public int getTotalView() { return totalView; }
    public void setTotalView(int totalView) { this.totalView = totalView; }

    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }
}

