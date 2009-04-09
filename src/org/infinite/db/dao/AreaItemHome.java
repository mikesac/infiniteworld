package org.infinite.db.dao;

// Generated 6-apr-2009 8.44.53 by Hibernate Tools 3.2.4.CR1

import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.SessionFactory;
import static org.hibernate.criterion.Example.create;

/**
 * Home object for domain model class AreaItem.
 * @see org.infinite.db.dao.AreaItem
 * @author Hibernate Tools
 */
public class AreaItemHome {

	private static final Log log = LogFactory.getLog(AreaItemHome.class);

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

	public void persist(AreaItem transientInstance) {
		log.debug("persisting AreaItem instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(AreaItem instance) {
		log.debug("attaching dirty AreaItem instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(AreaItem instance) {
		log.debug("attaching clean AreaItem instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(AreaItem persistentInstance) {
		log.debug("deleting AreaItem instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public AreaItem merge(AreaItem detachedInstance) {
		log.debug("merging AreaItem instance");
		try {
			AreaItem result = (AreaItem) sessionFactory.getCurrentSession()
					.merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public AreaItem findById(java.lang.Integer id) {
		log.debug("getting AreaItem instance with id: " + id);
		try {
			AreaItem instance = (AreaItem) sessionFactory.getCurrentSession()
					.get("org.infinite.db.dao.AreaItem", id);
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

	public List<AreaItem> findByExample(AreaItem instance) {
		log.debug("finding AreaItem instance by example");
		try {
			List<AreaItem> results = (List<AreaItem>) sessionFactory
					.getCurrentSession().createCriteria(
							"org.infinite.db.dao.AreaItem").add(
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
