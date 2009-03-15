package org.infinite.objects;

import java.util.List;
import java.util.Vector;

import org.hibernate.Session;
import org.infinite.db.Manager;
import org.infinite.db.dao.Item;
import org.infinite.db.dao.Npc;
import org.infinite.db.dao.Spell;
import org.infinite.engines.AI.AIEngine;
import org.infinite.engines.fight.FightEngine;
import org.infinite.util.GenericUtil;
import org.infinite.util.InfiniteCst;

public class Monster implements FightInterface{

	//TODO multiple attack

	Npc npc = null;

	int iBehaveStatus = InfiniteCst.NPC_BEHAVE_TALK;
	int iAttackKind = InfiniteCst.ATTACK_TYPE_IDLE;

	private Item handRight = null;
	private Item handLeft = null;	
	private Item body = null;
	//private Item store = null;
	private Spell preparedSpell = null;

	/*
	 * Backpack content
	 */
	private Vector<Item> inventory = new Vector<Item>();

	/*
	 * all Known spells, sorted by type 
	 */
	private Vector<Spell> spellBookFight = new Vector<Spell>();
	private Vector<Spell> spellBookHeal = new Vector<Spell>();
	private Vector<Spell> spellBookProtect = new Vector<Spell>();


	private Vector<Spell> spellsAffecting = new Vector<Spell>();

	/*
	 * Current points (total is taken from NPC object)
	 */
	int currLifePoint = 0;
	int currMagicPoint = 0;
	int currActionPoint = 0;
	int currCharmPoint = 0;


	public Monster(String name){

		Session s = Manager.openSession();
		npc = (Npc)Manager.listByQery(s,"select npc from Npc as npc where name='"+name+"'").get(0);
		Manager.commitAndCloseSession(s);	
		
		iBehaveStatus= InfiniteCst.NPC_BEHAVE_FIGHT;

		currLifePoint = getPointsLifeMax();
		currMagicPoint = getPointsMagicMax();
		currActionPoint = getPointsActionMax();
		currCharmPoint = getPointsCharmMax();
	}



	public int getBaseCA(){
		return (int)Math.round(InfiniteCst.FIGHT_BASE_CA + ( getDexterity()  / 5) );
	}

	public int getTotalCA(){
		return getBaseCA() + getArmorCA() + getShieldCA();
	}

	public int getArmorCA() {

		int ca = 0;
		if(getBody()!=null){

			ca = GenericUtil.getMaxRollDice( getBody().getDamage() );

		}
		return ca;
	}

	public int getShieldCA() {

		int ca = 0;
		if(getHandLeft()!=null && getHandLeft().getType()==InfiniteCst.EQUIP_ISSHIELD)

			ca = GenericUtil.getMaxRollDice( getHandLeft().getDamage() );


		return ca;
	}

	public int getAttackType(FightInterface defender){

		//TODO invoke chooseBestAttack
		AIEngine.chooseBestAttack(this);

		int iNumTypes = 0;

		if(inventory.size()>0 ){
			//TODO AI must choose best weapon
			int ichoose = (int)Math.round( Math.random() * (inventory.size()-1) ); 
			handRight = inventory.get(ichoose);
		}

		switch (iBehaveStatus) {
		case InfiniteCst.NPC_BEHAVE_FIGHT:
			if(spellBookFight.size()>0){
				//TODO AI must choose best spell
				int ichoose = (int)Math.round( Math.random() * (spellBookFight.size()-1) ); 
				setPreparedSpell( spellBookFight.elementAt(ichoose) );

				//if cannot cast choosed spell revert to melee
				if(getPointsMagic()>=getPreparedSpell().getCostMp())
					iNumTypes++;
			}
			break;
		case InfiniteCst.NPC_BEHAVE_HEAL:
			if(spellBookHeal.size()>0){
				//TODO AI must choose best spell
				int ichoose = (int)Math.round( Math.random() * (spellBookHeal.size()-1) ); 
				setPreparedSpell( spellBookHeal.elementAt(ichoose) );
				iNumTypes++;
			}
			break;
		case InfiniteCst.NPC_BEHAVE_DEFEND:
			if(spellBookProtect.size()>0 && getPointsMagic()>0 ){
				//TODO AI must choose best spell
				int ichoose = (int)Math.round( Math.random() * (spellBookProtect.size()-1) ); 
				setPreparedSpell( spellBookProtect.elementAt(ichoose) );
				iNumTypes++;
			}
			break;
		}

		//TODO use AI to decide attack type
		//TODO include item usage ---> not just [0-1]

		//check if available attack cannot be performed due to point lack
		if(iNumTypes==0 && getPointsAction()<=0)
			iAttackKind = InfiniteCst.ATTACK_TYPE_IDLE;
		else if(iNumTypes==1 && getPointsAction()<=0)
			iAttackKind = InfiniteCst.ATTACK_TYPE_MAGIC;
		else
			iAttackKind = (int)Math.round( Math.random()*iNumTypes  );

		return iAttackKind;

	}

	public String[] getAttackName(){
		String szReturn[] = new String[2];
		switch (iAttackKind) {
		case InfiniteCst.ATTACK_TYPE_WEAPON:

			if(getHandRight()==null){
				String ret = "";
				String[] szNames = getDao().getAttack().split(";");
				for (int i = 0; i < szNames.length; i++) {
					ret += ","+szNames[i].substring(0, szNames[i].indexOf(","));

				}
				szReturn =  new String[]{ret.substring(1),ret.substring(1)};
			}
			else
				szReturn = new String[]{getHandRight().getName(), getHandRight().getImage()};
			break;
		case InfiniteCst.ATTACK_TYPE_MAGIC:
			szReturn = new String[]{getPreparedSpell().getName(), getPreparedSpell().getImage()};
			break;
		case InfiniteCst.ATTACK_TYPE_ITEM:
			//szReturn = this.handRight.getName();
			break;
		}
		return szReturn;
	}


	public int getInitiative(){
		// 1d6 random
		int init = GenericUtil.rollDice(1, 6, 0);

		//magic attack are based on intelligence, weapon and items on dexterity
		if(iAttackKind==InfiniteCst.ATTACK_TYPE_MAGIC)
		{
			//add dexterity bonus
			init -= (int)Math.floor( getIntelligence()/5);
		}
		else
		{
			//add dexterity bonus
			init -= (int)Math.floor( getDexterity()/5 );			
		}

		return init;  

	}

	public int getRollToAttack(){

		int cost = getHandRight()!=null?getHandRight().getCostAp():1;
		currActionPoint -= cost;

		int roll = GenericUtil.rollDice(1, 20, 0);
		roll +=  ( getStrenght()/5 );
		return roll;
	}

	public int inflictDamage(int dmg){
		currLifePoint -= dmg;
		return getPointsLife();
	}

	public int healDamage(int heal) {
		currLifePoint += heal;
		if( getPointsLife() > getPointsLifeMax())
			currLifePoint = getPointsLifeMax();
		return getPointsLife();
	}

	public void restRound(int i) {
		currActionPoint += i * getDao().getLevel();		
	}

	public int getSpellDuration(){
		return getPreparedSpell().getDuration();
	}



	public int getAttackDamage(){
		int dmg = 0;

		switch (iAttackKind) {
		case InfiniteCst.ATTACK_TYPE_WEAPON:

			if(getHandRight()==null){

				String[] szNames = getDao().getAttack().split(";");
				for (int i = 0; i < szNames.length; i++) {
					String szDice = "";
					try {
						szDice = szNames[i].substring(szNames[i].indexOf(",")+1);
						dmg += GenericUtil.rollDice( szDice ) ;
					} catch (Exception e) {
						GenericUtil.err("DICE:"+szDice,e);
					}

				}			
			} else
				try {
					dmg = GenericUtil.rollDice( getHandRight().getDamage() ) ;
				} catch (Exception e1) {
					dmg = 0;
				}
				break;
		case InfiniteCst.ATTACK_TYPE_MAGIC:
			try {
				dmg = GenericUtil.rollDice( getPreparedSpell().getDamage() );
			} catch (Exception e) {
				GenericUtil.err("DICE:"+getPreparedSpell().getDamage(), e);
				dmg=0;
			}
			break;
		case InfiniteCst.ATTACK_TYPE_ITEM:
			//dmg = (int)Math.ceil( (getHandRight().getDamage() * Math.random()) );
			break;

		default:
			break;
		}

		return dmg;
	}

	public boolean isAlive(){
		return currLifePoint>0?true:false;
	}

	public int getRewardPX(){
		return getDao().getPx();
	}

	public float getRewardGold(){
		return getDao().getGold();
	}

	public Item[] getRewardItems(){
		return new Item[0];
	}



	public String getName() {
		return getDao().getName();
	}

	


	public Item getHandRight() {
		return handRight;
	}


	public Item getHandLeft() {
		return handLeft;
	}


	public Item getBody() {
		return body;
	}

	public Spell getPreparedSpell(){
		return preparedSpell;
	}

	private void setPreparedSpell(Spell s){
		preparedSpell = s;
	}

	//TODO move to private once spawn engine is available
	@SuppressWarnings("unchecked")
	public void learnSpells(String[] spellsNames){

		if(spellsNames==null || spellsNames.length==0)
			return;

		StringBuilder sb = new StringBuilder("");
		for (int i = 0; i < spellsNames.length; i++) {
			sb.append(",'").append(spellsNames[i]).append("'");
		}
		String query = "select s from org.infinite.db.dao.Spell s where s.name in ("+
		sb.toString().substring(1)	+ ")";

		Session session = Manager.openSession();

		//fighting spells
		List<Spell> l = Manager.listByQery(session, query+" and s.spelltype="+InfiniteCst.MAGIC_ATTACK );
		spellBookFight.addAll(l);

		//healing spells
		l = Manager.listByQery(session, query+" and s.spelltype="+InfiniteCst.MAGIC_HEAL );
		spellBookFight.addAll(l);

		//protection spells
		l = Manager.listByQery(session, query+" and s.spelltype="+InfiniteCst.MAGIC_DEFEND );
		spellBookFight.addAll(l);

		Manager.commitAndCloseSession(session);



	}

	//TODO move to private once spawn engine is available
	@SuppressWarnings("unchecked")
	public void equipItems(String[] itemsNames){

		if(itemsNames==null || itemsNames.length==0)
			return;

		StringBuilder sb = new StringBuilder("");
		for (int i = 0; i < itemsNames.length; i++) {
			sb.append(",'").append(itemsNames[i]).append("'");
		}
		String query = "select i from org.infinite.db.dao.Item i where i.name in ("+
		sb.toString().substring(1)	+ ")";

		Session session = Manager.openSession();
		List<Item> l = Manager.listByQery(session, query);
		Manager.commitAndCloseSession(session);

		inventory.addAll(l);

	}


	public String getPic() {
		return getDao().getImage();
	}



	public Spell castSpell() {
		currMagicPoint -= preparedSpell.getCostMp();
		return preparedSpell;
	}

	public boolean rollSavingThrow(Spell s, FightInterface caster){
		return FightEngine.rollSavingThrow(s, caster, this);
	}


	public Item parseUnarmedAttack() {
		// TODO handle multiple items

		Item item = new Item();				

		String[] szNames = getDao().getAttack().split(";");
		szNames = szNames[0].split(",");

		item.setCostAp(1);
		item.setName(szNames[0]);
		item.setImage(szNames[0]);
		item.setDamage(szNames[1]);
		item.setInitiative(1);		
		item.setType( InfiniteCst.EQUIP_ISWEAPON);

		return item;
	}



	public Vector<Item> getInventory() {
		return inventory;
	}



	public Vector<Spell> getSpellBookFight() {
		return spellBookFight;
	}

	public Npc getDao(){
		return npc;
	}

	

	
	public int getDexterity(){

		int mod = getDao().getBaseDex();
		mod += getHandLeft()==null?0:getHandLeft().getModDex();
		mod += getHandRight()==null?0:getHandRight().getModDex();
		mod += getBody()==null?0:getBody().getModDex();

		for (int i = 0; i < spellsAffecting.size(); i++) {
			mod += spellsAffecting.elementAt(i).getModDex();
		}
		return mod;
	}

	public int getStrenght(){

		int mod = getDao().getBaseStr();
		mod += getHandLeft()==null?0:getHandLeft().getModStr();
		mod += getHandRight()==null?0:getHandRight().getModStr();
		mod += getBody()==null?0:getBody().getModStr();

		for (int i = 0; i < spellsAffecting.size(); i++) {
			mod += spellsAffecting.elementAt(i).getModStr();
		}
		return mod;
	}

	public int getCharisma(){

		int mod = getDao().getBaseCha();
		mod += getHandLeft()==null?0:getHandLeft().getModCha();
		mod += getHandRight()==null?0:getHandRight().getModCha();
		mod += getBody()==null?0:getBody().getModCha();

		for (int i = 0; i < spellsAffecting.size(); i++) {
			mod += spellsAffecting.elementAt(i).getModCha();
		}
		return mod;
	}

	public int getIntelligence(){

		int mod = getDao().getBaseInt();
		mod += getHandLeft()==null?0:getHandLeft().getModInt();
		mod += getHandRight()==null?0:getHandRight().getModInt();
		mod += getBody()==null?0:getBody().getModInt();

		for (int i = 0; i < spellsAffecting.size(); i++) {
			mod += spellsAffecting.elementAt(i).getModInt();
		}
		return mod;
	}
	
	
	



	@SuppressWarnings("unchecked")
	public static String[] getMonsterListing(){

		List<String> l = Manager.listByQery("select m.name from Npc m where m.ismonster=1");

		String[] s = new String[l.size()];
		for (int i = 0; i < l.size(); i++) {
			s[i] = l.get(i);
		}

		return s;
	}
	
	
	
	public int getPointsLife() {
		return currLifePoint;
	}

	
	public int getPointsMagic() {
		return currMagicPoint;
	}
	

	public int getPointsAction() {
		return currActionPoint;
	}
	
	public int getPointsCharm() {
		return currCharmPoint;
	}	

	public int getPointsLifeMax(){
		int mod = getDao().getBasePl();		
		mod += (getStrenght()/5);
		return mod;
	}

	public int getPointsMagicMax(){
		int mod = getDao().getBasePm();		
		mod += (getIntelligence()/5);
		return mod;
	}
	
	public int getPointsActionMax(){
		int mod = getDao().getBasePa();		
		mod += (getDexterity()/5);
		return mod;
	}
	
	public int getPointsCharmMax(){
		int mod = getDao().getBasePc();		
		mod += (getCharisma()/5);
		return mod;
	}

	

}
