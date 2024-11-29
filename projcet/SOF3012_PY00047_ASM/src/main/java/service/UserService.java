package service;

import java.util.List;

import entity.User;

public interface UserService {
	User findById(Integer id);
	User findByEmail(String email);
	User findByUsername(String username);
	User login(String username, String password);
	User resetPass(String email);
	List<User> findAll();
	List<User> findAll(int pageNumber, int pageSize);
	User regiser(String userName, String fullName, String password, String email);
	User regiser(String userName, String fullName, String password, String email, Boolean isAdmin);
	User registerGoogleUser(String email, String name);
	User updatePass(String email, String pass);
	User update(User entity);
	User delete(String username);
}
