package org.infinite.db;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;



public class Manager {

	/*
	private static SessionFactory sessionFactory=null;

	static{
		Configuration config = new Configuration().configure("hibernate.cfg.xml");
		sessionFactory = config.buildSessionFactory();
	}*/
	
	public static Session openSession(){

		//Session session = sessionFactory.openSession();
		//session.beginTransaction();
		//return session;
		
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		return session;

	}
	
	public static void commitAndCloseSession(Session s){
		//s.getTransaction().commit();
		s.flush();
		//s.disconnect();
		//s.close();
		//sessionFactory.close();
        
	}
	
	@SuppressWarnings("unchecked")
	public static List listByQery(Session openedSession,String query){		
		return openedSession.createQuery(query).list();
	}
	
	@SuppressWarnings("unchecked")
	public static List listByQery(String query){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		List l = listByQery(session, query);
		session.getTransaction().commit();
		return l;
	}
       
	public static boolean delete(Object o){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();;
		session.beginTransaction();
		boolean b = delete(session, o);
		session.getTransaction().commit();
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
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();;
		session.beginTransaction();
		boolean b = create(session, o);
		session.getTransaction().commit();
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
		
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();;
		boolean b = update(session, o);
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