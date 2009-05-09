package org.infinite.db.dao;

// Generated 5-mag-2009 22.23.06 by Hibernate Tools 3.2.4.CR1

/**
 * Npc generated by hbm2java
 */
public class Npc implements java.io.Serializable {

	private Integer id;
	private String name;
	private String image;
	private String description;
	private Integer baseStr;
	private Integer baseInt;
	private Integer baseDex;
	private Integer baseCha;
	private Integer basePl;
	private Integer basePm;
	private Integer basePa;
	private Integer basePc;
	private Integer level;
	private Integer px;
	private Integer status;
	private float gold;
	private String dialog;
	private String items;
	private String behave;
	private boolean ismonster;
	private Integer nattack;
	private String attack;

	public Npc() {
	}

	public Npc(Integer id, String name, String image, String description,
			Integer baseStr, Integer baseInt, Integer baseDex, Integer baseCha,
			Integer basePl, Integer basePm, Integer basePa, Integer basePc,
			Integer level, Integer px, Integer status, float gold,
			String dialog, String items, String behave, boolean ismonster,
			Integer nattack, String attack) {
		this.id = id;
		this.name = name;
		this.image = image;
		this.description = description;
		this.baseStr = baseStr;
		this.baseInt = baseInt;
		this.baseDex = baseDex;
		this.baseCha = baseCha;
		this.basePl = basePl;
		this.basePm = basePm;
		this.basePa = basePa;
		this.basePc = basePc;
		this.level = level;
		this.px = px;
		this.status = status;
		this.gold = gold;
		this.dialog = dialog;
		this.items = items;
		this.behave = behave;
		this.ismonster = ismonster;
		this.nattack = nattack;
		this.attack = attack;
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

	public String getImage() {
		return this.image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getBaseStr() {
		return this.baseStr;
	}

	public void setBaseStr(Integer baseStr) {
		this.baseStr = baseStr;
	}

	public Integer getBaseInt() {
		return this.baseInt;
	}

	public void setBaseInt(Integer baseInt) {
		this.baseInt = baseInt;
	}

	public Integer getBaseDex() {
		return this.baseDex;
	}

	public void setBaseDex(Integer baseDex) {
		this.baseDex = baseDex;
	}

	public Integer getBaseCha() {
		return this.baseCha;
	}

	public void setBaseCha(Integer baseCha) {
		this.baseCha = baseCha;
	}

	public Integer getBasePl() {
		return this.basePl;
	}

	public void setBasePl(Integer basePl) {
		this.basePl = basePl;
	}

	public Integer getBasePm() {
		return this.basePm;
	}

	public void setBasePm(Integer basePm) {
		this.basePm = basePm;
	}

	public Integer getBasePa() {
		return this.basePa;
	}

	public void setBasePa(Integer basePa) {
		this.basePa = basePa;
	}

	public Integer getBasePc() {
		return this.basePc;
	}

	public void setBasePc(Integer basePc) {
		this.basePc = basePc;
	}

	public Integer getLevel() {
		return this.level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public Integer getPx() {
		return this.px;
	}

	public void setPx(Integer px) {
		this.px = px;
	}

	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public float getGold() {
		return this.gold;
	}

	public void setGold(float gold) {
		this.gold = gold;
	}

	public String getDialog() {
		return this.dialog;
	}

	public void setDialog(String dialog) {
		this.dialog = dialog;
	}

	public String getItems() {
		return this.items;
	}

	public void setItems(String items) {
		this.items = items;
	}

	public String getBehave() {
		return this.behave;
	}

	public void setBehave(String behave) {
		this.behave = behave;
	}

	public boolean isIsmonster() {
		return this.ismonster;
	}

	public void setIsmonster(boolean ismonster) {
		this.ismonster = ismonster;
	}

	public Integer getNattack() {
		return this.nattack;
	}

	public void setNattack(Integer nattack) {
		this.nattack = nattack;
	}

	public String getAttack() {
		return this.attack;
	}

	public void setAttack(String attack) {
		this.attack = attack;
	}

}
