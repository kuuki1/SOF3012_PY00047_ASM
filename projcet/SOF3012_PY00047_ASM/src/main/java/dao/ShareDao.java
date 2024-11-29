package dao;

import entity.Share;
import java.util.List;

public interface ShareDao {
    Share findById(Integer id);
    List<Share> findByVideoId(Integer id);
    List<Share> findAll();
    List<Share> findAll(int pageNumber, int pageSize);
    Share create(Share share);
    Share update(Share share);
    Share delete(Share share);
}
