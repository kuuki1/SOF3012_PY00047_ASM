package util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaUtil {
	
	private static EntityManagerFactory factory;
	
	public static EntityManager getEntityManager() {
		if(factory == null || factory.isOpen()) {
			factory = Persistence.createEntityManagerFactory("SOF3012_PY00047_ASM");
		}
		return factory.createEntityManager();
	}
	
	public static void shutDown() {
		if(factory != null && factory.isOpen()) {
			factory.close();
		}
		factory = null;
	}
	
}
