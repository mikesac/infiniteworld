package org.infinite.db.dao;

// Generated 19-feb-2009 22.03.23 by Hibernate Tools 3.2.2.GA

/**
 * SpellAffectPlayerId generated by hbm2java
 */
public class SpellAffectPlayerId implements java.io.Serializable {

	private int playerid;
	private int spellid;

	public SpellAffectPlayerId() {
	}

	public SpellAffectPlayerId(int playerid, int spellid) {
		this.playerid = playerid;
		this.spellid = spellid;
	}

	public int getPlayerid() {
		return this.playerid;
	}

	public void setPlayerid(int playerid) {
		this.playerid = playerid;
	}

	public int getSpellid() {
		return this.spellid;
	}

	public void setSpellid(int spellid) {
		this.spellid = spellid;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof SpellAffectPlayerId))
			return false;
		SpellAffectPlayerId castOther = (SpellAffectPlayerId) other;

		return (this.getPlayerid() == castOther.getPlayerid())
				&& (this.getSpellid() == castOther.getSpellid());
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result + this.getPlayerid();
		result = 37 * result + this.getSpellid();
		return result;
	}

}
