package dao.impl;

import java.util.List;
import dao.Dao;
import dao.HistoryDao;
import entity.History;

public class HistoryDaoImpl extends Dao<History> implements HistoryDao {

    @Override
    public List<History> findByUser(String username) {
        String sql = "SELECT o FROM History o WHERE o.user.username = ?1 AND o.video.isActive = true " +
                     "ORDER BY o.viewDate DESC";
        return super.findMany(History.class, sql, username);
    }

    @Override
    public History create(History history) {
        return super.create(history);
    }

    @Override
    public History update(History history) {
        return super.update(history);
    }

    @Override
    public List<History> findByUserAndIsLiked(String username) {
        String sql = "SELECT o FROM History o WHERE o.user.username = ?1 AND o.isLiked = true " +
                     "AND o.video.isActive = true ORDER BY o.viewDate DESC";
        return super.findMany(History.class, sql, username);
    }

    @Override
    public History findByUserIdAndVideoId(Integer userId, Integer videoId) {
        String sql = "SELECT o FROM History o WHERE o.user.id = ?1 AND o.video.id = ?2 " +
                     "AND o.video.isActive = true ORDER BY o.viewDate DESC";
        return super.findOne(History.class, sql, userId, videoId);
    }
}
