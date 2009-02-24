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
 * Home object for domain model class SpellAffectPlayer.
 * @see org.infinite.db.dao.SpellAffectPlayer
 * @author Hibernate Tools
 */
public class SpellAffectPlayerHome {

	private static final Log log = LogFactory
			.getLog(SpellAffectPlayerHome.class);

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

	public void persist(SpellAffectPlayer transientInstance) {
		log.debug("persisting SpellAffectPlayer instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(SpellAffectPlayer instance) {
		log.debug("attaching dirty SpellAffectPlayer instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(SpellAffectPlayer instance) {
		log.debug("attaching clean SpellAffectPlayer instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(SpellAffectPlayer persistentInstance) {
		log.debug("deleting SpellAffectPlayer instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public SpellAffectPlayer merge(SpellAffectPlayer detachedInstance) {
		log.debug("merging SpellAffectPlayer instance");
		try {
			SpellAffectPlayer result = (SpellAffectPlayer) sessionFactory
					.getCurrentSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public SpellAffectPlayer findById(org.infinite.db.dao.SpellAffectPlayerId id) {
		log.debug("getting SpellAffectPlayer instance with id: " + id);
		try {
			SpellAffectPlayer instance = (SpellAffectPlayer) sessionFactory
					.getCurrentSession().get(
							"org.infinite.db.dao.SpellAffectPlayer", id);
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

	public List findByExample(SpellAffectPlayer instance) {
		log.debug("finding SpellAffectPlayer instance by example");
		try {
			List results = sessionFactory.getCurrentSession().createCriteria(
					"org.infinite.db.dao.SpellAffectPlayer").add(
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
