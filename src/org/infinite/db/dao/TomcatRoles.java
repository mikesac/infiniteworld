package org.infinite.db.dao;

// Generated 27-feb-2009 22.51.40 by Hibernate Tools 3.2.2.GA

/**
 * TomcatRoles generated by hbm2java
 */
public class TomcatRoles implements java.io.Serializable {

	private String user;
	private TomcatUsers tomcatUsers;
	private String role;

	public TomcatRoles() {
	}

	public TomcatRoles(String user, TomcatUsers tomcatUsers, String role) {
		this.user = user;
		this.tomcatUsers = tomcatUsers;
		this.role = role;
	}

	public String getUser() {
		return this.user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public TomcatUsers getTomcatUsers() {
		return this.tomcatUsers;
	}

	public void setTomcatUsers(TomcatUsers tomcatUsers) {
		this.tomcatUsers = tomcatUsers;
	}

	public String getRole() {
		return this.role;
	}

	public void setRole(String role) {
		this.role = role;
	}

}
