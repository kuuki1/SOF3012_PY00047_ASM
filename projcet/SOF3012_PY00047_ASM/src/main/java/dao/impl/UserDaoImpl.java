package dao.impl;

import java.util.List;

import dao.Dao;
import dao.UserDao;
import entity.User;

public class UserDaoImpl extends Dao<User> implements UserDao {

	@Override
	public User findById(Integer id) {
		// TODO Auto-generated method stub
		return super.findById(User.class, id);
	}

	@Override
	public User findByEmail(String email) {
		// TODO Auto-generated method stub
		String sql = "SELECT o FROM User o WHERE o.email = ?1";
		return super.findOne(User.class, sql, email);
		
	}
	
	@Override
	public User findByUsername(String username) {
		String sql = "SELECT o FROM User o WHERE o.username = ?1";
		return super.findOne(User.class, sql, username);
	}

	@Override
	public User findByUsernameAndPassword(String username, String password) {
		String sql = "SELECT o FROM User o WHERE o.username = ?1 AND o.password = ?2";
		return super.findOne(User.class, sql, username, password);
	}

	@Override
	public User update(User entity) {
		return super.update(entity);
	}
	
	@Override
	public User create(User entity) {
		return super.create(entity);
	}
	
	@Override
	public User delete(User entity) {
		return super.delete(entity);
	}
	
	@Override
	public List<User> findAll() {
		return super.findAll(User.class, true);
	}

	@Override
	public List<User> findAll(int pageNumber, int pageSize) {
		return super.findAll(User.class, true, pageNumber, pageSize);
	}	
}
