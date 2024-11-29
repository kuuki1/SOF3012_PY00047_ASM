package dao;

import entity.History;
import java.util.List;

public interface HistoryDao {
    List<History> findByUser(String username);
    List<History> findByUserAndIsLiked(String username);
    History findByUserIdAndVideoId(Integer userId, Integer videoId);
    History create(History history);
    History update(History history);
}
