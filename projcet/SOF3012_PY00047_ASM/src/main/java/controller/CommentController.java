package controller;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import constant.SessionAttr;
import entity.Comment;
import entity.User;
import entity.Video;
import service.CommentService;
import service.impl.CommentServiceImpl;
import service.impl.VideoServiceImpl;

@WebServlet("/comment")
public class CommentController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CommentService commentService = new CommentServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String content = req.getParameter("content");
        String videoHref = req.getParameter("videoHref");
        User currentUser = (User) req.getSession().getAttribute(SessionAttr.CURRENT_USER);
        if (currentUser == null || content == null || content.trim().isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("Invalid comment!");
            return;
        }
        Video video = new VideoServiceImpl().findByHref(videoHref);
        Comment comment = new Comment(currentUser, video, content, new Timestamp(System.currentTimeMillis()));
        commentService.create(comment);
        resp.sendRedirect(req.getContextPath() + "/video?action=watch&id=" + videoHref);
    }
}
