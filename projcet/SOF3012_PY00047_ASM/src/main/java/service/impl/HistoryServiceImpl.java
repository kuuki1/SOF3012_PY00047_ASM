package service.impl;

import java.sql.Timestamp;
import java.util.List;

import dao.HistoryDao;
import dao.impl.HistoryDaoImpl;
import entity.History;
import entity.User;
import entity.Video;
import service.HistoryService;
import service.VideoService;

public class HistoryServiceImpl implements HistoryService{
	
	private HistoryDao dao;
	private VideoService videoService = new VideoServiceImpl();
	
	public HistoryServiceImpl() {
		dao = new HistoryDaoImpl();
	}

	@Override
	public List<History> findByUser(String username) {
		return dao.findByUser(username);
	}

	@Override
	public List<History> findByUserAndIsLiked(String username) {
		return dao.findByUserAndIsLiked(username);
	}

	@Override
	public History findByUserIdAndVideoId(Integer userId, Integer videoId) {
		return dao.findByUserIdAndVideoId(userId, videoId);
	}

	@Override
	public History create(User user, Video video) {
		History exisHistory = findByUserIdAndVideoId(user.getId(), video.getId());
		if(exisHistory == null) {
			exisHistory = new History();
			exisHistory.setUser(user);
			exisHistory.setVideo(video);
			exisHistory.setLikedDate(new Timestamp(System.currentTimeMillis()));
			exisHistory.setViewDate(new Timestamp(System.currentTimeMillis()));
			exisHistory.setLiked(Boolean.FALSE);
			return dao.create(exisHistory);
		}else {
			exisHistory.setViewDate(new Timestamp(System.currentTimeMillis()));
			return dao.update(exisHistory);
		}
	}

	@Override
	public boolean updateLikeOrUnlike(User user, String videoHref) {
	    Video video = videoService.findByHref(videoHref);
	    if (video == null) {
	        throw new RuntimeException("Video not found");
	    }

	    History existingHistory = findByUserIdAndVideoId(user.getId(), video.getId());

	    if (existingHistory == null) {
	        existingHistory = new History();
	        existingHistory.setUser(user);
	        existingHistory.setVideo(video);
	        existingHistory.setLiked(true);
	        existingHistory.setLikedDate(new Timestamp(System.currentTimeMillis()));
	        existingHistory.setViewDate(new Timestamp(System.currentTimeMillis()));
	        dao.create(existingHistory);
	        return true;
	    } else {
	        existingHistory.setLiked(!existingHistory.isLiked());
	        existingHistory.setLikedDate(new Timestamp(System.currentTimeMillis()));
	        dao.update(existingHistory);
	        return existingHistory.isLiked();
	    }
	}
}
