package org.infinite.objects;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.infinite.db.Manager;
import org.infinite.db.dao.Item;
import org.infinite.db.dao.Npc;
import org.infinite.db.dao.PlayerKnowSpell;
import org.infinite.db.dao.PlayerOwnItem;
import org.infinite.db.dao.Spell;
import org.infinite.db.dao.SpellAffectPlayer;
import org.infinite.engines.AI.newAIEngine;
import org.infinite.engines.fight.FightEngine;
import org.infinite.engines.fight.PlayerInterface;
import org.infinite.engines.items.ItemsEngine;
import org.infinite.engines.magic.MagicEngine;
import org.infinite.util.GenericUtil;
import org.infinite.util.InfiniteCst;

/**
 * @author msacchetti
 * 
 * This class implements the Monster character.
 * Many settings comes from the AI engine which will determine monster's behavior
 * 
 * Both Monster and Character implements the PlayerInterface to be handled in the same way inside FightEngine
 * This let re-use fight engine for Player-Monster, Player-Player and (useful for testing) Monster-Monster battles
 * 
 * All possible methods are delegated to the various static Engines to keep the class as small as possible 
 * since many Monster instance can be running in server memory at the same time  
 * 
 */
public class Monster implements PlayerInterface {

	//TODO multiple attack

	Npc npc = null;

	int iBehaveStatus = InfiniteCst.NPC_BEHAVE_TALK;
	int iAttackKind = InfiniteCst.ATTACK_TYPE_IDLE;

	private PlayerOwnItem handRight = null;
	private PlayerOwnItem handLeft = null;	
	private PlayerOwnItem body = null;

	private ArrayList<PlayerKnowSpell> preparedSpell = new ArrayList<PlayerKnowSpell>();

	/*
	 * Backpack content
	 */
	private ArrayList<PlayerOwnItem> inventory = new ArrayList<PlayerOwnItem>();

	/*
	 * all Known spells, sorted by type 
	 */
	private ArrayList<PlayerKnowSpell> spellBookFight = new ArrayList<PlayerKnowSpell>();
	private ArrayList<PlayerKnowSpell> spellBookHeal = new ArrayList<PlayerKnowSpell>();
	private ArrayList<PlayerKnowSpell> spellBookProtect = new ArrayList<PlayerKnowSpell>();


	private ArrayList<SpellAffectPlayer> spellsAffecting = new ArrayList<SpellAffectPlayer>();

	private ArrayList<Object> battlePlan = new ArrayList<Object>();

	/*
	 * Current points (total is taken from NPC object)
	 */
	int currLifePoint = 0;
	int currMagicPoint = 0;
	int currActionPoint = 0;
	int currCharmPoint = 0;


	public Monster(String name){


		npc = (Npc)Manager.listByQuery("select npc from Npc as npc where name='"+name+"'").get(0);


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

	public int getAttackType(PlayerInterface defender){

		//TODO invoke chooseBestAttack
		//AIEngine.chooseBestAttack(this);


		return iAttackKind;

	}
	
	public int getInitiative( int round){
		
		

		int iNumTypes = 0;
/*
		if(getInventory().size()>0 ){
			//TODO AI must choose best weapon
			int ichoose = (int)Math.round( Math.random() * (inventory.size()-1) ); 
			handRight = getInventory().get(ichoose);
		}
*/
		switch (iBehaveStatus) {
		case InfiniteCst.NPC_BEHAVE_FIGHT:
			if(getSpellBookFight().size()>0){
				//TODO AI must choose best spell
				int ichoose = newAIEngine.getRandomNumber(0, (getSpellBookFight().size()-1) ); 
				addToPreparedSpells( getSpellBookFight().get(ichoose) );

				//if cannot cast choosed spell revert to melee
				if(getPointsMagic()>=getPreparedSpells().get(0).getSpell().getCostMp())
					iNumTypes++;
			}
			break;
		case InfiniteCst.NPC_BEHAVE_HEAL:
			if(getSpellBookHeal().size()>0){
				//TODO AI must choose best spell
				int ichoose =  newAIEngine.getRandomNumber(0, (getSpellBookHeal().size()-1) ); 
				addToPreparedSpells( getSpellBookHeal().get(ichoose) );
				iNumTypes++;
			}
			break;
		case InfiniteCst.NPC_BEHAVE_DEFEND:
			if(getSpellBookProtect().size()>0 && getPointsMagic()>0 ){
				//TODO AI must choose best spell
				int ichoose =  newAIEngine.getRandomNumber(0, (getSpellBookProtect().size()-1) ); 
				addToPreparedSpells( getSpellBookProtect().get(ichoose) );
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
			iAttackKind =  newAIEngine.getRandomNumber(0, iNumTypes  );
		
		
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

public String[] getMeleeAttacks( int round){
		
		String out="";
		
		if(getHandRight()==null){
			out = getDao().getAttack();
		}
		else{
			out = getHandRight().getName() + InfiniteCst.ATTACK_INNERSEPARATOR + 
				getHandRight().getImage() + InfiniteCst.ATTACK_INNERSEPARATOR + 
				getHandRight().getDamage();
			
			if(getHandLeft()!=null && getHandLeft().getType()==InfiniteCst.ITEM_TYPE_WEAPON){
				out += InfiniteCst.ATTACKS_SEPARATOR;
				out += getHandLeft().getName() + InfiniteCst.ATTACK_INNERSEPARATOR + 
					getHandLeft().getImage() + InfiniteCst.ATTACK_INNERSEPARATOR + 
					getHandLeft().getDamage();
			}
			
		}		
		return out.split(InfiniteCst.ATTACKS_SEPARATOR);
	}
	
	public String[] getAttackName(int round){
		String szReturn[] = new String[2];
		switch (iAttackKind) {
		case InfiniteCst.ATTACK_TYPE_WEAPON:

			if(getHandRight()==null){
				String ret = "";
				String[] szNames = getDao().getAttack().split("/");
				for (int i = 0; i < szNames.length; i++) {
					ret += ","+szNames[i].substring(0, szNames[i].indexOf(","));

				}
				szReturn =  new String[]{ret.substring(1),ret.substring(1)};
			}
			else
				szReturn = new String[]{getHandRight().getName(), getHandRight().getImage()};
			break;
		case InfiniteCst.ATTACK_TYPE_MAGIC:
			szReturn = new String[]{getPreparedSpells().get(0).getSpell().getName(), getPreparedSpells().get(0).getSpell().getImage()};
			break;
		case InfiniteCst.ATTACK_TYPE_ITEM:
			//szReturn = this.handRight.getName();
			break;
		}
		return szReturn;
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

	public int restRound(int i) {
		int points = i * getDao().getLevel();
		currActionPoint += points;		
		currMagicPoint += points;
		return points;
	}

	public int getSpellDuration(){
		return getPreparedSpells().get(0).getSpell().getDuration();
	}



	public int getAttackDamage(int round){
		int dmg = 0;

		switch (iAttackKind) {
		case InfiniteCst.ATTACK_TYPE_WEAPON:

			if(getHandRight()==null){

				String[] szNames = getDao().getAttack().split("/");
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
				dmg = GenericUtil.rollDice( getPreparedSpells().get(0).getSpell().getDamage() );
			} catch (Exception e) {
				GenericUtil.err("DICE:"+getPreparedSpells().get(0).getSpell().getDamage(), e);
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

	public ArrayList<Item> getRewardItems(){
		
		ArrayList<Item> items = new ArrayList<Item>();
		
		//move all equipped to inventory to do just one loop
		if(getHandLeftPoi()!=null)
			getInventory().add(getHandLeftPoi());
		
		if(getHandRightPoi()!=null)
			getInventory().add(getHandRightPoi());
		
		if(getBodyPoi()!=null)
			getInventory().add(getBodyPoi());
		
		//50% to drop inventory items
		for(int i=0;i<getInventory().size();i++){			
			if(GenericUtil.checkProbability(50)){
				items.add( getInventory().get(i).getItem() );
			}			
		}		
		
		return items;
	}



	public String getName() {
		return getDao().getName();
	}

	@Override
	public int getLevel() {
		return getDao().getLevel();
	}


	public Item getHandRight() {
		return (handRight!=null)?handRight.getItem():null;
	}


	public Item getHandLeft() {
		return (handLeft!=null)?handLeft.getItem():null;
	}


	public Item getBody() {
		return (body!=null)?body.getItem():null;
	}

	public PlayerOwnItem getBodyPoi() {
		return body;
	}

	public void setBody(PlayerOwnItem body) {
		this.body = body;
	}

	public ArrayList<PlayerKnowSpell> getPreparedSpells(){
		return preparedSpell;
	}

	public void addToPreparedSpells(PlayerKnowSpell s){
		getPreparedSpells().add(s);
	}

	public void addToAffectingSpells(Spell s){
		SpellAffectPlayer sap = new SpellAffectPlayer();
		sap.setSpell(s);
		sap.setPlayer(null);
		sap.setElapsing( (new Date()).getTime() + s.getDuration()  );
		addToAffectingSpells(sap);
	}

	public void addToAffectingSpells(SpellAffectPlayer sap ){
		getSpellsAffecting().add(sap);
	}

	public void removeSpellsAffecting( int sapId ) {
		for (int i = 0; i < getSpellsAffecting().size(); i++) {
			if(getSpellsAffecting().get(i).getId() == sapId){
				getSpellsAffecting().remove(i);
				break;
			}
		} 
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



		//fighting spells
		List<Spell> l = Manager.listByQuery( query+" and s.spelltype="+InfiniteCst.MAGIC_ATTACK );
		for (int i = 0; i < l.size(); i++) {
			spellBookFight.add( new PlayerKnowSpell(null,l.get(i),0) );
		}		

		//healing spells
		l = Manager.listByQuery( query+" and s.spelltype="+InfiniteCst.MAGIC_HEAL );
		for (int i = 0; i < l.size(); i++) {
			spellBookHeal.add( new PlayerKnowSpell(null,l.get(i),0) );
		}

		//protection spells
		l = Manager.listByQuery( query+" and s.spelltype="+InfiniteCst.MAGIC_DEFEND );
		for (int i = 0; i < l.size(); i++) {
			spellBookProtect.add( new PlayerKnowSpell(null,l.get(i),0) );
		}





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

		List<Item> l = Manager.listByQuery( query);
		for (int i = 0; i < l.size(); i++) {
			inventory.add( new PlayerOwnItem(null,l.get(i),0,InfiniteCst.EQUIP_STORE) );
		}

	}


	public String getPic() {
		return getDao().getImage();
	}



	public Spell castSpell() {
		currMagicPoint -= getPreparedSpells().get(0).getSpell().getCostMp();
		return getPreparedSpells().get(0).getSpell();
	}

	public boolean rollSavingThrow(Spell s, PlayerInterface caster){
		return MagicEngine.rollSavingThrow(s, caster, this);
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



	public ArrayList<PlayerOwnItem> getInventory() {
		return inventory;
	}

	/**
	 * A newly owned item is moved to inventory (used to loot/buy items)
	 * NOTE: no persitence with this method 
	 */
	public void addToInventory(PlayerOwnItem poi){
		getInventory().add(poi);
	}

	/**
	 * A newly owned item is moved to inventory (used to loot/buy items)
	 */ 
	public void addToInventory(Item item){
		ItemsEngine.addToInventory(this,item, true);
	}


	@Override
	public ArrayList<PlayerKnowSpell> getSpellBookFight() {
		return spellBookFight;
	}

	@Override
	public ArrayList<PlayerKnowSpell> getSpellBookHeal() {
		return spellBookHeal;
	}

	@Override
	public ArrayList<PlayerKnowSpell> getSpellBookProtect() {
		return spellBookProtect;
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
			mod += spellsAffecting.get(i).getSpell().getModDex();
		}
		return mod;
	}

	public int getStrenght(){

		int mod = getDao().getBaseStr();
		mod += getHandLeft()==null?0:getHandLeft().getModStr();
		mod += getHandRight()==null?0:getHandRight().getModStr();
		mod += getBody()==null?0:getBody().getModStr();

		for (int i = 0; i < spellsAffecting.size(); i++) {
			mod += spellsAffecting.get(i).getSpell().getModStr();
		}
		return mod;
	}

	public int getCharisma(){

		int mod = getDao().getBaseCha();
		mod += getHandLeft()==null?0:getHandLeft().getModCha();
		mod += getHandRight()==null?0:getHandRight().getModCha();
		mod += getBody()==null?0:getBody().getModCha();

		for (int i = 0; i < spellsAffecting.size(); i++) {
			mod += spellsAffecting.get(i).getSpell().getModCha();
		}
		return mod;
	}

	public int getIntelligence(){

		int mod = getDao().getBaseInt();
		mod += getHandLeft()==null?0:getHandLeft().getModInt();
		mod += getHandRight()==null?0:getHandRight().getModInt();
		mod += getBody()==null?0:getBody().getModInt();

		for (int i = 0; i < spellsAffecting.size(); i++) {
			mod += spellsAffecting.get(i).getSpell().getModInt();
		}
		return mod;
	}






	@SuppressWarnings("unchecked")
	public static String[] getMonsterListing(){

		List<String> l = Manager.listByQuery("select m.name from Npc m where m.ismonster=1");

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



	@Override
	public int addActionPoints(int points) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}



	@Override
	public int addCharmPoints(int points) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}



	@Override
	public int addLifePoints(int points) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}



	@Override
	public int addMagicPoints(int points) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}



	@Override
	public Spell castSpell(Spell s) {
		// TODO Auto-generated method stub
		return null;
	}



	@Override
	public void learnSpell(Spell spell) {
		// TODO Auto-generated method stub

	}



	@Override
	public void prepareSpell(PlayerKnowSpell pks) {
		// TODO Auto-generated method stub

	}



	@Override
	public void unprepareSpell(int pksId) {
		// TODO Auto-generated method stub

	}

	@Override
	public void prepareForFight() {

		Item[] it = FightEngine.parseUnarmedAttack( getDao().getAttack() );
		for (int i = 0; i < it.length; i++) {
			PlayerOwnItem poi = new PlayerOwnItem(null,it[i],0, InfiniteCst.EQUIP_HAND_RIGHT );
			getBattlePlan().add( poi );
		}

	}



	public void setBattlePlan(ArrayList<Object> battlePlan) {
		this.battlePlan = battlePlan;
	}



	public ArrayList<Object> getBattlePlan() {
		return battlePlan;
	}



	@Override
	public Object getCurrentAttack(int round) {
		// TODO Auto-generated method stub
		return null;
	}


	/*
	 * Unimplemented method - useless for spawned monster
	 * @see org.infinite.engines.fight.PlayerInterface#addExperience(int)
	 */
	public int addExperience(int rewardPX) {
		return 0;
	}

	/*
	 * Unimplemented method - useless for spawned monster
	 * @see org.infinite.engines.fight.PlayerInterface#addGold(float)
	 */
	public float addGold(float rewardGold) {
		return 0;
	}

	/*
	 * Unimplemented method - useless for spawned monster
	 * @see org.infinite.engines.fight.PlayerInterface#lootItems(org.infinite.db.dao.Item[])
	 */
	public void lootItems(ArrayList<Item> rewardItems) {
		return;		
	}



	public int getIBehaveStatus() {
		return iBehaveStatus;
	}



	public int getIAttackKind() {
		return iAttackKind;
	}



	public ArrayList<PlayerKnowSpell> getPreparedSpell() {
		return preparedSpell;
	}



	public ArrayList<SpellAffectPlayer> getSpellsAffecting() {
		return spellsAffecting;
	}



	public int getCurrLifePoint() {
		return currLifePoint;
	}



	public int getCurrMagicPoint() {
		return currMagicPoint;
	}



	public int getCurrActionPoint() {
		return currActionPoint;
	}



	public int getCurrCharmPoint() {
		return currCharmPoint;
	}

	public PlayerOwnItem getHandRightPoi() {
		return handRight;
	}


	public PlayerOwnItem getHandLeftPoi() {
		return handLeft;
	}
	
	

	public void setHandRight(PlayerOwnItem handRight) {
		this.handRight = handRight;
	}
	public void setHandLeft(PlayerOwnItem handLeft) {
		this.handLeft = handLeft;
	}
	

	public void equipItem(PlayerOwnItem poi){
		ItemsEngine.equipItem(this, poi);
	}

}
