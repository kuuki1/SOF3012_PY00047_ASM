package service;

import java.util.List;

import entity.Category;

public interface CategoryService {
 	Category getCategoryById(Integer id);
    Category getCategoryByName(String name);
    List<Category> getAllCategories();
    List<Category> getCategories(int pageNumber, int pageSize);
    Category createCategory(Category category);
    Category updateCategory(Category category);
    Category deleteCategory(Category category);
}
