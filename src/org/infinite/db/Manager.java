package org.infinite.db;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;



public class Manager {

	private static SessionFactory sessionFactory=null;

	static{
		Configuration config = new Configuration().configure("hibernate.cfg.xml");
		sessionFactory = config.buildSessionFactory();
	}
	
	public static Session openSession(){

		Session session = sessionFactory.openSession();
		//session.beginTransaction();
		return session;
	}
	
	public static void commitAndCloseSession(Session s){
		//s.getTransaction().commit();
		s.flush();
		s.disconnect();
		s.close();
		//sessionFactory.close();
        
	}
	
	@SuppressWarnings("unchecked")
	public static List listByQery(Session openedSession,String query){		
		return openedSession.createQuery(query).list();
	}
	
	@SuppressWarnings("unchecked")
	public static List listByQery(String query){
		Session session = openSession();
		List l = listByQery(session, query);
		commitAndCloseSession(session);
		return l;
	}
       
	public static boolean delete(Object o){
		Session session = openSession();
		boolean b = delete(session, o);
		commitAndCloseSession(session);
		return b;
	}
	
	
	public static boolean delete(Session openedSession,Object o){
		Transaction tx = null;
		try {
			tx = openedSession.beginTransaction();
			openedSession.delete(o);
			tx.commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			if (tx != null && tx.isActive())
				tx.rollback();
			return false;
		}	
		return true;
	}
    
	
	public static boolean create(Object o){
		Session session = openSession();
		boolean b = create(session, o);
		commitAndCloseSession(session);
		return b;
	}
	
	
    
	public static boolean create(Session openedSession,Object o) {
		Transaction tx = null;
		try {
			tx = openedSession.beginTransaction();
			openedSession.save(o);
			tx.commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			if (tx != null && tx.isActive())
				tx.rollback();
			return false;
		}
		return true;
	}
	
	
	public static boolean update(Object o){
		Session session = openSession();
		boolean b = update(session, o);
		commitAndCloseSession(session);
		return b;
	}
	
	
	
	public static boolean update(Session openedSession,Object o) {
		Transaction tx = null;
		try {
			tx = openedSession.beginTransaction();
			openedSession.update(o);
			tx.commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			if (tx != null && tx.isActive())
				tx.rollback();
			return false;
		}
		return true;
	}
    

}