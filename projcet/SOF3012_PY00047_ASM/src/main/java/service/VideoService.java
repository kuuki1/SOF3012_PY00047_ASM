package service;

import java.util.List;

import entity.Video;

public interface VideoService {
	int countVideosByCategoryId(Integer categoryId);
	Video findById(Integer id);
	Video findByHref(String href);
	List<Video> findByTitle(String title);
	List<Video> findByCategoryId(Integer categoryId);
	List<Video> getVideosByCategoryId(Integer categoryId, int pageNumber, int pageSize);
	List<Video> findAll();
	List<Video> findAll(int pageNumber, int pageSize);
	List<Video> findVideoByUserId(int id);
	Video create(Video entity);
	Video update(Video entity);
	Video delete(String href);
	void incrementViewCount(Video video);
	void incrementLikeCount(Video video);
	void decrementLikeCount(Video video);
	void incrementShareCount(Video video);
}
