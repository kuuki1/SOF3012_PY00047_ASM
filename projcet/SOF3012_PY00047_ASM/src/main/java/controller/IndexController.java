package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import constant.SessionAttr;
import entity.Video;
import entity.Category;
import entity.User;
import service.VideoService;
import service.CategoryService;
import service.impl.VideoServiceImpl;
import service.impl.CategoryServiceImpl;

@WebServlet({
	"/index",
	"/management",
})
public class IndexController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private static final int VIDEO_MAX_PAGE_SIZE = 6;
	private VideoService videoService = new VideoServiceImpl();
	private CategoryService categoryService = new CategoryServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getServletPath();
		if (path.equals("/management")) {
			doGetManagement(req, resp);
		} else if(path.equals("/index")) {
			doGetIndex(req, resp);
		}
		
	}
	
	private void doGetManagement(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
		if(currentUser != null && currentUser.getIsAdmin() == Boolean.TRUE) {
			req.getRequestDispatcher("/view/admin/Management.jsp").forward(req, resp);
		} else if(currentUser != null && currentUser.getIsAdmin() == Boolean.FALSE) {
			List<Video> videoList = videoService.findVideoByUserId(currentUser.getId());
			for (Video video : videoList) {
		        System.out.println("Video ID: " + video.getId());
		        if (video.getCategory() == null) {
		            System.out.println("Danh mục bị thiếu cho video: " + video.getId());
		            video.setCategory(new Category(0, "Uncategorized", null));
		        }
		    }
		    req.setAttribute("videoList", videoList);
			req.getRequestDispatcher("/view/user/Management.jsp").forward(req, resp);
		}else {
			resp.sendRedirect(req.getContextPath() + "/index");
		}
	}
	
	private void doGetIndex(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<Video> countVideo = videoService.findAll();
		int maxPage = (int) Math.ceil(countVideo.size() / (double) VIDEO_MAX_PAGE_SIZE);
		req.setAttribute("maxPage", maxPage);
		List<Video> videos = null;
		String pageNumber = req.getParameter("page");
		if(pageNumber == null) {
			videos = videoService.findAll(1, VIDEO_MAX_PAGE_SIZE);
			req.setAttribute("currentPage", 1);
		}else {
			videos = videoService.findAll(Integer.valueOf(pageNumber), VIDEO_MAX_PAGE_SIZE);
			req.setAttribute("currentPage", pageNumber);
		}
		req.setAttribute("videos", videos);
		List<Category> categories = categoryService.getAllCategories();
        req.setAttribute("categories", categories);
		req.getRequestDispatcher("/view/user/index.jsp").forward(req, resp);
	}
	
}
