package org.infinite.db.dao;

// Generated 6-apr-2009 8.44.52 by Hibernate Tools 3.2.4.CR1

import java.util.HashSet;
import java.util.Set;

/**
 * Item generated by hbm2java
 */
public class Item implements java.io.Serializable {

	private Integer id;
	private String name;
	private String descr;
	private String image;
	private Integer costAp;
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
	private Integer spell;
	private String damage;
	private Integer initiative;
	private Integer durability;
	private Integer type;
	private Set<PlayerOwnItem> playerOwnItems = new HashSet<PlayerOwnItem>(0);

	public Item() {
	}

	public Item(String name, String descr, String image, Integer costAp,
			Integer reqStr, Integer reqInt, Integer reqDex, Integer reqCha,
			Integer reqLev, Integer modStr, Integer modInt, Integer modDex,
			Integer modCha, float price, Integer lev, Integer spell,
			String damage, Integer initiative, Integer durability, Integer type) {
		this.name = name;
		this.descr = descr;
		this.image = image;
		this.costAp = costAp;
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
		this.spell = spell;
		this.damage = damage;
		this.initiative = initiative;
		this.durability = durability;
		this.type = type;
	}

	public Item(String name, String descr, String image, Integer costAp,
			Integer reqStr, Integer reqInt, Integer reqDex, Integer reqCha,
			Integer reqLev, Integer modStr, Integer modInt, Integer modDex,
			Integer modCha, float price, Integer lev, Integer spell,
			String damage, Integer initiative, Integer durability,
			Integer type, Set<PlayerOwnItem> playerOwnItems) {
		this.name = name;
		this.descr = descr;
		this.image = image;
		this.costAp = costAp;
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
		this.spell = spell;
		this.damage = damage;
		this.initiative = initiative;
		this.durability = durability;
		this.type = type;
		this.playerOwnItems = playerOwnItems;
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

	public String getDescr() {
		return this.descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	public String getImage() {
		return this.image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Integer getCostAp() {
		return this.costAp;
	}

	public void setCostAp(Integer costAp) {
		this.costAp = costAp;
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

	public Integer getSpell() {
		return this.spell;
	}

	public void setSpell(Integer spell) {
		this.spell = spell;
	}

	public String getDamage() {
		return this.damage;
	}

	public void setDamage(String damage) {
		this.damage = damage;
	}

	public Integer getInitiative() {
		return this.initiative;
	}

	public void setInitiative(Integer initiative) {
		this.initiative = initiative;
	}

	public Integer getDurability() {
		return this.durability;
	}

	public void setDurability(Integer durability) {
		this.durability = durability;
	}

	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Set<PlayerOwnItem> getPlayerOwnItems() {
		return this.playerOwnItems;
	}

	public void setPlayerOwnItems(Set<PlayerOwnItem> playerOwnItems) {
		this.playerOwnItems = playerOwnItems;
	}

}
