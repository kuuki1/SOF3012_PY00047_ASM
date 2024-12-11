package controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import constant.SessionAttr;
import entity.Category;
import entity.Comment;
import entity.History;
import entity.User;
import entity.Video;
import service.CategoryService;
import service.HistoryService;
import service.VideoService;
import service.impl.CategoryServiceImpl;
import service.impl.CommentServiceImpl;
import service.impl.HistoryServiceImpl;
import service.impl.VideoServiceImpl;

@WebServlet({
    "/video",
    "/video/management",
    "/video/management/edit/*",
    "/video/management/create",
    "/video/management/update",
    "/video/management/delete",
    "/video/management/reset",
})
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
	    maxFileSize = 1024 * 1024 * 10,      // 10MB
	    maxRequestSize = 1024 * 1024 * 50   // 50MB
	)
public class videoController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private VideoService videoService = new VideoServiceImpl();
	private HistoryService historyService = new HistoryServiceImpl();
	private CategoryService categoryService = new CategoryServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    String actionParam = req.getParameter("action");
	    String path = req.getServletPath();
	    String pathInfo = req.getPathInfo();

	    if ("watch".equals(actionParam)) {
	        doGetWatch(req.getSession(), req.getParameter("id"), req, resp);
	    } else if ("like".equals(actionParam)) {
	        doGetLike(req.getSession(), req.getParameter("id"), req, resp);
	    } else if ("/video/management".equals(path)) {
	        doGetManagement(req, resp);
	    } else if ("/video/management/edit".equals(path) && pathInfo != null) {
	        doGetEdit(req, resp);
	    } else if ("/video/management/create".equals(path)) {
	        doGetCreate(req, resp);
	    } else {
	        resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid or missing action parameter");
	    }
	}


	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json");
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String path = req.getServletPath();

		if (path.equals("/video/management/update")) {
			doPostUpdate(req, resp);
		} else if (path.equals("/video/management/delete")) {
			doPostDelete(req, resp);
		} else if (path.equals("/video/management/reset")) {
			doPostreset(req, resp);
		} else if (path.equals("/video/management/create")) {
			doPostCreate(req, resp);
		}
	}

	private void doGetEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pathInfo = req.getPathInfo();
		HttpSession session = req.getSession();
		User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
		if(currentUser != null && currentUser.getIsAdmin() == Boolean.TRUE) {
			List<Video> videoList = videoService.findVideoByUserId(currentUser.getId());
			req.setAttribute("videoList", videoList);
			if (pathInfo != null && pathInfo.startsWith("/")) {
				try {
					String idStr = pathInfo.substring(1);
					int id = Integer.parseInt(idStr);
					Video video = videoService.findById(id);
					if (video != null) {
						req.setAttribute("video", video);
					} else {
						System.err.println("Video not found for ID: " + id);
						req.setAttribute("video", null);
					}
				} catch (NumberFormatException e) {
					System.err.println("Invalid video ID format: " + e.getMessage());
					req.setAttribute("video", null);
				}
			} else {
				req.setAttribute("video", null);
			}
			req.getRequestDispatcher("/view/admin/videoManagement.jsp").forward(req, resp);
		} else if(currentUser != null && currentUser.getIsAdmin() == Boolean.FALSE) {
			
			req.getRequestDispatcher("/view/user/Management.jsp").forward(req, resp);
		}else {
			resp.sendRedirect(req.getContextPath() + "/index");
		}
	}

	private void doGetManagement(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
		if(currentUser != null && currentUser.getIsAdmin() == Boolean.TRUE) {
			List<Video> videoList = videoService.findAll();
		    for (Video video : videoList) {
		        System.out.println("Video ID: " + video.getId());
		        if (video.getCategory() == null) {
		            System.out.println("Danh mục bị thiếu cho video: " + video.getId());
		            video.setCategory(new Category(0, "Uncategorized", null));
		        }
		    }
		    req.setAttribute("videoList", videoList);
		    req.getRequestDispatcher("/view/admin/videoManagement.jsp").forward(req, resp);
		} else if(currentUser != null && currentUser.getIsAdmin() == Boolean.FALSE) {
			req.getRequestDispatcher("/view/user/Management.jsp").forward(req, resp);
		} else {
			resp.sendRedirect(req.getContextPath() + "/login");
		}
	}
	
	private void doGetCreate(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
		if(currentUser != null && currentUser.getIsAdmin() == Boolean.FALSE) {
			req.getRequestDispatcher("/view/user/Management.jsp").forward(req, resp);
		}else if(currentUser != null && currentUser.getIsAdmin() == Boolean.TRUE){
			List<Category> categoryList = categoryService.getAllCategories();
			req.setAttribute("categoryList", categoryList);
			req.getRequestDispatcher("/view/user/createVideo.jsp").forward(req, resp);
		} else {
			resp.sendRedirect(req.getContextPath() + "/login");
		}
	}

	private void doGetWatch(HttpSession session, String href, HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		Video video = videoService.findByHref(href);
		req.setAttribute("video", video);
		Category category = categoryService.getCategoryById(video.getCategory().getId()); 
		if(category == null) {
			System.out.println("not find categoryId: "+category.getId());
			return;
		}
		List<Video> videos = videoService.findByCategoryId(category.getId());
		videos.removeIf(v -> v.getId() == video.getId()); 
		req.setAttribute("videos", videos);
		videoService.incrementViewCount(video);
		List<Comment> comments = new CommentServiceImpl().findCommentByVideo(video.getVideoUrl());
		req.setAttribute("comments", comments);
		int likeCount = video.getLikeCount();
		int viewCount = video.getCommentCount();
		int commentCount = comments.size();
		req.setAttribute("likeCount", likeCount);
		req.setAttribute("viewCount", viewCount);
		req.setAttribute("commentCount", commentCount);
		User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
		if (currentUser != null) {
			History history = historyService.create(currentUser, video);
			req.setAttribute("flagLikeBtn", history.isLiked());
		}
		req.getRequestDispatcher("/view/user/videoDetail.jsp").forward(req, resp);
	}

	private void doGetLike(HttpSession session, String href, HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");

		User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
		if (currentUser == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		Video video = videoService.findByHref(href);
		if (video == null) {
			resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
			resp.getWriter().write("{\"error\": \"Video not found\"}");
			return;
		}

		try {
			boolean liked = historyService.updateLikeOrUnlike(currentUser, href);
			if (liked) {
				videoService.incrementLikeCount(video);
			} else {
				videoService.decrementLikeCount(video);
			}

			String jsonResponse = String.format("{\"liked\": %s, \"likeCount\": %d}", liked, video.getLikeCount());
			System.out.println("Response: " + jsonResponse);
			resp.setStatus(HttpServletResponse.SC_OK);
			resp.getWriter().write(jsonResponse);
		} catch (Exception e) {
			resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			resp.getWriter().write("{\"error\": \"Server error: " + e.getMessage() + "\"}");
		}
	}

	private void doPostUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        List<Category> categoryList = categoryService.getAllCategories();
		req.setAttribute("categoryList", categoryList);
		try {
			int id = Integer.parseInt(req.getParameter("id"));
			String title = req.getParameter("title");
			String videoUrl = req.getParameter("videoUrl");
			Part poster = req.getPart("poster");
//			int categoryId = Integer.parseInt(req.getParameter("categoryid"));
			String description = req.getParameter("description");
			Video video = videoService.findById(id);
			
			if (video != null) {
				video.setVideoUrl("https://www.youtube.com/watch?v=" + videoUrl);
				String videoHref = video.getVideoUrl().split("v=")[1].split("&")[0];
				if (poster.getSize() > 0) {
	                String fileName = poster.getSubmittedFileName();
	                String logicPath = "IMG/" + videoHref + "_" + fileName;
	                String physicPath = req.getServletContext().getRealPath("/" + logicPath);
	                File imgFolder = new File(req.getServletContext().getRealPath("/IMG"));
	                if (!imgFolder.exists()) {
	                    imgFolder.mkdirs();
	                }
	                poster.write(physicPath);
	                video.setPoster(logicPath);
	            } else {
	                video.setPoster(video.getPoster());
	            }
				video.setTitle(title);
				video.setVideoUrl(videoHref);
				video.setDescription(description);
//				video.getCategory().setId(categoryId);
				System.out.println(video.getPoster());
				videoService.update(video);
				req.setAttribute("message", "Video updated successfully!");
			} else {
				req.setAttribute("error", "Video not found!");
			}
		} catch (Exception e) {
			req.setAttribute("error", "Failed to update video: " + e.getMessage());
			e.printStackTrace();
		}

		resp.sendRedirect(req.getContextPath() + "/video/management");
	}

	private void doPostDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int id = Integer.parseInt(req.getParameter("id"));
			Video video = videoService.findById(id);
			video = videoService.findByHref(video.getVideoUrl());
			videoService.delete(video.getVideoUrl());
		} catch (Exception e) {
			req.setAttribute("error", "Failed to delete video: " + e.getMessage());
			e.printStackTrace();
		}
		resp.sendRedirect(req.getContextPath() + "/video/management");
	}

	private void doPostreset(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.sendRedirect(req.getContextPath() + "/video/management");
	}
	
	private void doPostCreate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    try {
	        req.setCharacterEncoding("UTF-8");
	        resp.setCharacterEncoding("UTF-8");

	        String title = req.getParameter("title");
	        String videoUrl = req.getParameter("videoUrl");
	        String videoHref = videoUrl.split("v=")[1].split("&")[0];
	        Part poster = req.getPart("poster");
	        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
	        String description = req.getParameter("description");
	        Boolean isActive = true;
	        
	        String imgFolderPath = req.getServletContext().getRealPath("/IMG/");
            File imgFolder = new File(imgFolderPath);
            if (!imgFolder.exists()) {
                imgFolder.mkdirs();
            }

	        Category category = categoryService.getCategoryById(categoryId);
	        if (category == null) {
	            req.setAttribute("error", "Invalid category selected.");
	            doGetCreate(req, resp);
	            return;
	        }

	        HttpSession session = req.getSession();
	        User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
	        if (currentUser == null) {
	            req.setAttribute("error", "You must be logged in to create a video.");
	            resp.sendRedirect(req.getContextPath() + "/index");
	            return;
	        }

	        Video newVideo = new Video();
	        if (poster.getSize() > 0) {
                String fileName = poster.getSubmittedFileName();
                String logicPath = "IMG/" + newVideo.getVideoUrl() + "_" + fileName;
                String physicPath = req.getServletContext().getRealPath("/" + logicPath);
                poster.write(physicPath);
                newVideo.setPoster(logicPath);
            }
	        newVideo.setTitle(title);
	        newVideo.setVideoUrl(videoHref);
	        newVideo.setCategory(category);
	        newVideo.setDescription(description);
	        newVideo.setIsActive(isActive);
	        newVideo.setUser(currentUser);
	        newVideo.setViewCount(0);
	        newVideo.setLikeCount(0);
	        newVideo.setShareCount(0);
	        newVideo.setCommentCount(0);
	        videoService.create(newVideo);
	        req.setAttribute("message", "Video created successfully!");
	        resp.sendRedirect(req.getContextPath() + "/video/management");
	    } catch (NumberFormatException e) {
	        req.setAttribute("error", "Invalid input data: " + e.getMessage());
	        doGetCreate(req, resp);
	    } catch (Exception e) {
	        req.setAttribute("error", "Failed to create video: " + e.getMessage());
	        e.printStackTrace();
	        doGetCreate(req, resp);
	    }
	}
}
