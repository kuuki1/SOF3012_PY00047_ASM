package service;

import java.util.List;

import entity.Share;

public interface ShareService {
	List<Share> findShareByVideoId(Integer id);
	Share create(Share entity);
}
