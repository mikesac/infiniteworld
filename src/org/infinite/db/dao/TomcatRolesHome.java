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
 * Home object for domain model class TomcatRoles.
 * @see org.infinite.db.dao.TomcatRoles
 * @author Hibernate Tools
 */
public class TomcatRolesHome {

	private static final Log log = LogFactory.getLog(TomcatRolesHome.class);

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

	public void persist(TomcatRoles transientInstance) {
		log.debug("persisting TomcatRoles instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(TomcatRoles instance) {
		log.debug("attaching dirty TomcatRoles instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(TomcatRoles instance) {
		log.debug("attaching clean TomcatRoles instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(TomcatRoles persistentInstance) {
		log.debug("deleting TomcatRoles instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public TomcatRoles merge(TomcatRoles detachedInstance) {
		log.debug("merging TomcatRoles instance");
		try {
			TomcatRoles result = (TomcatRoles) sessionFactory
					.getCurrentSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public TomcatRoles findById(java.lang.String id) {
		log.debug("getting TomcatRoles instance with id: " + id);
		try {
			TomcatRoles instance = (TomcatRoles) sessionFactory
					.getCurrentSession().get("org.infinite.db.dao.TomcatRoles",
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

	public List<TomcatRoles> findByExample(TomcatRoles instance) {
		log.debug("finding TomcatRoles instance by example");
		try {
			List<TomcatRoles> results = (List<TomcatRoles>) sessionFactory
					.getCurrentSession().createCriteria(
							"org.infinite.db.dao.TomcatRoles").add(
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
