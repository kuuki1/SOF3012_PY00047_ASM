package dao.impl;

import java.util.List;

import dao.Dao;
import dao.VideoDao;
import entity.Video;

public class VideoDaoImpl extends Dao<Video> implements VideoDao {

    @Override
    public Video findById(Integer id) {
        return super.findById(Video.class, id);
    }

    @Override
    public Video findByHref(String href) {
        String sql = "SELECT o FROM Video o WHERE o.videoUrl = ?1";
        return super.findOne(Video.class, sql, href);
    }

    @Override
    public List<Video> findByTitle(String title) {
        String sql = "SELECT o FROM Video o WHERE o.title = ?1";
        return super.findMany(Video.class, sql, title);
    }
    
    @Override
    public List<Video> findByCategoryId(Integer categoryId) {
        String sql = "SELECT v FROM Video v WHERE v.category.id = ?1";
        return super.findMany(Video.class, sql, categoryId);
    }
    
    @Override
    public List<Video> findByCategoryId(Integer categoryId, int pageNumber, int pageSize) {
        String jpql = "SELECT v FROM Video v WHERE v.category.id = :categoryId AND v.isActive = true";
        return entityManager.createQuery(jpql, Video.class)
                .setParameter("categoryId", categoryId)
                .setFirstResult((pageNumber - 1) * pageSize)
                .setMaxResults(pageSize)
                .getResultList();
    }
    
    @Override
    public int countByCategoryId(Integer categoryId) {
        String jpql = "SELECT COUNT(v) FROM Video v WHERE v.category.id = :categoryId";
        return ((Long) entityManager.createQuery(jpql)
                .setParameter("categoryId", categoryId)
                .getSingleResult()).intValue();
    }

    @Override
    public List<Video> findAll() {
        return super.findAll(Video.class, true);
    }
    
    @Override
    public void updateViewCount(Video video) {
        String sql = "UPDATE Video v SET v.viewCount = ?1 WHERE v.id = ?2";
        executeUpdateQuery(sql, video.getViewCount(), video.getId());
    }
    
    @Override
    public void updateLikeCount(Video video) {
        String sql = "UPDATE Video v SET v.likeCount = ?1 WHERE v.id = ?2";
        executeUpdateQuery(sql, video.getLikeCount(), video.getId());
    }
    
    @Override
	public void updateShareCount(Video video) {
    	 String sql = "UPDATE Video v SET v.shareCount = ?1 WHERE v.id = ?2";
         executeUpdateQuery(sql, video.getShareCount(), video.getId());
	}

    @Override
    public List<Video> findAll(int pageNumber, int pageSize) {
        return super.findAll(Video.class, true, pageNumber, pageSize);
    }

    @Override
    public Video create(Video entity) {
        return super.create(entity);
    }

    @Override
    public Video update(Video entity) {
        return super.update(entity);
    }

    @Override
    public Video delete(Video entity) {
        return super.delete(entity);
    }

	@Override
	public List<Video> findVideoByUser(int userId) {
		String sql = "SELECT o FROM Video o WHERE o.user.id = ?1";
		return super.findMany(Video.class, sql, userId);
	}
}
