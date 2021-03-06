package org.infinite.engines.fight;

import java.util.ArrayList;

import org.infinite.db.dao.Item;
import org.infinite.db.dao.PlayerKnowSpell;
import org.infinite.db.dao.PlayerOwnItem;
import org.infinite.db.dao.Spell;
import org.infinite.db.dao.SpellAffectPlayer;

public interface PlayerInterface{

	// ----------------- Fight Interface -----------------
	public int getBaseCA();

	public int getTotalCA();

	public int getArmorCA();

	public int getShieldCA();

	public int getAttackType(PlayerInterface defender);

	public String[] getAttackName(int round);

	public int getInitiative(int round);

	public int getRollToAttack();

	public int inflictDamage(int dmg);

	public int healDamage(int heal);

	public int restRound(int i);

	public int getAttackDamage(int round);

	public boolean isAlive();

	public int getRewardPX();

	public float getRewardGold();

	public ArrayList<Item> getRewardItems();

	public void prepareForFight();
	
	public Object getCurrentAttack(int round);
	
	public float addGold(float rewardGold);

	public int addExperience(int rewardPX);

	public void lootItems(ArrayList<Item> rewardItems);
	
	public ArrayList<SpellAffectPlayer> getSpellsAffecting();
	
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
	
	public void addToAffectingSpells(Spell s);
	
	public void addToAffectingSpells(SpellAffectPlayer sap);
	
	public void removeSpellsAffecting( int sapId );
	
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

	
	////////////////////////////
	
	public void equipItem(PlayerOwnItem poi);
	
	public void addToInventory(PlayerOwnItem poi);

	public PlayerOwnItem getBodyPoi();

	public void setBody(PlayerOwnItem poi);

	public ArrayList<PlayerOwnItem> getInventory();

	public PlayerOwnItem getHandLeftPoi();

	public void setHandLeft(PlayerOwnItem poi);

	public PlayerOwnItem getHandRightPoi();

	public void setHandRight(PlayerOwnItem poi);

	public String[] getMeleeAttacks(int round);
	

}
