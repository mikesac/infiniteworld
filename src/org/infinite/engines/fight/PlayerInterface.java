package org.infinite.engines.fight;

import java.util.ArrayList;

import org.infinite.db.dao.Item;
import org.infinite.db.dao.PlayerKnowSpell;
import org.infinite.db.dao.Spell;

public interface PlayerInterface{

	// ----------------- Fight Interface -----------------
	public int getBaseCA();

	public int getTotalCA();

	public int getArmorCA();

	public int getShieldCA();

	public int getAttackType(PlayerInterface defender);

	public String[] getAttackName();

	public int getInitiative();

	public int getRollToAttack();

	public int inflictDamage(int dmg);

	public int healDamage(int heal);

	public void restRound(int i);

	public int getAttackDamage();

	public boolean isAlive();

	public int getRewardPX();

	public float getRewardGold();

	public Item[] getRewardItems();

	
	// ----------------- Spell Interface -----------------
	
	public int getSpellDuration();
	
	public boolean rollSavingThrow(Spell s, PlayerInterface caster);	

	public ArrayList<PlayerKnowSpell> getSpellBookFight();

	public ArrayList<PlayerKnowSpell> getSpellBookHeal();

	public ArrayList<PlayerKnowSpell> getSpellBookProtect();

	public void learnSpell(Spell spell);
	
	public void prepareSpell(PlayerKnowSpell pks);
	
	public void unprepareSpell(int pksId);
	
	public Spell castSpell( Spell s);

	public ArrayList<PlayerKnowSpell> getPreparedSpells();

	public void addToPreparedSpells(PlayerKnowSpell pks);
	
	// ----------------- Character Interface -----------------
	
	public Object getDao();

	public int getLevel();
	
	public String getName();	

	public Item getHandRight();

	public Item getHandLeft();

	public Item getBody();

	public String getPic();

	public int getStrenght();
	
	public int getIntelligence();
	
	public int getDexterity();

	public int getCharisma();	
	
	public int getPointsLife();
	
	public int getPointsMagic();
	
	public int getPointsAction();
	
	public int getPointsCharm();
	
	public int getPointsLifeMax();

	public int getPointsMagicMax();
	
	public int getPointsActionMax();

	public int getPointsCharmMax();
	
	public int addLifePoints(int points) throws Exception;

	public int addMagicPoints(int points) throws Exception;

	public int addActionPoints(int points) throws Exception;

	public int addCharmPoints(int points) throws Exception;

}
