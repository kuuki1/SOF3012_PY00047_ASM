package entity;

import java.sql.Timestamp;
import java.util.Date;
import jakarta.persistence.*;

@Entity
@Table(name = "History")
public class History {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "userid", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "videoid", nullable = false)
    private Video video;

    @Column(name = "viewDate", nullable = false)
    private Date viewDate;

    @Column(name = "isLiked", nullable = false)
    private boolean isLiked;

    @Column(name = "likedDate")
    private Timestamp likedDate;

    // No-args constructor
    public History() {}

	public History(int id, User user, Video video, Date viewDate, boolean isLiked, Timestamp likedDate) {
		super();
		this.id = id;
		this.user = user;
		this.video = video;
		this.viewDate = viewDate;
		this.isLiked = isLiked;
		this.likedDate = likedDate;
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

	public Date getViewDate() {
		return viewDate;
	}

	public void setViewDate(Date viewDate) {
		this.viewDate = viewDate;
	}

	public boolean isLiked() {
		return isLiked;
	}

	public void setLiked(boolean isLiked) {
		this.isLiked = isLiked;
	}

	public Timestamp getLikedDate() {
		return likedDate;
	}

	public void setLikedDate(Timestamp likedDate) {
		this.likedDate = likedDate;
	}
}
