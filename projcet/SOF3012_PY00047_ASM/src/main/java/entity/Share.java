package entity;

import java.util.Date;
import jakarta.persistence.*;

@Entity
@Table(name = "Share")
public class Share {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "userid", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "videoid", nullable = false)
    private Video video;

    @Column(name = "shareDate", nullable = false)
    private Date shareDate;

    @Column(name = "shareEmail", nullable = false)
    private String shareEmail;

    // No-args constructor
    public Share() {}

	public Share(User user, Video video, Date shareDate, String shareEmail) {
		super();
		this.user = user;
		this.video = video;
		this.shareDate = shareDate;
		this.shareEmail = shareEmail;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Video getVideo() {
		return video;
	}

	public void setVideo(Video video) {
		this.video = video;
	}

	public Date getShareDate() {
		return shareDate;
	}

	public void setShareDate(Date shareDate) {
		this.shareDate = shareDate;
	}

	public String getShareEmail() {
		return shareEmail;
	}

	public void setShareEmail(String shareEmail) {
		this.shareEmail = shareEmail;
	}
}
