package entity;

import java.util.List;
import jakarta.persistence.*;

@Entity
@Table(name = "Users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    private String fullname; 

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String email;

    @Column(name = "isAdmin", nullable = false)
    private Boolean isAdmin; 

    @Column(name = "isActive", nullable = false)
    private Boolean isActive; 

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<History> histories;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Share> shares;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Comment> comments;

    public User() {}

    public User(int id, String username, String fullname, String password, String email, Boolean isAdmin, Boolean isActive,
                List<History> histories, List<Share> shares, List<Comment> comments) {
        this.id = id;
        this.username = username;
        this.fullname = fullname;
        this.password = password;
        this.email = email;
        this.isAdmin = isAdmin;
        this.isActive = isActive;
        this.histories = histories;
        this.shares = shares;
        this.comments = comments;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Boolean getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(Boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }

    public List<History> getHistories() {
        return histories;
    }

    public void setHistories(List<History> histories) {
        this.histories = histories;
    }

    public List<Share> getShares() {
        return shares;
    }

    public void setShares(List<Share> shares) {
        this.shares = shares;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    @Override
    public String toString() {
        return "User [username=" + username + ", fullname=" + fullname + ", password=" + password + ", email=" + email
                + ", isAdmin=" + isAdmin + ", isActive=" + isActive + "]";
    }
}
