package org.infinite.db.dao;

// Generated 23-feb-2009 21.37.11 by Hibernate Tools 3.2.2.GA

import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Example;

/**
 * Home object for domain model class PlayerOwnItem.
 * @see org.infinite.db.dao.PlayerOwnItem
 * @author Hibernate Tools
 */
public class PlayerOwnItemHome {

	private static final Log log = LogFactory.getLog(PlayerOwnItemHome.class);

	private final SessionFactory sessionFactory = getSessionFactory();

	protected SessionFactory getSessionFactory() {
		try {
			return (SessionFactory) new InitialContext()
					.lookup("SessionFactory");
		} catch (Exception e) {
			log.error("Could not locate SessionFactory in JNDI", e);
			throw new IllegalStateException(
					"Could not locate SessionFactory in JNDI");
		}
	}

	public void persist(PlayerOwnItem transientInstance) {
		log.debug("persisting PlayerOwnItem instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(PlayerOwnItem instance) {
		log.debug("attaching dirty PlayerOwnItem instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(PlayerOwnItem instance) {
		log.debug("attaching clean PlayerOwnItem instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(PlayerOwnItem persistentInstance) {
		log.debug("deleting PlayerOwnItem instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public PlayerOwnItem merge(PlayerOwnItem detachedInstance) {
		log.debug("merging PlayerOwnItem instance");
		try {
			PlayerOwnItem result = (PlayerOwnItem) sessionFactory
					.getCurrentSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public PlayerOwnItem findById(org.infinite.db.dao.PlayerOwnItemId id) {
		log.debug("getting PlayerOwnItem instance with id: " + id);
		try {
			PlayerOwnItem instance = (PlayerOwnItem) sessionFactory
					.getCurrentSession().get(
							"org.infinite.db.dao.PlayerOwnItem", id);
			if (instance == null) {
				log.debug("get successful, no instance found");
			} else {
				log.debug("get successful, instance found");
			}
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(PlayerOwnItem instance) {
		log.debug("finding PlayerOwnItem instance by example");
		try {
			List results = sessionFactory.getCurrentSession().createCriteria(
					"org.infinite.db.dao.PlayerOwnItem").add(
					Example.create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
}
