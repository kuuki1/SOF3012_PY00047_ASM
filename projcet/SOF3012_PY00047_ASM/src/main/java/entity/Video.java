package entity;

import java.util.List;
import jakarta.persistence.*;

@Entity
@Table(name = "Video")
public class Video {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false)
    private String videoUrl;

    @Column
    private String poster;

    @ManyToOne
    @JoinColumn(name = "categoryid", nullable = false)
    private Category category;

    @Column(name = "viewcount", nullable = false)
    private int viewCount;

    @Column(name = "likecuont", nullable = false)
    private int likeCount;

    @Column(name = "sharecuont", nullable = false)
    private int shareCount;

    @Column(name = "commentcuont", nullable = false)
    private int commentCount;

    @Column
    private String description;

    @Column(name = "isActive", nullable = false)
    private Boolean isActive;

    @ManyToOne
    @JoinColumn(name = "userid", nullable = false)
    private User user;

    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL)
    private List<History> histories;

    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL)
    private List<Share> shares;

    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL)
    private List<Comment> comments;

    // Constructor không tham số
    public Video() {}

    // Constructor đầy đủ
    public Video(int id, String title, String videoUrl, String poster, Category category, int viewCount, int likeCount,
                 int shareCount, int commentCount, String description, Boolean isActive, User user,
                 List<History> histories, List<Share> shares, List<Comment> comments) {
        this.id = id;
        this.title = title;
        this.videoUrl = videoUrl;
        this.poster = poster;
        this.category = category;
        this.viewCount = viewCount;
        this.likeCount = likeCount;
        this.shareCount = shareCount;
        this.commentCount = commentCount;
        this.description = description;
        this.isActive = isActive;
        this.user = user;
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getVideoUrl() {
        return videoUrl;
    }

    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public int getShareCount() {
        return shareCount;
    }

    public void setShareCount(int shareCount) {
        this.shareCount = shareCount;
    }

    public int getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(int commentCount) {
        this.commentCount = commentCount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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
}
