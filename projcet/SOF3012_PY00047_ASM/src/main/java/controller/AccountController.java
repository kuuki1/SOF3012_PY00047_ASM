package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import constant.SessionAttr;
import entity.User;
import service.UserService;
import service.impl.UserServiceImpl;
import util.EncryptDecrypt;

@WebServlet("/account")
public class AccountController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private UserService userService = new UserServiceImpl();


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGetAccount(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
		if(currentUser != null) {
			try {
				String pass = req.getParameter("pass");
				String newPass = req.getParameter("newPass");
				String RNPass = req.getParameter("RNPass");
				String email = currentUser.getEmail();
				System.out.println(email);
				String oldpass = EncryptDecrypt.decrypt(currentUser.getPassword());
				if(pass.equals(oldpass)) {
					if(newPass.equals(RNPass)) {
						userService.updatePass(email, RNPass);
						doGetAccount(req, resp);
						req.setAttribute("successMessage", "Mật khẩu đã được cập nhật thành công!");
						return;
					}else {
						req.setAttribute("errorMessage", "Mật khẩu mới và nhập lại không khớp!");
						doGetAccount(req, resp);
					}
				}else {
					req.setAttribute("errorMessage", "Mật khẩu không khớp!");
					doGetAccount(req, resp);
				}
				doGetAccount(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	
	private void doGetAccount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
		if(currentUser != null) {
	        req.setAttribute("user", currentUser);
			req.getRequestDispatcher("/view/user/account.jsp").forward(req, resp);
		} else {
			resp.sendRedirect("index");
		}
	}
}
