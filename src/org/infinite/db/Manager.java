package org.infinite.db;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;



public class Manager {

	
	public static Session getSession(){		
		Session session = null;
		try {
			session = HibernateUtil.getSessionFactory().getCurrentSession();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		
		if(session==null || !session.isOpen() )
			session = HibernateUtil.getSessionFactory().openSession();
		
		return session;
	}
		
	
	@SuppressWarnings("unchecked")
	public static List listByQery(Session openedSession,String query){		
		return openedSession.createQuery(query).list();
	}
	
	@SuppressWarnings("unchecked")
	public static List listByQery(String query){
		Session session = getSession();
		session.beginTransaction();
		List l = listByQery(session, query);
		session.getTransaction().commit();
		return l;
	}
       
	public static boolean delete(Object o){
		Session session = getSession();
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
		Session session = getSession();;
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
		
		Session session = getSession();
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
		
			Session s = getSession();
			s.beginTransaction();
			Object o = s.get(className, id);
			s.getTransaction().commit();
			return o;
	}
    

}