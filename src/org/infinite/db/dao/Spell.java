package org.infinite.db.dao;

// Generated 6-apr-2009 8.44.52 by Hibernate Tools 3.2.4.CR1

import java.util.HashSet;
import java.util.Set;

/**
 * Spell generated by hbm2java
 */
public class Spell implements java.io.Serializable {

	private Integer id;
	private String name;
	private String desc;
	private String image;
	private Integer costMp;
	private Integer reqStr;
	private Integer reqInt;
	private Integer reqDex;
	private Integer reqCha;
	private Integer reqLev;
	private Integer modStr;
	private Integer modInt;
	private Integer modDex;
	private Integer modCha;
	private float price;
	private Integer lev;
	private Integer duration;
	private Integer spelltype;
	private String damage;
	private Integer savingthrow;
	private Integer initiative;
	private Set<PlayerKnowSpell> playerKnowSpells = new HashSet<PlayerKnowSpell>(
			0);
	private Set<Player> players = new HashSet<Player>(0);

	public Spell() {
	}

	public Spell(String name, String desc, String image, Integer costMp,
			Integer reqStr, Integer reqInt, Integer reqDex, Integer reqCha,
			Integer reqLev, Integer modStr, Integer modInt, Integer modDex,
			Integer modCha, float price, Integer lev, Integer duration,
			Integer spelltype, String damage, Integer savingthrow,
			Integer initiative) {
		this.name = name;
		this.desc = desc;
		this.image = image;
		this.costMp = costMp;
		this.reqStr = reqStr;
		this.reqInt = reqInt;
		this.reqDex = reqDex;
		this.reqCha = reqCha;
		this.reqLev = reqLev;
		this.modStr = modStr;
		this.modInt = modInt;
		this.modDex = modDex;
		this.modCha = modCha;
		this.price = price;
		this.lev = lev;
		this.duration = duration;
		this.spelltype = spelltype;
		this.damage = damage;
		this.savingthrow = savingthrow;
		this.initiative = initiative;
	}

	public Spell(String name, String desc, String image, Integer costMp,
			Integer reqStr, Integer reqInt, Integer reqDex, Integer reqCha,
			Integer reqLev, Integer modStr, Integer modInt, Integer modDex,
			Integer modCha, float price, Integer lev, Integer duration,
			Integer spelltype, String damage, Integer savingthrow,
			Integer initiative, Set<PlayerKnowSpell> playerKnowSpells,
			Set<Player> players) {
		this.name = name;
		this.desc = desc;
		this.image = image;
		this.costMp = costMp;
		this.reqStr = reqStr;
		this.reqInt = reqInt;
		this.reqDex = reqDex;
		this.reqCha = reqCha;
		this.reqLev = reqLev;
		this.modStr = modStr;
		this.modInt = modInt;
		this.modDex = modDex;
		this.modCha = modCha;
		this.price = price;
		this.lev = lev;
		this.duration = duration;
		this.spelltype = spelltype;
		this.damage = damage;
		this.savingthrow = savingthrow;
		this.initiative = initiative;
		this.playerKnowSpells = playerKnowSpells;
		this.players = players;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDesc() {
		return this.desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getImage() {
		return this.image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Integer getCostMp() {
		return this.costMp;
	}

	public void setCostMp(Integer costMp) {
		this.costMp = costMp;
	}

	public Integer getReqStr() {
		return this.reqStr;
	}

	public void setReqStr(Integer reqStr) {
		this.reqStr = reqStr;
	}

	public Integer getReqInt() {
		return this.reqInt;
	}

	public void setReqInt(Integer reqInt) {
		this.reqInt = reqInt;
	}

	public Integer getReqDex() {
		return this.reqDex;
	}

	public void setReqDex(Integer reqDex) {
		this.reqDex = reqDex;
	}

	public Integer getReqCha() {
		return this.reqCha;
	}

	public void setReqCha(Integer reqCha) {
		this.reqCha = reqCha;
	}

	public Integer getReqLev() {
		return this.reqLev;
	}

	public void setReqLev(Integer reqLev) {
		this.reqLev = reqLev;
	}

	public Integer getModStr() {
		return this.modStr;
	}

	public void setModStr(Integer modStr) {
		this.modStr = modStr;
	}

	public Integer getModInt() {
		return this.modInt;
	}

	public void setModInt(Integer modInt) {
		this.modInt = modInt;
	}

	public Integer getModDex() {
		return this.modDex;
	}

	public void setModDex(Integer modDex) {
		this.modDex = modDex;
	}

	public Integer getModCha() {
		return this.modCha;
	}

	public void setModCha(Integer modCha) {
		this.modCha = modCha;
	}

	public float getPrice() {
		return this.price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public Integer getLev() {
		return this.lev;
	}

	public void setLev(Integer lev) {
		this.lev = lev;
	}

	public Integer getDuration() {
		return this.duration;
	}

	public void setDuration(Integer duration) {
		this.duration = duration;
	}

	public Integer getSpelltype() {
		return this.spelltype;
	}

	public void setSpelltype(Integer spelltype) {
		this.spelltype = spelltype;
	}

	public String getDamage() {
		return this.damage;
	}

	public void setDamage(String damage) {
		this.damage = damage;
	}

	public Integer getSavingthrow() {
		return this.savingthrow;
	}

	public void setSavingthrow(Integer savingthrow) {
		this.savingthrow = savingthrow;
	}

	public Integer getInitiative() {
		return this.initiative;
	}

	public void setInitiative(Integer initiative) {
		this.initiative = initiative;
	}

	public Set<PlayerKnowSpell> getPlayerKnowSpells() {
		return this.playerKnowSpells;
	}

	public void setPlayerKnowSpells(Set<PlayerKnowSpell> playerKnowSpells) {
		this.playerKnowSpells = playerKnowSpells;
	}

	public Set<Player> getPlayers() {
		return this.players;
	}

	public void setPlayers(Set<Player> players) {
		this.players = players;
	}

}
