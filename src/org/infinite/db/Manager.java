package org.infinite.db;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;



public class Manager {

	
	public static Session openSession(){		
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		return session;
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
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		boolean b = delete(session, o);
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
		boolean b = create(session, o);
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
		
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
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
	
	
	public static Object findById(String className, int id) {	
		
			Session s = HibernateUtil.getSessionFactory().getCurrentSession();
			s.beginTransaction();
			Object o = s.get(className, id);
			s.getTransaction().commit();
			return o;
	}
    

}