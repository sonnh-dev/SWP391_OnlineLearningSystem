/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Account {
    private String email;
    private String password;
    private int UserID;

public Account(int UserID, String email, String password) {
    this.UserID = UserID;
    this.email = email;
    this.password = password;
}

public int getId() {
    return UserID;
}

    // Constructors
    public Account() {
    }
    
    public Account(String email, String password) {
        this.email = email;
        this.password = password;
    }
    
    // Getters and Setters
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    @Override
    public String toString() {
        return "account{" + "email=" + email + ", password=" + password +'}';
    }
    
}