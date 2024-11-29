package entity;

import java.sql.Timestamp;
import jakarta.persistence.*;

@Entity
@Table(name = "Comment")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "userid", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "videoid", nullable = false)
    private Video video;

    @Column(name = "content", nullable = false)
    private String content;

    @Column(name = "commentDate", nullable = false)
    private Timestamp commentDate;

    public Comment() {}

    public Comment(User user, Video video, String content, Timestamp commentDate) {
        this.user = user;
        this.video = video;
        this.content = content;
        this.commentDate = commentDate;
    }

    // Getters và Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Video getVideo() { return video; }
    public void setVideo(Video video) { this.video = video; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Timestamp getCommentDate() { return commentDate; }
    public void setCommentDate(Timestamp commentDate) { this.commentDate = commentDate; }
}
