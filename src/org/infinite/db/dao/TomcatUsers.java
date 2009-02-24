package org.infinite.db.dao;

// Generated 23-feb-2009 21.37.11 by Hibernate Tools 3.2.2.GA

import java.util.HashSet;
import java.util.Set;

/**
 * TomcatUsers generated by hbm2java
 */
public class TomcatUsers implements java.io.Serializable {

	private String user;
	private String password;
	private String email;
	private Set tomcatRoleses = new HashSet(0);
	private Set players = new HashSet(0);

	public TomcatUsers() {
	}

	public TomcatUsers(String user, String password, String email) {
		this.user = user;
		this.password = password;
		this.email = email;
	}

	public TomcatUsers(String user, String password, String email,
			Set tomcatRoleses, Set players) {
		this.user = user;
		this.password = password;
		this.email = email;
		this.tomcatRoleses = tomcatRoleses;
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

	public Set getTomcatRoleses() {
		return this.tomcatRoleses;
	}

	public void setTomcatRoleses(Set tomcatRoleses) {
		this.tomcatRoleses = tomcatRoleses;
	}

	public Set getPlayers() {
		return this.players;
	}

	public void setPlayers(Set players) {
		this.players = players;
	}

}
