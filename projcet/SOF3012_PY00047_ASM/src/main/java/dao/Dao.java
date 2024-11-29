package dao;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import util.JpaUtil;

public class Dao<T> {
    protected static final EntityManager entityManager = JpaUtil.getEntityManager();

    public T findById(Class<T> clazz, Integer id) {
        return entityManager.find(clazz, id);
    }

    public List<T> findAll(Class<T> clazz, boolean existIsActive) {
        EntityManager em = JpaUtil.getEntityManager();
        List<T> resultList = null;
        try {
            String entityName = clazz.getSimpleName();
            StringBuilder sql = new StringBuilder("SELECT o FROM ").append(entityName).append(" o");
            if (existIsActive) {
                sql.append(" WHERE o.isActive = true");
            }
            TypedQuery<T> query = em.createQuery(sql.toString(), clazz);
            resultList = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (em.isOpen()) {
                em.close();
            }
        }
        return resultList;
    }

    public List<T> findAll(Class<T> clazz, boolean existIsActive, int pageNumber, int pageSize) {
        String entityName = clazz.getSimpleName();
        StringBuilder sql = new StringBuilder("SELECT o FROM ").append(entityName).append(" o");
        if (existIsActive) {
            sql.append(" WHERE o.isActive = true");
        }
        TypedQuery<T> query = entityManager.createQuery(sql.toString(), clazz);
        query.setFirstResult((pageNumber - 1) * pageSize);
        query.setMaxResults(pageSize);
        return query.getResultList();
    }

    public T findOne(Class<T> clazz, String sql, Object... params) {
        TypedQuery<T> query = entityManager.createQuery(sql, clazz);
        setParameters(query, params);
        List<T> result = query.getResultList();
        return result.isEmpty() ? null : result.get(0);
    }

    public List<T> findMany(Class<T> clazz, String sql, Object... params) {
        TypedQuery<T> query = entityManager.createQuery(sql, clazz);
        setParameters(query, params);
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    public List<Object[]> findManyByNativeQuery(Class<T> clazz, String sql, Object... params) {
        Query query = entityManager.createNativeQuery(sql, clazz);
        setParameters(query, params);
        return query.getResultList();
    }

    public T create(T entity) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(entity);
            transaction.commit();
            return entity;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Error creating entity: " + e.getMessage(), e);
        } finally {
            if (em.isOpen()) {
                em.close();
            }
        }
    }

    public T update(T entity) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            entity = em.merge(entity);
            transaction.commit();
            return entity;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Error updating entity: " + e.getMessage(), e);
        } finally {
            if (em.isOpen()) {
                em.close();
            }
        }
    }

    public T delete(T entity) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.remove(em.contains(entity) ? entity : em.merge(entity));
            transaction.commit();
            return entity;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Error deleting entity: " + e.getMessage(), e);
        } finally {
            if (em.isOpen()) {
                em.close();
            }
        }
    }

    public void refresh(T entity) {
        try {
            entityManager.refresh(entity);
        } catch (Exception e) {
            throw new RuntimeException("Error refreshing entity: " + e.getMessage(), e);
        }
    }

    public void detach(T entity) {
        try {
            entityManager.detach(entity);
        } catch (Exception e) {
            throw new RuntimeException("Error detaching entity: " + e.getMessage(), e);
        }
    }

    public void closeEntityManager() {
        if (entityManager.isOpen()) {
            entityManager.close();
        }
    }

    private void setParameters(Query query, Object... params) {
        if (params != null && params.length > 0) {
            for (int i = 0; i < params.length; i++) {
                query.setParameter(i + 1, params[i]); // Sử dụng i + 1 vì tham số bắt đầu từ 1
            }
        }
    }
    
    public int executeUpdateQuery(String sql, Object... params) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Query query = entityManager.createQuery(sql);
            setParameters(query, params);
            int result = query.executeUpdate();
            transaction.commit();
            return result;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Error executing update query: " + e.getMessage(), e);
        }
    }

}
