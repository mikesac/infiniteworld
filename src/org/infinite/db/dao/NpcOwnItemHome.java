package org.infinite.db.dao;

// Generated 19-feb-2009 22.03.23 by Hibernate Tools 3.2.2.GA

import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Example;

/**
 * Home object for domain model class NpcOwnItem.
 * @see org.infinite.db.dao.NpcOwnItem
 * @author Hibernate Tools
 */
public class NpcOwnItemHome {

	private static final Log log = LogFactory.getLog(NpcOwnItemHome.class);

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

	public void persist(NpcOwnItem transientInstance) {
		log.debug("persisting NpcOwnItem instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(NpcOwnItem instance) {
		log.debug("attaching dirty NpcOwnItem instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(NpcOwnItem instance) {
		log.debug("attaching clean NpcOwnItem instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(NpcOwnItem persistentInstance) {
		log.debug("deleting NpcOwnItem instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public NpcOwnItem merge(NpcOwnItem detachedInstance) {
		log.debug("merging NpcOwnItem instance");
		try {
			NpcOwnItem result = (NpcOwnItem) sessionFactory.getCurrentSession()
					.merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public NpcOwnItem findById(org.infinite.db.dao.NpcOwnItemId id) {
		log.debug("getting NpcOwnItem instance with id: " + id);
		try {
			NpcOwnItem instance = (NpcOwnItem) sessionFactory
					.getCurrentSession().get("org.infinite.db.dao.NpcOwnItem",
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

	public List findByExample(NpcOwnItem instance) {
		log.debug("finding NpcOwnItem instance by example");
		try {
			List results = sessionFactory.getCurrentSession().createCriteria(
					"org.infinite.db.dao.NpcOwnItem").add(
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
