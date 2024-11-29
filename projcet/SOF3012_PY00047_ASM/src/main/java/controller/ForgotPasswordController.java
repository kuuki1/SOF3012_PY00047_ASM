package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.User;
import service.EmailService;
import service.UserService;
import service.impl.EmailServiceImpl;
import service.impl.UserServiceImpl;

@WebServlet("/forgotPassword")
public class ForgotPasswordController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserService userService = new UserServiceImpl();
    private EmailService emailService = new EmailServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	req.getRequestDispatcher("/view/user/forgotPassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        HttpSession session = req.getSession();

        User existingUser = userService.findByEmail(email);
        if (existingUser == null) {
            session.setAttribute("errorMessage", "Email không tồn tại trong hệ thống.");
            resp.sendRedirect(req.getContextPath() + "/forgotPassword.jsp");
            return;
        }

        User updatedUser = userService.resetPass(email);
        if (updatedUser == null) {
            session.setAttribute("errorMessage", "Không thể đặt lại mật khẩu. Vui lòng thử lại.");
            resp.sendRedirect(req.getContextPath() + "/forgotPassword.jsp");
            return;
        }
        try {
            emailService.sendEmail(req.getServletContext(), updatedUser, "forgot");
            session.setAttribute("successMessage", "Mật khẩu mới đã được gửi tới email của bạn.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Có lỗi xảy ra khi gửi email. Vui lòng thử lại sau.");
        }

        resp.sendRedirect(req.getContextPath() + "/login");
    }
}
