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
 * Home object for domain model class PlayerKnowSpell.
 * @see org.infinite.db.dao.PlayerKnowSpell
 * @author Hibernate Tools
 */
public class PlayerKnowSpellHome {

	private static final Log log = LogFactory.getLog(PlayerKnowSpellHome.class);

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

	public void persist(PlayerKnowSpell transientInstance) {
		log.debug("persisting PlayerKnowSpell instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(PlayerKnowSpell instance) {
		log.debug("attaching dirty PlayerKnowSpell instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(PlayerKnowSpell instance) {
		log.debug("attaching clean PlayerKnowSpell instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(PlayerKnowSpell persistentInstance) {
		log.debug("deleting PlayerKnowSpell instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public PlayerKnowSpell merge(PlayerKnowSpell detachedInstance) {
		log.debug("merging PlayerKnowSpell instance");
		try {
			PlayerKnowSpell result = (PlayerKnowSpell) sessionFactory
					.getCurrentSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public PlayerKnowSpell findById(org.infinite.db.dao.PlayerKnowSpellId id) {
		log.debug("getting PlayerKnowSpell instance with id: " + id);
		try {
			PlayerKnowSpell instance = (PlayerKnowSpell) sessionFactory
					.getCurrentSession().get(
							"org.infinite.db.dao.PlayerKnowSpell", id);
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

	public List findByExample(PlayerKnowSpell instance) {
		log.debug("finding PlayerKnowSpell instance by example");
		try {
			List results = sessionFactory.getCurrentSession().createCriteria(
					"org.infinite.db.dao.PlayerKnowSpell").add(
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
