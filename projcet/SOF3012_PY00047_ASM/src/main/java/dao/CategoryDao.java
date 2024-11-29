package dao;

import java.util.List;
import entity.Category;

public interface CategoryDao {
    Category findById(Integer id);
    Category findByName(String name);
    List<Category> findAll();
    List<Category> findAll(int pageNumber, int pageSize);
    Category create(Category entity);
    Category update(Category entity);
    Category delete(Category entity);
}
