package controller;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
					if(!isValidPassword(newPass)) {
						req.setAttribute("errorMessage", "Password has at least 8 characters!");
						doGetAccount(req, resp);
						return;
					}
					if(newPass.equals(RNPass)) {
						userService.updatePass(email, RNPass);
						req.setAttribute("successMessage", "Password has been updated successfully!");
						doGetAccount(req, resp);
						return;
					}else {
						req.setAttribute("errorMessage", "New and re-entered passwords do not match!");
						doGetAccount(req, resp);
					}
				}else {
					req.setAttribute("errorMessage", "Passwords do not match!");
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
	
	public static boolean isValidPassword(String password) {
        String regex = "^.{8,}$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(password);
        return matcher.matches();
    }
}
