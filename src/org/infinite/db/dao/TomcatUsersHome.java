package org.infinite.db.dao;

// Generated 10-mar-2009 9.53.28 by Hibernate Tools 3.2.4.CR1

import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.SessionFactory;
import static org.hibernate.criterion.Example.create;

/**
 * Home object for domain model class TomcatUsers.
 * @see org.infinite.db.dao.TomcatUsers
 * @author Hibernate Tools
 */
public class TomcatUsersHome {

	private static final Log log = LogFactory.getLog(TomcatUsersHome.class);

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

	public void persist(TomcatUsers transientInstance) {
		log.debug("persisting TomcatUsers instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(TomcatUsers instance) {
		log.debug("attaching dirty TomcatUsers instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(TomcatUsers instance) {
		log.debug("attaching clean TomcatUsers instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(TomcatUsers persistentInstance) {
		log.debug("deleting TomcatUsers instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public TomcatUsers merge(TomcatUsers detachedInstance) {
		log.debug("merging TomcatUsers instance");
		try {
			TomcatUsers result = (TomcatUsers) sessionFactory
					.getCurrentSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public TomcatUsers findById(java.lang.String id) {
		log.debug("getting TomcatUsers instance with id: " + id);
		try {
			TomcatUsers instance = (TomcatUsers) sessionFactory
					.getCurrentSession().get("org.infinite.db.dao.TomcatUsers",
							id);
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

	public List<TomcatUsers> findByExample(TomcatUsers instance) {
		log.debug("finding TomcatUsers instance by example");
		try {
			List<TomcatUsers> results = (List<TomcatUsers>) sessionFactory
					.getCurrentSession().createCriteria(
							"org.infinite.db.dao.TomcatUsers").add(
							create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
}
