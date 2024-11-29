package service.impl;

import java.util.List;

import dao.CommentDao;
import dao.impl.CommentDaoImpl;
import entity.Comment;
import entity.Video;
import service.CommentService;
import service.VideoService;

public class CommentServiceImpl implements CommentService {

	private CommentDao dao = new CommentDaoImpl();
	private VideoService videoService = new VideoServiceImpl();

    public CommentServiceImpl() {
        dao = new CommentDaoImpl();
    }

    @Override
    public List<Comment> findCommentByVideo(String videoUrl) {
        Video video = videoService.findByHref(videoUrl);
        return dao.findCommentByVideo(video.getVideoUrl());
    }


    @Override
    public Comment create(Comment comment) {
    	Comment createdComment = dao.create(comment);
        if (createdComment != null) {
            Video video = videoService.findByHref(comment.getVideo().getVideoUrl());
            video.setCommentCount(video.getCommentCount() + 1);
            videoService.update(video);
        }
        return createdComment;
    }

    @Override
    public Comment update(Comment comment) {
        return dao.update(comment);
    }

    @Override
    public Comment delete(Comment comment) {
        return dao.delete(comment);
    }
}
