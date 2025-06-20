/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.context2;
import model.Post1;
import model.PostImage;
import model.PostVideo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao1 extends context2 {

    public Post1 getPost(int postId) {
        String sql = "SELECT * FROM Posts WHERE PostID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, postId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Post1 post = new Post1();
                    post.setPostID(rs.getInt("PostID"));
                    post.setTitle(rs.getString("Title"));
                    post.setBriefInfo(rs.getString("BriefInfo"));
                    post.setDescription(rs.getString("Description"));
                    post.setPostinfo(rs.getString("PostInfo"));
                    post.setCategory(rs.getString("Category"));
                    post.setStatus(rs.getString("Status"));
                    post.setIsFeatured(rs.getBoolean("IsFeatured"));
                    post.setThumbnailURL(rs.getString("ThumbnailURL"));
                    post.setCreatedDate(rs.getDate("CreatedDate")); // ✅ Thêm dòng này
                    return post;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<PostImage> getImages(int postId) {
        List<PostImage> list = new ArrayList<>();
        String sql = "SELECT * FROM PostImages WHERE PostID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, postId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PostImage img = new PostImage();
                    img.setImageURL(rs.getString("ImageURL"));
                    img.setDescription(rs.getString("Description"));
                    list.add(img);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<PostVideo> getVideos(int postId) {
        List<PostVideo> list = new ArrayList<>();
        String sql = "SELECT * FROM PostVideos WHERE PostID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, postId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PostVideo video = new PostVideo();
                    video.setVideoURL(rs.getString("VideoURL"));
                    video.setDescription(rs.getString("Description"));
                    list.add(video);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public void updateFeatured(int postId, boolean featured) {
    String sql = "UPDATE Post SET Featured = ? WHERE PostID = ?";

    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setBoolean(1, featured);
        ps.setInt(2, postId);
        ps.executeUpdate();

    } catch (SQLException e) {
        e.printStackTrace(); // log properly in real-world use
    }
}
// Cập nhật nội dung chính của bài viết
public void updatePost(Post1 post) {
    String sql = "UPDATE Posts SET Title = ?, BriefInfo = ?, Description = ?, PostInfo = ?, " +
                 "Category = ?, Status = ?, IsFeatured = ? WHERE PostID = ?";
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, post.getTitle());
        ps.setString(2, post.getBriefInfo());
        ps.setString(3, post.getDescription());
        ps.setString(4, post.getPostinfo());
        ps.setString(5, post.getCategory());
        ps.setString(6, post.getStatus());
        ps.setBoolean(7, post.isFeatured());
        ps.setInt(8, post.getPostID());

        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

// Cập nhật thumbnail
public void updateThumbnail(int postId, String url) {
    String sql = "UPDATE Posts SET ThumbnailURL = ? WHERE PostID = ?";
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, url);
        ps.setInt(2, postId);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

// Cập nhật ảnh bài viết theo vị trí (1 hoặc 2)
public void updateImage(int postId, int index, String imageURL) {
    String sqlSelect = "SELECT * FROM PostImages WHERE PostID = ? ORDER BY ImageID ASC LIMIT 1 OFFSET ?";
    String sqlUpdate = "UPDATE PostImages SET ImageURL = ? WHERE PostID = ? AND ImageID = ?";
    String sqlInsert = "INSERT INTO PostImages (PostID, ImageURL, Description) VALUES (?, ?, ?)";

    try (Connection conn = getConnection();
         PreparedStatement psSelect = conn.prepareStatement(sqlSelect)) {

        psSelect.setInt(1, postId);
        psSelect.setInt(2, index - 1);

        ResultSet rs = psSelect.executeQuery();
        if (rs.next()) {
            int imageId = rs.getInt("ImageID");
            try (PreparedStatement psUpdate = conn.prepareStatement(sqlUpdate)) {
                psUpdate.setString(1, imageURL);
                psUpdate.setInt(2, postId);
                psUpdate.setInt(3, imageId);
                psUpdate.executeUpdate();
            }
        } else {
            try (PreparedStatement psInsert = conn.prepareStatement(sqlInsert)) {
                psInsert.setInt(1, postId);
                psInsert.setString(2, imageURL);
                psInsert.setString(3, index == 1 ? "Topic image" : "Logo image");
                psInsert.executeUpdate();
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

// Cập nhật video bài viết theo vị trí (1 hoặc 2)
public void updateVideo(int postId, int index, String videoURL) {
    String sqlSelect = "SELECT * FROM PostVideos WHERE PostID = ? ORDER BY VideoID ASC LIMIT 1 OFFSET ?";
    String sqlUpdate = "UPDATE PostVideos SET VideoURL = ? WHERE PostID = ? AND VideoID = ?";
    String sqlInsert = "INSERT INTO PostVideos (PostID, VideoURL, Description) VALUES (?, ?, ?)";

    try (Connection conn = getConnection();
         PreparedStatement psSelect = conn.prepareStatement(sqlSelect)) {

        psSelect.setInt(1, postId);
        psSelect.setInt(2, index - 1);

        ResultSet rs = psSelect.executeQuery();
        if (rs.next()) {
            int videoId = rs.getInt("VideoID");
            try (PreparedStatement psUpdate = conn.prepareStatement(sqlUpdate)) {
                psUpdate.setString(1, videoURL);
                psUpdate.setInt(2, postId);
                psUpdate.setInt(3, videoId);
                psUpdate.executeUpdate();
            }
        } else {
            try (PreparedStatement psInsert = conn.prepareStatement(sqlInsert)) {
                psInsert.setInt(1, postId);
                psInsert.setString(2, videoURL);
                psInsert.setString(3, index == 1 ? "Explain Video" : "Advertise Video");
                psInsert.executeUpdate();
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

}

