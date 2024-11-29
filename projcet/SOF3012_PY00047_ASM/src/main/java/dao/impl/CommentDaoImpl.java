package dao.impl;

import java.util.List;

import dao.CommentDao;
import dao.Dao;
import entity.Comment;

public class CommentDaoImpl extends Dao<Comment> implements CommentDao {

    @Override
    public Comment create(Comment comment) {
        return super.create(comment);
    }

    @Override
    public Comment update(Comment comment) {
        return super.update(comment);
    }

    @Override
    public Comment delete(Comment comment) {
        return super.delete(comment);
    }

    @Override
    public List<Comment> findCommentByVideo(String videoUrl) {
        // Sử dụng tên thực thể là 'Comment' và tham số đánh số ?1
        String jpql = "SELECT c FROM Comment c WHERE c.video.videoUrl = ?1 ORDER BY c.commentDate DESC";
        return super.findMany(Comment.class, jpql, videoUrl);
    }


}
