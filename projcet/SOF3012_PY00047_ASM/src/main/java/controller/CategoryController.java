package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import entity.Video;
import entity.Category;
import service.VideoService;
import service.CategoryService;
import service.impl.VideoServiceImpl;
import service.impl.CategoryServiceImpl;

@WebServlet({
    "/category/*",
    "/category/management",
    "/category/management/edit/*",
    "/category/management/create",
    "/category/management/update",
    "/category/management/delete",
    "/category/management/reset"
})
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int VIDEO_MAX_PAGE_SIZE = 6;
    private VideoService videoService = new VideoServiceImpl();
    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        String pathInfo = req.getPathInfo();
        System.out.println("Servlet Path: " + path);
        System.out.println("Path Info: " + pathInfo);

        if (path.equals("/category") && pathInfo != null) {
            doGetVideoByCategory(req, resp);
        } else if (path.equals("/category/management")) {
            doGetManagement(req, resp);
        } else if (path.equals("/category/management/edit") && pathInfo != null) {
            doGetEditCategory(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Page not found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if (path.equals("/category/management/create")) {
            doPostCreateCategory(req, resp);
        } else if (path.equals("/category/management/update")) {
            doPostUpdateCategory(req, resp);
        } else if (path.equals("/category/management/delete")) {
            doPostDeleteCategory(req, resp);
        } else if (path.equals("/category/management/reset")) {
            resp.sendRedirect(req.getContextPath() + "/category/management");
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Action not found");
        }
    }

    private void doGetVideoByCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categories = categoryService.getAllCategories();
        req.setAttribute("categories", categories);
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Category ID is missing");
            return;
        }
        try {
            Integer categoryId = Integer.parseInt(pathInfo.substring(1));
            Category category = categoryService.getCategoryById(categoryId);

            if (category == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Category not found");
                return;
            }
            String pageNumberParam = req.getParameter("page");
            int currentPage = (pageNumberParam == null) ? 1 : Integer.parseInt(pageNumberParam);
            int totalVideos = videoService.countVideosByCategoryId(categoryId);
            if (totalVideos == 0) {
                req.setAttribute("category", category);
                req.setAttribute("videos", null);
                req.setAttribute("message", "No videos available for this category.");
                req.getRequestDispatcher("/view/user/category.jsp").forward(req, resp);
                return;
            }
            int maxPage = (int) Math.ceil(totalVideos / (double) VIDEO_MAX_PAGE_SIZE);
            if (currentPage < 1 || currentPage > maxPage) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid page number");
                return;
            }
            List<Video> videos = videoService.getVideosByCategoryId(categoryId, currentPage, VIDEO_MAX_PAGE_SIZE);
            req.setAttribute("category", category);
            req.setAttribute("videos", videos);
            req.setAttribute("currentPage", currentPage);
            req.setAttribute("maxPage", maxPage);
            req.getRequestDispatcher("/view/user/category.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Category ID");
        }
    }

    private void doGetManagement(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categories = categoryService.getAllCategories();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/view/admin/categoryManagement.jsp").forward(req, resp);
    }

    private void doGetEditCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Category ID is missing");
            return;
        }
        try {
            Integer categoryId = Integer.parseInt(pathInfo.substring(1));
            Category category = categoryService.getCategoryById(categoryId);
            if (category == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Category not found");
                return;
            }
            req.setAttribute("category", category);
            List<Category> categories = categoryService.getAllCategories();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/view/admin/categoryManagement.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Category ID");
        }
    }

    private void doPostCreateCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
    	String name = req.getParameter("name");
        if (name == null || name.isEmpty()) {
            req.setAttribute("message", "Category name cannot be empty!");
        } else {
            Category category = new Category();
            category.setName(name);
            categoryService.createCategory(category);
            req.setAttribute("message", "Category created successfully!");
        }
        resp.sendRedirect(req.getContextPath() + "/category/management");
    }

    private void doPostUpdateCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
    	String idParam = req.getParameter("id");
        String name = req.getParameter("name");
        if (idParam == null || name == null || name.isEmpty()) {
            req.setAttribute("message", "Invalid category details!");
        } else {
            Integer id = Integer.parseInt(idParam);
            Category category = categoryService.getCategoryById(id);
            if (category != null) {
                category.setName(name);
                categoryService.updateCategory(category);
                req.setAttribute("message", "Category updated successfully!");
            } else {
                req.setAttribute("message", "Category not found!");
            }
        }
        resp.sendRedirect(req.getContextPath() + "/category/management");
    }

    private void doPostDeleteCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
    	String idParam = req.getParameter("id");
        if (idParam == null) {
            req.setAttribute("message", "Invalid category ID!");
        } else {
            Integer id = Integer.parseInt(idParam);
            Category category = categoryService.getCategoryById(id);

            if (category != null) {
                categoryService.deleteCategory(category);
                req.setAttribute("message", "Category deleted successfully!");
            } else {
                req.setAttribute("message", "Category not found!");
            }
        }

        resp.sendRedirect(req.getContextPath() + "/category/management");
    }
}
