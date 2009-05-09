package org.infinite.db.dao;

// Generated 5-mag-2009 22.23.06 by Hibernate Tools 3.2.4.CR1

import java.util.HashSet;
import java.util.Set;

/**
 * Player generated by hbm2java
 */
public class Player implements java.io.Serializable {

	private int id;
	private TomcatUsers tomcatUsers;
	private AreaItem areaItem;
	private String name;
	private String image;
	private Integer baseStr;
	private Integer baseInt;
	private Integer baseDex;
	private Integer baseCha;
	private Integer basePl;
	private Integer basePm;
	private Integer basePa;
	private Integer basePc;
	private Integer pl;
	private Integer pm;
	private Integer pa;
	private Integer pc;
	private long statsMod;
	private Integer level;
	private Integer px;
	private short assign;
	private Integer status;
	private float gold;
	private Integer nattack;
	private String attack;
	private String battle;
	private Set<PlayerOwnItem> playerOwnItems = new HashSet<PlayerOwnItem>(0);
	private Set<SpellAffectPlayer> spellAffectPlayers = new HashSet<SpellAffectPlayer>(
			0);
	private Set<PlayerKnowSpell> playerKnowSpells = new HashSet<PlayerKnowSpell>(
			0);

	public Player() {
	}

	public Player(TomcatUsers tomcatUsers, AreaItem areaItem, String name,
			String image, Integer baseStr, Integer baseInt, Integer baseDex,
			Integer baseCha, Integer basePl, Integer basePm, Integer basePa,
			Integer basePc, Integer pl, Integer pm, Integer pa, Integer pc,
			long statsMod, Integer level, Integer px, short assign,
			Integer status, float gold, Integer nattack, String attack,
			String battle) {
		this.tomcatUsers = tomcatUsers;
		this.areaItem = areaItem;
		this.name = name;
		this.image = image;
		this.baseStr = baseStr;
		this.baseInt = baseInt;
		this.baseDex = baseDex;
		this.baseCha = baseCha;
		this.basePl = basePl;
		this.basePm = basePm;
		this.basePa = basePa;
		this.basePc = basePc;
		this.pl = pl;
		this.pm = pm;
		this.pa = pa;
		this.pc = pc;
		this.statsMod = statsMod;
		this.level = level;
		this.px = px;
		this.assign = assign;
		this.status = status;
		this.gold = gold;
		this.nattack = nattack;
		this.attack = attack;
		this.battle = battle;
	}

	public Player(TomcatUsers tomcatUsers, AreaItem areaItem, String name,
			String image, Integer baseStr, Integer baseInt, Integer baseDex,
			Integer baseCha, Integer basePl, Integer basePm, Integer basePa,
			Integer basePc, Integer pl, Integer pm, Integer pa, Integer pc,
			long statsMod, Integer level, Integer px, short assign,
			Integer status, float gold, Integer nattack, String attack,
			String battle, Set<PlayerOwnItem> playerOwnItems,
			Set<SpellAffectPlayer> spellAffectPlayers,
			Set<PlayerKnowSpell> playerKnowSpells) {
		this.tomcatUsers = tomcatUsers;
		this.areaItem = areaItem;
		this.name = name;
		this.image = image;
		this.baseStr = baseStr;
		this.baseInt = baseInt;
		this.baseDex = baseDex;
		this.baseCha = baseCha;
		this.basePl = basePl;
		this.basePm = basePm;
		this.basePa = basePa;
		this.basePc = basePc;
		this.pl = pl;
		this.pm = pm;
		this.pa = pa;
		this.pc = pc;
		this.statsMod = statsMod;
		this.level = level;
		this.px = px;
		this.assign = assign;
		this.status = status;
		this.gold = gold;
		this.nattack = nattack;
		this.attack = attack;
		this.battle = battle;
		this.playerOwnItems = playerOwnItems;
		this.spellAffectPlayers = spellAffectPlayers;
		this.playerKnowSpells = playerKnowSpells;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public TomcatUsers getTomcatUsers() {
		return this.tomcatUsers;
	}

	public void setTomcatUsers(TomcatUsers tomcatUsers) {
		this.tomcatUsers = tomcatUsers;
	}

	public AreaItem getAreaItem() {
		return this.areaItem;
	}

	public void setAreaItem(AreaItem areaItem) {
		this.areaItem = areaItem;
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

	public Integer getPl() {
		return this.pl;
	}

	public void setPl(Integer pl) {
		this.pl = pl;
	}

	public Integer getPm() {
		return this.pm;
	}

	public void setPm(Integer pm) {
		this.pm = pm;
	}

	public Integer getPa() {
		return this.pa;
	}

	public void setPa(Integer pa) {
		this.pa = pa;
	}

	public Integer getPc() {
		return this.pc;
	}

	public void setPc(Integer pc) {
		this.pc = pc;
	}

	public long getStatsMod() {
		return this.statsMod;
	}

	public void setStatsMod(long statsMod) {
		this.statsMod = statsMod;
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

	public short getAssign() {
		return this.assign;
	}

	public void setAssign(short assign) {
		this.assign = assign;
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

	public String getBattle() {
		return this.battle;
	}

	public void setBattle(String battle) {
		this.battle = battle;
	}

	public Set<PlayerOwnItem> getPlayerOwnItems() {
		return this.playerOwnItems;
	}

	public void setPlayerOwnItems(Set<PlayerOwnItem> playerOwnItems) {
		this.playerOwnItems = playerOwnItems;
	}

	public Set<SpellAffectPlayer> getSpellAffectPlayers() {
		return this.spellAffectPlayers;
	}

	public void setSpellAffectPlayers(Set<SpellAffectPlayer> spellAffectPlayers) {
		this.spellAffectPlayers = spellAffectPlayers;
	}

	public Set<PlayerKnowSpell> getPlayerKnowSpells() {
		return this.playerKnowSpells;
	}

	public void setPlayerKnowSpells(Set<PlayerKnowSpell> playerKnowSpells) {
		this.playerKnowSpells = playerKnowSpells;
	}

}
