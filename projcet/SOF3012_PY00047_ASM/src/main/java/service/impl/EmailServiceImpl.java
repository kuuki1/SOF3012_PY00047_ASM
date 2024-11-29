package service.impl;

import javax.servlet.ServletContext;

import entity.Share;
import entity.User;
import entity.Video;
import service.EmailService;
import service.VideoService;
import util.EmailUtil;
import util.EncryptDecrypt;

public class EmailServiceImpl implements EmailService{
	
	private static final String EMAIL_WELCOME_SUBJECT = "Welcome to JACKER";
	private static final String EMAIL_FORGOT_PASSWORD = "JACKER - New password";
	private static final String EMAIL_SHARE_VIDEOS = "SHARE VIDEO";
	private VideoService videoService = new VideoServiceImpl();

	@Override
	public void sendEmail(ServletContext context, User recipent, String type) {
        String host = context.getInitParameter("host");
        String port = context.getInitParameter("port");
        String user = context.getInitParameter("user");
        String pass = context.getInitParameter("pass");
        
        try {
			String content = null;
			String subject = null;
			switch(type){
				case "welcome":
					subject = EMAIL_WELCOME_SUBJECT ;
					content = "Welcome to JACKER where you can watch videos comfortably without fear of anyone noticing :>";
					break;
				case "forgot":
				    subject = EMAIL_FORGOT_PASSWORD;
				    String decryptedMessage = EncryptDecrypt.decrypt(recipent.getPassword());
				    content = "Hello, \n\nYour new password is: " + decryptedMessage + 
				              "\nPlease log in and change your password immediately.\n\nThank!";
				    break;
				case "share":
					subject = EMAIL_SHARE_VIDEOS;
					
					content = "";
					break;
				default:
					subject = "JACKER";
					content = "Maybe This email is wrong, don't care about it";
			}
			EmailUtil.sendEmail(host, port, user, pass, recipent.getEmail(), subject, content);;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void sendEmailShare(String localhost, ServletContext context, Share recipent, String type) {
		String host = context.getInitParameter("host");
        String port = context.getInitParameter("port");
        String user = context.getInitParameter("user");
        String pass = context.getInitParameter("pass");
        String href = localhost.split("id=")[1].split("&")[0];
        Video video = videoService.findByHref(href);

        try {
			String content = null;
			String subject = null;
			switch(type){
				case "share":
					subject = EMAIL_SHARE_VIDEOS;
					
					content = "Watch: '"+ video.getTitle() + "'" +
							"\n\nLink: " + localhost;
					break;
				default:
					subject = "JACKER";
					content = "Maybe This email is wrong, don't care about it";
			}
			EmailUtil.sendEmail(host, port, user, pass, recipent.getShareEmail(), subject, content);;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
