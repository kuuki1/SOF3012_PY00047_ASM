package dao;

import entity.Comment;
import java.util.List;

public interface CommentDao {
    List<Comment> findCommentByVideo(String videoUrl);
    Comment create(Comment comment);
    Comment update(Comment comment);
    Comment delete(Comment comment);
}
