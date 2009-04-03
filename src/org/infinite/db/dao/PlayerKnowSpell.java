package org.infinite.db.dao;

// Generated 31-mar-2009 22.04.43 by Hibernate Tools 3.2.4.CR1

/**
 * PlayerKnowSpell generated by hbm2java
 */
public class PlayerKnowSpell implements java.io.Serializable {

	private Integer id;
	private Player player;
	private Spell spell;
	private Integer status;

	public PlayerKnowSpell() {
	}

	public PlayerKnowSpell(Player player, Spell spell, Integer status) {
		this.player = player;
		this.spell = spell;
		this.status = status;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Player getPlayer() {
		return this.player;
	}

	public void setPlayer(Player player) {
		this.player = player;
	}

	public Spell getSpell() {
		return this.spell;
	}

	public void setSpell(Spell spell) {
		this.spell = spell;
	}

	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

}
