package org.infinite.db.dao;

// Generated 31-mar-2009 22.04.44 by Hibernate Tools 3.2.4.CR1

import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.SessionFactory;
import static org.hibernate.criterion.Example.create;

/**
 * Home object for domain model class Spell.
 * @see org.infinite.db.dao.Spell
 * @author Hibernate Tools
 */
public class SpellHome {

	private static final Log log = LogFactory.getLog(SpellHome.class);

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

	public void persist(Spell transientInstance) {
		log.debug("persisting Spell instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(Spell instance) {
		log.debug("attaching dirty Spell instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Spell instance) {
		log.debug("attaching clean Spell instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(Spell persistentInstance) {
		log.debug("deleting Spell instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Spell merge(Spell detachedInstance) {
		log.debug("merging Spell instance");
		try {
			Spell result = (Spell) sessionFactory.getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public Spell findById(java.lang.Integer id) {
		log.debug("getting Spell instance with id: " + id);
		try {
			Spell instance = (Spell) sessionFactory.getCurrentSession().get(
					"org.infinite.db.dao.Spell", id);
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

	public List<Spell> findByExample(Spell instance) {
		log.debug("finding Spell instance by example");
		try {
			List<Spell> results = (List<Spell>) sessionFactory
					.getCurrentSession().createCriteria(
							"org.infinite.db.dao.Spell").add(create(instance))
					.list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
}
