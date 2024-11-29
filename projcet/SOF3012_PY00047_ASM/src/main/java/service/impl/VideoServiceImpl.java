package service.impl;

import java.util.List;

import dao.VideoDao;
import dao.impl.VideoDaoImpl;
import entity.Video;
import service.VideoService;

public class VideoServiceImpl implements VideoService{
	
	private VideoDao dao;
	
	public VideoServiceImpl() {
		dao = new VideoDaoImpl();
	}

	@Override
	public Video findById(Integer id) {
		return dao.findById(id);
	}

	@Override
	public Video findByHref(String href) {
		return dao.findByHref(href);
	}

	@Override
	public List<Video> findByTitle(String title) {
		return dao.findByTitle(title);
	}
	
	@Override
    public List<Video> findByCategoryId(Integer categoryId) {
        return dao.findByCategoryId(categoryId);
    }
	
	@Override
    public List<Video> getVideosByCategoryId(Integer categoryId, int pageNumber, int pageSize) {
        return dao.findByCategoryId(categoryId, pageNumber, pageSize);
    }
	
	@Override
    public int countVideosByCategoryId(Integer categoryId) {
        return dao.countByCategoryId(categoryId);
    }

	@Override
	public List<Video> findAll() {
		return dao.findAll();
	}

	@Override
	public List<Video> findAll(int pageNumber, int pageSize) {
		return dao.findAll(pageNumber, pageSize);
	}
	
	@Override
    public void incrementViewCount(Video video) {
        video.setViewCount(video.getViewCount() + 1);
        dao.updateViewCount(video);
    }
	
	@Override
	public void incrementLikeCount(Video video) {
	    video.setLikeCount(video.getLikeCount() + 1);
	    dao.updateLikeCount(video);
	}

	@Override
	public void decrementLikeCount(Video video) {
	    video.setLikeCount(video.getLikeCount() - 1);
	    dao.updateLikeCount(video);
	}

	@Override
	public Video create(Video entity) {
		entity.setIsActive(Boolean.TRUE);
		entity.setCommentCount(0);
		entity.setLikeCount(0);
		entity.setShareCount(0);
		return dao.create(entity);
	}

	@Override
	public Video update(Video entity) {
		return dao.update(entity);
	}

	@Override
	public Video delete(String href) {
		Video entity = findByHref(href);
		entity.setIsActive(Boolean.FALSE);
		return dao.update(entity);
	}

	@Override
	public List<Video> findVideoByUserId(int id) {
		return dao.findVideoByUser(id);
	}

	@Override
	public void incrementShareCount(Video video) {
		video.setShareCount(video.getShareCount() + 1);
		dao.updateShareCount(video);
	}

}
