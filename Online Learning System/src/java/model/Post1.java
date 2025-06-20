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
public class Post1 {
    private int postID;
    private String title;
    private String briefInfo;
    private String description;
    private String postinfo;
    private String category;
    private String status;
    private boolean isFeatured;
    private String thumbnailURL;
    private Date createdDate; // ➕ Thêm thuộc tính mới

    public Post1() {
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBriefInfo() {
        return briefInfo;
    }

    public void setBriefInfo(String briefInfo) {
        this.briefInfo = briefInfo;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPostinfo() {
        return postinfo;
    }

   public void setPostinfo(String postinfo) { // Thêm phương thức setter này (nếu bạn cần thiết lập giá trị)
        this.postinfo = postinfo;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isFeatured() {
        return isFeatured;
    }

    public void setIsFeatured(boolean isFeatured) {
        this.isFeatured = isFeatured;
    }

    public String getThumbnailURL() {
        return thumbnailURL;
    }

    public void setThumbnailURL(String thumbnailURL) {
        this.thumbnailURL = thumbnailURL;
    }

    public Date getCreatedDate() { // ➕ Getter cho createdDate
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) { // ➕ Setter cho createdDate
        this.createdDate = createdDate;
    }
}
