package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import constant.SessionAttr;
import entity.History;
import entity.User;
import entity.Video;
import service.HistoryService;
import service.impl.HistoryServiceImpl;

@WebServlet({
	"/favories",
	"/history"
})
public class FavoritesAndHistoryController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private HistoryService historyService = new HistoryServiceImpl();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String path = req.getServletPath();
		if(path.equals("/favories")) {
			User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
	    	if(currentUser == null) {
	    		resp.sendRedirect(req.getContextPath() + "/index");
	    		return;
	    	}
			doGetFavories(session, req, resp);
		}else if(path.equals("/history")) {
			User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
	    	if(currentUser == null) {
	    		resp.sendRedirect(req.getContextPath() + "/index");
	    		return;
	    	}
			doGetHistory(session, req, resp);
		}
	}
	
	private void doGetFavories(HttpSession session, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User) session.getAttribute(SessionAttr.CURRENT_USER);
		if(user != null) {
				List<History> favories = historyService.findByUserAndIsLiked(user.getUsername());
			List<Video> videos = new ArrayList<>();
			for(int i = 0 ; i < favories.size() ; i++) {
				videos.add(favories.get(i).getVideo());
			}
			req.setAttribute("videos", videos);
			req.getRequestDispatcher("/view/user/history.jsp").forward(req, resp);
		}else {
			resp.sendRedirect(req.getContextPath() + "/index");
		}
	}
	
	private void doGetHistory(HttpSession session, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User user = (User) session.getAttribute(SessionAttr.CURRENT_USER);
		if(user != null) {
			List<History> history = historyService.findByUser(user.getUsername());
			List<Video> videos = new ArrayList<>();
			for(int i = 0 ; i < history.size() ; i++) {
				videos.add(history.get(i).getVideo());
			}
			req.setAttribute("videos", videos);
			req.getRequestDispatcher("/view/user/history.jsp").forward(req, resp);
		} else {
			resp.sendRedirect(req.getContextPath() + "/index");
		}
	}
}
