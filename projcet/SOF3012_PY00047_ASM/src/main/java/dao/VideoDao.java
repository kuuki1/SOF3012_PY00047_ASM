package dao;

import java.util.List;

import entity.Video;

public interface VideoDao {
	int countByCategoryId(Integer categoryId);
	Video findById(Integer id);
	Video findByHref(String href);
	List<Video> findByTitle(String title);
	List<Video> findByCategoryId(Integer categoryId);
	List<Video> findByCategoryId(Integer categoryId, int pageNumber, int pageSize);
	List<Video> findAll();
	List<Video> findAll(int pageNumber, int pageSize);
	List<Video> findVideoByUser(int userId);
	Video create(Video entity);
	Video update(Video entity);
	Video delete(Video entity);
	void updateViewCount(Video video);
	void updateLikeCount(Video video);
	void updateShareCount(Video video);
}
