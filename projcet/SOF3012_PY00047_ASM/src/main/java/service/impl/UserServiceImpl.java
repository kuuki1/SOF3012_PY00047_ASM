package service.impl;

import java.util.List;
import java.util.Random;

import dao.UserDao;
import dao.impl.UserDaoImpl;
import entity.User;
import service.UserService;
import util.EncryptDecrypt;

public class UserServiceImpl implements UserService{

	private UserDao dao;
	
	public UserServiceImpl() {
		dao = new UserDaoImpl();
	}
	
	@Override
	public User findById(Integer id) {
		return dao.findById(id);
	}

	@Override
	public User findByEmail(String email) {
		return dao.findByEmail(email);
	}

	@Override
	public User findByUsername(String username) {
		return dao.findByUsername(username);
	}

	@Override
	public User login(String username, String password) {
		try {
			User user = dao.findByUsername(username);
			String decryptedMessage = EncryptDecrypt.decrypt(user.getPassword());
			if(password.equals(decryptedMessage)) {
				return user;
			}else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public User resetPass(String email) {
		User exisUser = findByEmail(email);
		if(exisUser != null) {
			try {
				String newPassword = generateRandomPassword(8);
				String passwords = EncryptDecrypt.encrypt(newPassword);
				exisUser.setPassword(passwords);
				return dao.update(exisUser);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	private String generateRandomPassword(int length) {
	    String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	    StringBuilder result = new StringBuilder();
	    Random random = new Random();
	    for (int i = 0; i < length; i++) {
	        int index = random.nextInt(characters.length());
	        result.append(characters.charAt(index));
	    }
	    return result.toString();
	}

	@Override
	public List<User> findAll() {
		return dao.findAll();
	}

	@Override
	public List<User> findAll(int pageNumber, int pageSize) {
		return dao.findAll(pageNumber, pageSize);
	}

	@Override
	public User regiser(String userName, String fullName, String password, String email) {
		User user = new User();
		try {
			user.setUsername(userName);
			user.setFullname(fullName);
			String passwords = EncryptDecrypt.encrypt(password);
			user.setPassword(passwords);
			user.setEmail(email);
			user.setIsAdmin(Boolean.FALSE);
			user.setIsActive(Boolean.TRUE);
			return dao.create(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public User regiser(String userName, String fullName, String password, String email, Boolean isAdmin) {
		try {
			User user = new User();
			user.setUsername(userName);
			user.setFullname(fullName);
			String passwords = EncryptDecrypt.encrypt(password);
			user.setPassword(passwords);
			user.setEmail(email);
			user.setIsAdmin(isAdmin);
			user.setIsActive(Boolean.TRUE);
			return dao.create(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public User updatePass(String email, String pass) {
		try {
			User user = findByEmail(email);
			String passwords = EncryptDecrypt.encrypt(pass);
			user.setPassword(passwords);
			return dao.update(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public User update(User entity) {
		return dao.update(entity);
	}

	@Override
	public User delete(String username) {
		User user = dao.findByUsername(username);
		user.setIsActive(Boolean.FALSE);
		return dao.update(user);
	}
	
	@Override
	public User registerGoogleUser(String email, String name) {
	    User user = new User();
	    user.setEmail(email);
	    user.setFullname(name);
	    user.setUsername(email);
	    user.setIsAdmin(Boolean.FALSE);
	    user.setIsActive(Boolean.TRUE);
	    user.setPassword("12345678");
	    dao.create(user);
	    return user;
	}
}
