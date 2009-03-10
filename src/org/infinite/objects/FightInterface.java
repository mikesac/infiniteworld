package org.infinite.objects;

import org.infinite.db.dao.Item;
import org.infinite.db.dao.Spell;

public interface FightInterface{

	public int getBaseCA();

	public int getTotalCA();

	public int getArmorCA();

	public int getShieldCA();

	public int getAttackType(FightInterface defender);

	public String[] getAttackName();


	public int getInitiative();

	public int getRollToAttack();

	public int inflictDamage(int dmg);

	public int healDamage(int heal);

	public void restRound(int i);

	public int getSpellDuration();

	public int getAttackDamage();

	public boolean isAlive();

	public int getRewardPX();

	public float getRewardGold();

	public Item[] getRewardItems();

	public String getName();

	

	public Item getHandRight();

	public Item getHandLeft();

	public Item getBody();

	public Spell getPreparedSpell();

	public String getPic();

	public Spell castSpell();

	public boolean rollSavingThrow(Spell s, FightInterface caster);

	

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

}
