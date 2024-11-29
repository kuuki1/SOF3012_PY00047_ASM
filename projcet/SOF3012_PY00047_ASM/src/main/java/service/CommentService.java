package service;

import java.util.List;

import entity.Comment;

public interface CommentService {
	List<Comment> findCommentByVideo(String videoUrl);
    Comment create(Comment comment);
    Comment update(Comment comment);
    Comment delete(Comment comment);
}
