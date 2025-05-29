// File: src/main/java/com/yourcompany/yourproject/model/User.java
package model;

import java.time.LocalDate; // Java 8 trở lên cho LocalDate

public class User {
    private int userId;
    private String firstName;
    private String lastName;
    private String gender; // "Male", "Female", "Other"
    private String email;
    private String phoneNumber;
    private String role; // "Admin", "User", ...
    private boolean status; // true for active, false for inactive/blocked
    private String avatarUrl;
    private String password; // Không nên trả về password trong các phương thức getter công khai nếu không cần thiết
    private String address;
    private LocalDate dateOfBirth;

    // Constructors
    public User() {
    }

    // Constructor cho việc lấy danh sách người dùng (không cần password, address, dob, avatar)
    public User(int userId, String firstName, String lastName, String gender, String email, String phoneNumber, String role, boolean status) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.role = role;
        this.status = status;
    }
    
    // Constructor đầy đủ cho User Details và thêm/sửa
    public User(int userId, String firstName, String lastName, String gender, String email, String phoneNumber, String role, boolean status, String avatarUrl, String password, String address, LocalDate dateOfBirth) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.role = role;
        this.status = status;
        this.avatarUrl = avatarUrl;
        this.password = password; // Chỉ đặt password khi tạo mới hoặc cập nhật password
        this.address = address;
        this.dateOfBirth = dateOfBirth;
    }
    
    // Constructor khi thêm user mới (chưa có userId, password sẽ được tạo)
    public User(String firstName, String lastName, String gender, String email, String phoneNumber, String role, boolean status, String avatarUrl, String address, LocalDate dateOfBirth) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.role = role;
        this.status = status;
        this.avatarUrl = avatarUrl;
        this.address = address;
        this.dateOfBirth = dateOfBirth;
    }


    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    // Phương thức tiện ích để lấy họ và tên đầy đủ
    public String getFullName() {
        return firstName + " " + lastName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    @Override
    public String toString() {
        return "User{" + "userId=" + userId + ", firstName=" + firstName + ", lastName=" + lastName + ", gender=" + gender + ", email=" + email + ", phoneNumber=" + phoneNumber + ", role=" + role + ", status=" + status + ", avatarUrl=" + avatarUrl + ", address=" + address + ", dateOfBirth=" + dateOfBirth + '}';
    }

    public String getAvatarURL() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void setAvatarURL(String avatarURL) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}