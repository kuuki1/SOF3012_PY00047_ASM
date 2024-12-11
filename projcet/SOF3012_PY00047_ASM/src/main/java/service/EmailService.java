package service;

import javax.servlet.ServletContext;

import entity.Share;
import entity.User;

public interface EmailService {
	void sendEmail(ServletContext context, User recipent, String type);
	void sendEmailShare(String localhost, ServletContext context, Share recipent, String type, User user);
}
