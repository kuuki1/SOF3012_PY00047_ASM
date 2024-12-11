package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import constant.SessionAttr;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import service.VideoService;
import service.impl.VideoServiceImpl;
import entity.*;
import util.JpaUtil;

import java.io.IOException;
import java.util.List;

@WebServlet({"/favorite/statistics", "/favorite/user/statistics"})
public class FavoriteStatisticsController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private VideoService videoService = new VideoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String servletPath = req.getServletPath();
        List<Video> videoList = videoService.findAll();
        req.setAttribute("videoList", videoList);
        
        HttpSession session = req.getSession();
		User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);

        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();

            if ("/favorite/statistics".equals(servletPath)) {
            	if(currentUser != null && currentUser.getIsAdmin() == Boolean.FALSE) {
        			req.getRequestDispatcher("/view/user/Management.jsp").forward(req, resp);
        			return;
        		} 
            	if(currentUser == null){
        			resp.sendRedirect(req.getContextPath() + "/login");
        			return;
        		}
                String jpql = "SELECT NEW entity.FavoriteStatistic(v.id, v.title, COUNT(h.id), MIN(h.likedDate), MAX(h.likedDate)) " +
                              "FROM Video v LEFT JOIN History h ON v.id = h.video.id AND h.isLiked = true " +
                              "GROUP BY v.id, v.title";
                Query query = em.createQuery(jpql);
                List<FavoriteStatistic> stats = query.getResultList();

                req.setAttribute("stats", stats);
                req.getRequestDispatcher("/view/admin/favorite_statistics.jsp").forward(req, resp);

            } else if ("/favorite/user/statistics".equals(servletPath)) {
            	if(currentUser != null && currentUser.getIsAdmin() == Boolean.FALSE) {
        			req.getRequestDispatcher("/view/user/Management.jsp").forward(req, resp);
        			return;
        		} 
            	if(currentUser == null){
        			resp.sendRedirect(req.getContextPath() + "/login");
        			return;
        		}
                String videoIdParam = req.getParameter("videoId");
                if (videoIdParam == null || videoIdParam.isEmpty()) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Video ID is null.");
                    return;
                }

                int videoId = Integer.parseInt(videoIdParam);
                String jpql = "SELECT NEW entity.FavoriteUser(u.username, u.fullname, u.email, h.likedDate) " +
                			  "FROM User u INNER JOIN History h ON u.id = h.user.id " +
                			  "WHERE h.video.id = :videoId AND h.isLiked = true";
                Query query = em.createQuery(jpql);
                query.setParameter("videoId", videoId);
                List<FavoriteUser> users = query.getResultList();

                req.setAttribute("users", users);
                req.getRequestDispatcher("/view/admin/favorite_users.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request.");
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}
