package controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import constant.SessionAttr;
import entity.Share;
import entity.User;
import entity.Video;
import service.EmailService;
import service.ShareService;
import service.VideoService;
import service.impl.EmailServiceImpl;
import service.impl.ShareServiceImpl;
import service.impl.VideoServiceImpl;

@WebServlet({
	"/share",
	"/share/management",
})
public class ShareController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private ShareService shareService = new ShareServiceImpl();
	private EmailService emailService = new EmailServiceImpl();
	private VideoService videoService = new VideoServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        
        if(path.equals("/share/management")) {
        	doGetManagement(req, resp);
        }
	}
	
	private void doGetManagement(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
            List<Video> videoList = videoService.findAll();
            req.setAttribute("videoList", videoList);

            List<Share> shareList = shareService.findShareByVideoId(null);
            req.setAttribute("shareList", shareList);

            req.getRequestDispatcher("/view/admin/shareManagement.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load share management.");
        }
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getServletPath();
		if(path.equals("/share")) {
			doPostShare(req, resp);
		}else if(path.equals("/share/management")) {
			doPostsharemanagement(req, resp);
		}
	}
	
	private void doPostShare(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String href = "http://localhost:8080/SOF3012_PY00047_ASM/video?action=watch&id=";
        User currentUser = (User) req.getSession().getAttribute(SessionAttr.CURRENT_USER);
		String videoHref = req.getParameter("videoHref");
		String email = req.getParameter("email");
		if (currentUser == null || email == null || email.trim().isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("Invalid email!");
            return;
        }
		Video video = new VideoServiceImpl().findByHref(videoHref);
		Share share = new Share(currentUser, video, new Timestamp(System.currentTimeMillis()), email);
		String localhost = href + "" + video.getVideoUrl();
		shareService.create(share);
		emailService.sendEmailShare(localhost, getServletContext(), share, "share");
		videoService.incrementShareCount(video);
		resp.sendRedirect(req.getContextPath() + "/video?action=watch&id=" + videoHref);
	}
	
	private void doPostsharemanagement(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
	        req.setCharacterEncoding("UTF-8");
	        resp.setCharacterEncoding("UTF-8");

	        String videoIdParam = req.getParameter("videoId");
	        Integer videoId = (videoIdParam != null && !videoIdParam.isEmpty()) ? Integer.parseInt(videoIdParam) : null;

	        List<Share> shareList = shareService.findShareByVideoId(videoId);
	        req.setAttribute("shareList", shareList);

	        List<Video> videoList = videoService.findAll();
	        req.setAttribute("videoList", videoList);

	        req.getRequestDispatcher("/view/admin/shareManagement.jsp").forward(req, resp);
	    } catch (Exception e) {
	        e.printStackTrace();
	        resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to filter shares by video.");
	    }
	}
}
