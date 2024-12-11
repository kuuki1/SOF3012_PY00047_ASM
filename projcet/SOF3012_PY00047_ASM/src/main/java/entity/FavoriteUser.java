package entity;

import java.sql.Timestamp;

public class FavoriteUser {
    private String username;
    private String fullname;
    private String email;
    private Timestamp likedDate;

    public FavoriteUser(String username, String fullname, String email, Timestamp likedDate) {
        this.username = username;
        this.fullname = fullname;
        this.email = email;
        this.likedDate = likedDate;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Timestamp getLikedDate() {
        return likedDate;
    }

    public void setLikedDate(Timestamp likedDate) {
        this.likedDate = likedDate;
    }
}
