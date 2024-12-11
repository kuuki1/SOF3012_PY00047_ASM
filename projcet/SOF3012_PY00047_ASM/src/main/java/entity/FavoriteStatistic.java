package entity;

import java.sql.Timestamp;

public class FavoriteStatistic {

    private Integer videoId;
    private String title;
    private Long favoriteCount;
    private Timestamp oldestDate;
    private Timestamp latestDate;

    // Constructor that matches the JPQL query
    public FavoriteStatistic(Integer videoId, String title, Long favoriteCount, Timestamp oldestDate, Timestamp latestDate) {
        this.videoId = videoId;
        this.title = title;
        this.favoriteCount = favoriteCount;
        this.oldestDate = oldestDate;
        this.latestDate = latestDate;
    }

    // Getters and Setters
    public Integer getVideoId() {
        return videoId;
    }

    public String getTitle() {
        return title;
    }

    public Long getFavoriteCount() {
        return favoriteCount;
    }

    public Timestamp getOldestDate() {
        return oldestDate;
    }

    public Timestamp getLatestDate() {
        return latestDate;
    }
}
