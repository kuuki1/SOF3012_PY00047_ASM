package dao.impl;

import java.util.List;

import dao.Dao;
import dao.ShareDao;
import entity.Share;

public class ShareDaoImpl extends Dao<Share> implements ShareDao {

    @Override
    public Share findById(Integer id) {
        return super.findById(Share.class, id);
    }

    @Override
    public List<Share> findAll() {
        return super.findAll(Share.class, false);
    }

    @Override
    public List<Share> findAll(int pageNumber, int pageSize) {
        return super.findAll(Share.class, false, pageNumber, pageSize);
    }

    @Override
    public Share create(Share share) {
        return super.create(share);
    }

    @Override
    public Share update(Share share) {
        return super.update(share);
    }

    @Override
    public Share delete(Share share) {
        return super.delete(share);
    }

	@Override
	public List<Share> findByVideoId(Integer videoId) {
		 String sql = "SELECT o FROM Share o WHERE o.video.id = ?1";
		return super.findMany(Share.class, sql, videoId);
	}
}
