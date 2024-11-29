package dao.impl;

import java.util.List;

import dao.CategoryDao;
import dao.Dao;
import entity.Category;

public class CategoryDaoImpl extends Dao<Category> implements CategoryDao {

    @Override
    public Category findById(Integer id) {
        return super.findById(Category.class, id);
    }

    @Override
    public Category findByName(String name) {
        String sql = "SELECT o FROM Category o WHERE o.name = ?0";
        return super.findOne(Category.class, sql, name);
    }

    @Override
    public List<Category> findAll() {
        return super.findAll(Category.class, false);
    }

    @Override
    public List<Category> findAll(int pageNumber, int pageSize) {
        return super.findAll(Category.class, false, pageNumber, pageSize);
    }

    @Override
    public Category create(Category entity) {
        return super.create(entity);
    }

    @Override
    public Category update(Category entity) {
        return super.update(entity);
    }

    @Override
    public Category delete(Category entity) {
        return super.delete(entity);
    }
}
