package org.infinite.db.dao;

// Generated 31-mar-2009 22.04.43 by Hibernate Tools 3.2.4.CR1

import java.util.HashSet;
import java.util.Set;

/**
 * TomcatUsers generated by hbm2java
 */
public class TomcatUsers implements java.io.Serializable {

	private String user;
	private String password;
	private String email;
	private TomcatRoles tomcatRoles;
	private Set<Player> players = new HashSet<Player>(0);

	public TomcatUsers() {
	}

	public TomcatUsers(String user, String password, String email) {
		this.user = user;
		this.password = password;
		this.email = email;
	}

	public TomcatUsers(String user, String password, String email,
			TomcatRoles tomcatRoles, Set<Player> players) {
		this.user = user;
		this.password = password;
		this.email = email;
		this.tomcatRoles = tomcatRoles;
		this.players = players;
	}

	public String getUser() {
		return this.user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public TomcatRoles getTomcatRoles() {
		return this.tomcatRoles;
	}

	public void setTomcatRoles(TomcatRoles tomcatRoles) {
		this.tomcatRoles = tomcatRoles;
	}

	public Set<Player> getPlayers() {
		return this.players;
	}

	public void setPlayers(Set<Player> players) {
		this.players = players;
	}

}
