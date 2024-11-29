package service.impl;

import java.util.List;
import dao.CategoryDao;
import dao.impl.CategoryDaoImpl;
import entity.Category;
import service.CategoryService;

public class CategoryServiceImpl implements CategoryService {

    private CategoryDao dao;

    // Constructor
    public CategoryServiceImpl() {
        this.dao = new CategoryDaoImpl();
    }

    @Override
    public Category getCategoryById(Integer id) {
        return dao.findById(id);
    }

    @Override
    public Category getCategoryByName(String name) {
        return dao.findByName(name);
    }

    @Override
    public List<Category> getAllCategories() {
        return dao.findAll();
    }

    @Override
    public List<Category> getCategories(int pageNumber, int pageSize) {
        return dao.findAll(pageNumber, pageSize);
    }

    @Override
    public Category createCategory(Category category) {
        return dao.create(category);
    }

    @Override
    public Category updateCategory(Category category) {
        return dao.update(category);
    }

    @Override
    public Category deleteCategory(Category category) {
        return dao.delete(category);
    }
}
