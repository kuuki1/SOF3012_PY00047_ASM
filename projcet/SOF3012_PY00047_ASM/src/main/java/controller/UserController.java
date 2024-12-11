package controller;

import java.io.IOException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;


import constant.SessionAttr;
import entity.User;
import service.EmailService;
import service.UserService;
import service.impl.EmailServiceImpl;
import service.impl.UserServiceImpl;
import util.EncryptDecrypt;

@WebServlet({
    "/login",
    "/google-login",
    "/google-callback",
    "/logout",
    "/register",
    "/user/management",
    "/user/management/edit/*",
    "/user/management/update",
    "/user/management/delete",
    "/user/management/reset"
})
public class UserController extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final String CLIENT_ID = "1081042700782-scce0j0oe6t0cac8pg2mm6fr8qdc1tgs.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:8080/SOF3012_PY00047_ASM/google-callback";
    private static final String AUTH_URI = "https://accounts.google.com/o/oauth2/auth";
    private static final String TOKEN_URI = "https://oauth2.googleapis.com/token";
	
	private UserService userService = new UserServiceImpl();
	private EmailService emailService = new EmailServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    HttpSession session = req.getSession();
	    String path = req.getServletPath();
	    String pathInfo = req.getPathInfo();

	    if (path.equals("/login")) {
	        doGetLogin(req, resp);
	    } else if (path.equals("/logout")) {
	        doGetLogout(session, req, resp);
	    } else if (path.equals("/register")) {
	        doGetRegiser(req, resp);
	    } else if (path.equals("/user/management")) {
	    	User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
	    	if(currentUser != null && currentUser.getIsAdmin() == Boolean.FALSE) {
	    		resp.sendRedirect(req.getContextPath() + "/index");
	    		return;
	    	}
	        doGetManagement(req, resp);
	    } else if (path.equals("/user/management/edit") && pathInfo != null) {
	    	User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
	    	if(currentUser != null && currentUser.getIsAdmin() == Boolean.FALSE) {
	    		resp.sendRedirect(req.getContextPath() + "/index");
	    		return;
	    	}
	        doGetEdit(req, resp);
	    } else if (path.equals("/google-login")) {
            doGoogleLogin(req, resp);
        } else if (path.equals("/google-callback")) {
            doGoogleCallback(req, resp);
        } else {
	        resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Page not found");
	    }
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json");
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		HttpSession session  = req.getSession();
		String path = req.getServletPath();
		if(path.equals("/login")) {
			doPossLogin(session, req, resp);
		}else if(path.equals("/register")) {
			doPossRegiser(session, req, resp);
		}else if(path.equals("/user/management/update")) {
			User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
	    	if(currentUser != null && currentUser.getIsAdmin() == Boolean.FALSE) {
	    		resp.sendRedirect(req.getContextPath() + "/index");
	    		return;
	    	}
			doPostUpdate(req, resp);
		}else if(path.equals("/user/management/delete")) {
			User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
	    	if(currentUser != null && currentUser.getIsAdmin() == Boolean.FALSE) {
	    		resp.sendRedirect(req.getContextPath() + "/index");
	    		return;
	    	}
			doPostDelete(req, resp);
		}else if(path.equals("/user/management/reset")) {
			User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
	    	if(currentUser != null && currentUser.getIsAdmin() == Boolean.FALSE) {
	    		resp.sendRedirect(req.getContextPath() + "/index");
	    		return;
	    	}
			doPostReset(req, resp);
		}
	}
	
	private void doGetLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/view/user/login.jsp").forward(req, resp);
	}
	
	private void doGetEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String pathInfo = req.getPathInfo();
	    System.out.println("Path Info in doGetEdit: " + pathInfo);
	    List<User> userList = userService.findAll();
	    req.setAttribute("userList", userList);
	    if (pathInfo != null && pathInfo.startsWith("/")) {
	    	User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
	    	if(currentUser != null && currentUser.getIsAdmin() == Boolean.FALSE) {
	    		resp.sendRedirect(req.getContextPath() + "/index");
	    		return;
	    	}else if(currentUser == null) {
	    		resp.sendRedirect(req.getContextPath() + "/login");
	    		return;
	    	}
	        try {
	            String idStr = pathInfo.substring(1);
	            int id = Integer.parseInt(idStr);
	            
	            User user = userService.findById(id);
	            if (user != null) {
	                req.setAttribute("user", user);
	                System.out.println("User found: " + user);
	            } else {
	                System.out.println("User not found with ID: " + id);
	                req.setAttribute("user", null);
	            }
	        } catch (NumberFormatException e) {
	            System.err.println("Invalid user ID format: " + e.getMessage());
	            req.setAttribute("user", null);
	        }
	    } else {
	        req.setAttribute("user", null);
	    }

	    req.getRequestDispatcher("/view/admin/userManagement.jsp").forward(req, resp);
	}

	
	private void doGetManagement(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		User currentUser = (User) session.getAttribute(SessionAttr.CURRENT_USER);
		if(currentUser != null && currentUser.getIsAdmin() == Boolean.TRUE) {
			List<User> userList = userService.findAll();
		    req.setAttribute("userList", userList);
		    req.getRequestDispatcher("/view/admin/userManagement.jsp").forward(req, resp);
		} else if(currentUser != null && currentUser.getIsAdmin() == Boolean.FALSE) {
			req.getRequestDispatcher("/view/user/Management.jsp").forward(req, resp);
		} else {
			resp.sendRedirect(req.getContextPath() + "/login");
		}
	}

	
	private void doGetLogout(HttpSession session, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		session.removeAttribute(SessionAttr.CURRENT_USER);
		resp.sendRedirect("index");
	}
	
	private void doGetRegiser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/view/user/regiser.jsp").forward(req, resp);
	}
	
	private void doGoogleLogin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String googleAuthUrl = AUTH_URI + 
            "?client_id=" + CLIENT_ID +
            "&redirect_uri=" + REDIRECT_URI +
            "&response_type=code" +
            "&scope=email%20profile" +
            "&access_type=offline" +
            "&prompt=consent";
        resp.sendRedirect(googleAuthUrl);
    }

    private void doGoogleCallback(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        if (code == null) {
            resp.sendRedirect("login");
            return;
        }
        try {
            GoogleTokenResponse tokenResponse = new GoogleAuthorizationCodeTokenRequest(
                new NetHttpTransport(),
                JacksonFactory.getDefaultInstance(),
                TOKEN_URI,
                CLIENT_ID,
                CLIENT_SECRET,
                code,
                REDIRECT_URI
            ).execute();
            GoogleIdToken idToken = tokenResponse.parseIdToken();
            if (idToken != null) {
                GoogleIdToken.Payload payload = idToken.getPayload();
                String email = payload.getEmail();
                String name = (String) payload.get("name");
                boolean emailVerified = payload.getEmailVerified();
                String userId = payload.getSubject();
                System.out.println(userId);
                if (emailVerified) {
                    User user = userService.findByEmail(email);
                    if (user == null) {
                        user = userService.registerGoogleUser(email, name);
                    }
                    HttpSession session = req.getSession();
                    session.setAttribute(SessionAttr.CURRENT_USER, user);
                    resp.sendRedirect("index");
                } else {
                    resp.sendRedirect("login?error=Email chưa được xác thực");
                }
            } else {
                resp.sendRedirect("login?error=Không nhận được thông tin đăng nhập từ Google");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("login?error=Đăng nhập bằng Google thất bại");
        }
    }
	
	private void doPossLogin(HttpSession session, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = req.getParameter("Username");
        String password = req.getParameter("Password");
		User user = userService.login(username, password);
		if(user != null) {
			session.setAttribute(SessionAttr.CURRENT_USER, user);
			resp.sendRedirect("index");
		}else {
			req.setAttribute("errorMessage", "Password or account mismatch!");
			doGetLogin(req, resp);
		}
	}
	
	private void doPossRegiser(HttpSession session,HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
		String username = req.getParameter("Username");
		String fullname = req.getParameter("Fullname");
        String password = req.getParameter("Password");
        String cfmPass = req.getParameter("cfmPass");
        User userEx = userService.findByUsername(username);
        
        if(userEx != null) {
        	req.setAttribute("errorMessage", "Username already exists!");
			req.getRequestDispatcher("/view/user/regiser.jsp").forward(req, resp);
			return;
        }
        if(!isValidName(fullname)) {
        	req.setAttribute("errorMessage", "Fullname is not valid!");
			req.getRequestDispatcher("/view/user/regiser.jsp").forward(req, resp);
			return;
        }
        if(!isValidPassword(password)) {
        	req.setAttribute("errorMessage", "Password has at least 8 characters!");
			req.getRequestDispatcher("/view/user/regiser.jsp").forward(req, resp);
			return;
        }
		if(!cfmPass.equals(password)) {
			req.setAttribute("errorMessage", "Password does not match!");
			req.getRequestDispatcher("/view/user/regiser.jsp").forward(req, resp);
			return;
		}
		
		String email = req.getParameter("Email");
		if(!isValidGmail(email)) {
			req.setAttribute("errorMessage", "Invalid email!");
			req.getRequestDispatcher("/view/user/regiser.jsp").forward(req, resp);
			return;
		}
		User user = userService.regiser(username, fullname, cfmPass, email);
		if (user != null) {
			emailService.sendEmail(getServletContext(), user, "welcome");
		    session.setAttribute(SessionAttr.CURRENT_USER, user);
		    resp.sendRedirect("index");
		} else {
		    System.out.println("Failed to register user: " + username);
		    resp.sendRedirect("register");
		}
	}
	
	private void doPostUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		try {
            int id = Integer.parseInt(req.getParameter("id"));
            String username = req.getParameter("username");
            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");
            boolean isAdmin = Boolean.parseBoolean(req.getParameter("isAdmin"));
            if(!isValidName(fullname)) {
            	req.setAttribute("errorMessage", "Fullname is not valid!");
    			req.getRequestDispatcher("/view/user/regiser.jsp").forward(req, resp);
    			return;
            }
            if(!isValidGmail(email)) {
    			req.setAttribute("errorMessage", "Invalid email!");
    			req.getRequestDispatcher("/view/user/regiser.jsp").forward(req, resp);
    			return;
    		}
            User user = userService.findById(id);
            if (user != null) {
                user.setUsername(username);
                user.setFullname(fullname);
                user.setEmail(email);
                user.setIsAdmin(isAdmin);
                user.setIsActive(Boolean.TRUE);
                userService.update(user);
                req.setAttribute("message", "User updated successfully!");
            } else {
                req.setAttribute("errorMessage", "User not found!");
                doGetManagement(req, resp);
                return;
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Failed to update user: " + e.getMessage());
            doGetManagement(req, resp);
            return;
        }
		resp.sendRedirect(req.getContextPath() + "/user/management");
    }

    private void doPostDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            User user = userService.findById(id);
            userService.delete(user.getUsername());
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Failed to delete user: " + e.getMessage());
            doGetManagement(req, resp);
            return;
        }
        resp.sendRedirect(req.getContextPath() + "/user/management");
    }

    private void doPostReset(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	resp.sendRedirect(req.getContextPath() + "/user/management");
    }
    
    public static boolean isValidName(String name) {
        String regex = "^[A-Za-z]+([\\s][A-Za-z]+)*$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(name);
        return matcher.matches();
    }
    
	public static boolean isValidGmail(String email) {
	    String regex = "^[a-zA-Z0-9._%+-]+@gmail\\.com$";
	    Pattern pattern = Pattern.compile(regex);
	    Matcher matcher = pattern.matcher(email);
	    return matcher.matches();
	}
	
	public static boolean isValidPassword(String password) {
        String regex = "^.{8,}$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(password);
        return matcher.matches();
    }
}
