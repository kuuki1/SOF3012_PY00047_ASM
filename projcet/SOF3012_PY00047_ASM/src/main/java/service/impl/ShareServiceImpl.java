package service.impl;

import java.util.List;

import dao.ShareDao;
import dao.impl.ShareDaoImpl;
import entity.Share;
import service.ShareService;

public class ShareServiceImpl implements ShareService{

	private ShareDao dao = new ShareDaoImpl();
	
	public ShareServiceImpl() {
		dao = new ShareDaoImpl();
	}
	
	@Override
	public List<Share> findShareByVideoId(Integer videoId) {
		return dao.findByVideoId(videoId);
	}

	@Override
	public Share create(Share entity) {
		return dao.create(entity);
	}

}
