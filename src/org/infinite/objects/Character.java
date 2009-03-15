package org.infinite.objects;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Vector;

import org.infinite.db.Manager;
import org.infinite.db.dao.Area;
import org.infinite.db.dao.Item;
import org.infinite.db.dao.Player;
import org.infinite.db.dao.PlayerOwnItem;
import org.infinite.db.dao.Spell;
import org.infinite.engines.fight.FightEngine;
import org.infinite.util.GenericUtil;
import org.infinite.util.InfiniteCst;

public class Character implements FightInterface {

	//TODO multiple attack

	Player player = null;
	int iAttackKind = InfiniteCst.ATTACK_TYPE_IDLE;

	private Item handRight = null;
	private Item handLeft = null;	
	private Item body = null;

	private Spell preparedSpell = null;

	/*
	 * Backpack content
	 */
	private ArrayList<Item> inventory = new ArrayList<Item>();

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

	public Character(String name, String accountName){

		player = (Player)Manager.listByQery("from org.infinite.db.dao.Player p join fetch p.area a where p.tomcatUsers.user='"+accountName+"' and p.name='"+name+"'").get(0);
		ArrayList<PlayerOwnItem> poi = (ArrayList<PlayerOwnItem>) Manager.listByQery("from org.infinite.db.dao.PlayerOwnItem poi join fetch poi.item i where poi.player='"+getDao().getId()+"'");

		//equip all items without re-sync to DB
		for (int i = 0; i < poi.size(); i++) {
			
			switch ( poi.get(i).getBodypart() ) {
			case InfiniteCst.EQUIP_BODY:
				equipBody( poi.get(i).getItem() , false);
				break;
			case InfiniteCst.EQUIP_HAND_LEFT:
				equipHandLeft(poi.get(i).getItem(),false );
				break;
			case InfiniteCst.EQUIP_HAND_RIGHT:				
				equipHandRight(poi.get(i).getItem(),false);
				break;
			default:
				putInInventory(poi.get(i).getItem(),false);
				break;
			}
			
		}
				
	}
	private void persistOwnItem(Item item,int bodypart, int status){
		PlayerOwnItem poi = new PlayerOwnItem();
		poi.setPlayer(getDao());
		poi.setItem(item);
		poi.setBodypart(InfiniteCst.EQUIP_STORE);
		poi.setStatus(0);
		Manager.update(poi);
	}

	public void putInInventory(Item item) {
		putInInventory(item,true);
	}
		
	private void putInInventory(Item item,boolean persist) {
		
		inventory.add(item);
		if(persist){
			persistOwnItem(item,InfiniteCst.EQUIP_STORE, 0);
		}
	}


	public void equipHandRight(Item item) {	
		equipHandRight(item,true);
	}
	
	private void equipHandRight(Item item, boolean persist) {	

		//if another item is equipped put in inventory
		Item previous = getHandRight(); 
		if( previous!=null)
			putInInventory(previous);
		
		setHandRight(item);
		if(persist){
			persistOwnItem(item, InfiniteCst.EQUIP_HAND_RIGHT, 0);
		}
		
	}


	public void equipHandLeft(Item item) {	
		equipHandLeft(item,true);
	}
	
	private void equipHandLeft(Item item, boolean persist) {	
		
		//if another item is equipped put in inventory
		Item previous = getHandLeft(); 
		if( previous!=null)
			putInInventory(previous);
		
		setHandLeft(item);
		if(persist){
			persistOwnItem(item, InfiniteCst.EQUIP_HAND_LEFT, 0);
		}		
	}


	public void equipBody(Item item) {	
		equipBody(item,true);
	}
	
	private void equipBody(Item item, boolean persist) {	
		
		//if another item is equipped put in inventory
		Item previous = getBody(); 
		if( previous!=null)
			putInInventory(previous);
		
		setBody(item);
		if(persist){
			persistOwnItem(item, InfiniteCst.EQUIP_BODY, 0);
		}		
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

		try {
			addActionPoints( -1 * cost);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		int roll = GenericUtil.rollDice(1, 20, 0);
		roll +=  ( getStrenght()/5 );
		return roll;
	}

	public int inflictDamage(int dmg){
		int pl = -1;
		try {
			pl = addLifePoints( -1 * dmg);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pl;
	}

	public int healDamage(int heal) {

		int pl = -1;
		try {
			pl=  addLifePoints( heal );
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}
		return pl;
	}

	public void restRound(int i) {
		try {
			addActionPoints( i * getDao().getLevel() );
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
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
		return getPointsLife()>0?true:false;
	}

	public int getExperience(){
		return getDao().getPx();
	}

	public float getGold(){
		return getDao().getGold();
	}

	public Item[] getRewardItems(){
		return new Item[0];
	}



	public String getName() {
		return getDao().getName();
	}

	public int getPointsLifeBase() {
		return getDao().getBasePl();
	}


	public int getPointsMagicBase() {
		return getDao().getBasePm();
	}


	public int getPointsActionBase() {
		return getDao().getBasePa();
	}

	public int getPointsCharmBase() {
		return getDao().getBasePc();
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



	public void learnSpells(String spellsName){
		//TODO add to PlayerKnowSpell and push to spellbook
	}


	public void equipItems(String itemName){
		//TODO add to PlayerOwnItem and push to inventory
	}


	public String getPic() {
		return getDao().getImage();
	}



	public Spell castSpell() {
		try {
			addMagicPoints( -1* preparedSpell.getCostMp() );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return preparedSpell;
	}

	public boolean rollSavingThrow(Spell s, Monster caster){

		int roll = GenericUtil.rollDice(1 , 20 , 0 ); 
		int success = s.getSavingthrow() - getIntelligence() + caster.getIntelligence();

		return (roll>=success || roll==20);
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



	public ArrayList<Item> getInventory() {
		return inventory;
	}
	
	public Item getInventoryItem(int i) {
		return inventory.get(i);
	}

	public Vector<Spell> getSpellBookFight() {
		return spellBookFight;
	}
	
	public Vector<Spell> getSpellBookHeal() {
		return spellBookHeal;
	}
	
	public Vector<Spell> getSpellBookProtect() {
		return spellBookProtect;
	}

	public Player getDao(){
		return player;
	}

	private boolean saveDao(){
		return Manager.update(getDao());
	}

	public int getPointsActionMax(){
		int mod = getDao().getBasePa();		
		mod += (getDexterity()/5);
		return mod;
	}

	public int getPointsLifeMax(){
		int mod = getDao().getBasePl();		
		mod += (getStrenght()/5);
		return mod;
	}

	public int getPointsCharmMax(){
		int mod = getDao().getBasePc();		
		mod += (getCharisma()/5);
		return mod;
	}

	public int getPointsMagicMax(){
		int mod = getDao().getBasePm();		
		mod += (getIntelligence()/5);
		return mod;
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


	public int getLevel(){
		return getDao().getLevel();
	}




	@SuppressWarnings("unchecked")
	public static List<Player> getCharacterListing(String account){
		return Manager.listByQery("from org.infinite.db.dao.Player p join fetch p.area a where p.tomcatUsers.user='"+account+"'  ");

	}



	public Area getArea() {		
		return getDao().getArea();
	}

	public boolean moveToArea(Area a){

		boolean ret = true;
		//TODO check if player owns lock for that area before moving
		if(true){
			getDao().setArea(a);
			try {
				addActionPoints( -1 * a.getCost() );
			} catch (Exception e) {
				e.printStackTrace();
				ret = false;
			}
		}

		return ret;

	}


	private int addLifePoints(int points) throws Exception {
		return setPointsLife( getPointsLife() + points );
	}

	public int addMagicPoints(int points) throws Exception {
		return setPointsMagic( getPointsMagic() + points);
	}

	public int addActionPoints(int points) throws Exception {
		return setPointsAction( getPointsAction() + points);
	}

	public int addCharmPoints(int points) throws Exception {
		return setPointsCharm( getPointsCharm() + points);	
	}

	public int getPointsAction(){
		return getDao().getPa();
	}

	public int getPointsLife(){
		return getDao().getPl();
	}

	public int getPointsCharm(){
		return getDao().getPc();
	}

	public int getPointsMagic(){
		return getDao().getPm();
	}


	public int setPointsAction(int points) throws Exception{
		return setPointsAction(points, true);
	}

	private int setPointsAction(int points,boolean save) throws Exception{

		if(points<0)
			points=0;
		if(points>getPointsActionMax())
			points = getPointsActionMax();

		getDao().setPa(points);

		if(save){
			markForRegeneration();
			if(!saveDao())
				throw new Exception("Could not save DAO object");
		}
		return getDao().getPa();
	}

	public int setPointsLife(int points) throws Exception{
		return setPointsLife(points,true);
	}

	private int setPointsLife(int points, boolean save) throws Exception{

		if(points<0)
			points=0;
		if(points>getPointsLifeMax())
			points = getPointsLifeMax();

		getDao().setPl(points);

		if(save){
			markForRegeneration();
			if(!saveDao())
				throw new Exception("Could not save DAO object");
		}
		return getDao().getPl();
	}

	public int setPointsCharm(int points) throws Exception{
		return setPointsCharm(points, true);
	}

	private int setPointsCharm(int points,boolean save) throws Exception{

		if(points<0)
			points=0;
		if(points>getPointsCharmMax())
			points = getPointsCharmMax();

		getDao().setPc(points);		

		if(save){
			if(!saveDao())
				markForRegeneration();
			throw new Exception("Could not save DAO object");
		}
		return getDao().getPc();
	}

	public int setPointsMagic(int points) throws Exception{
		return setMagicPoints(points,true);
	}

	private int setMagicPoints(int points,boolean save) throws Exception{

		if(points<0)
			points=0;
		if(points>getPointsMagicMax())
			points = getPointsMagicMax();

		getDao().setPm(points);

		if(save){
			markForRegeneration();
			if(!saveDao())
				throw new Exception("Could not save DAO object");
		}
		return getDao().getPm();
	}

	/**
	 * This method must mark the timestamp of the first subtraction to character's stats.
	 * this time will be used to evaluate regeneration rate on every request for character status
	 */
	private void markForRegeneration(){		

		//check if a previous modification exist
		if(getDao().getStatsMod()==0)
		{
			long now = 0;
			//check if some stat is not up to the maximum
			if( getDao().getPl()<getPointsLifeMax() ||	getDao().getPm()<getPointsMagicMax() ||
					getDao().getPa()<getPointsActionMax() || getDao().getPc()<getPointsCharmMax())
			{		

				now = (new Date()).getTime() ;
			}
			getDao().setStatsMod( now );
		}

	}

	public long getNexRegenereationTime(){
		
		//milliseconds to the next regeneration
		if(getDao().getStatsMod()==0)
			return 0;
		long time = (getDao().getStatsMod() + InfiniteCst.CHARACTER_REGENERATION_TIME - (new Date()).getTime() );
		if(time<0)
			time = 0;
		return time;
	}
	
	
	public static Character checkForRegeneration(Character c){

		long time = c.getDao().getStatsMod();

		if(time!=0){

			long now = (new Date()).getTime();
			//eval how many time the regeneration time has elapsed
			int n = (int)Math.floor((now-time)/InfiniteCst.CHARACTER_REGENERATION_TIME) ;

			//at lease one regeneration occurs
			if(n>0){
				//regenerate 1pt per elapsed interval
				int ll = c.getDao().getPl() + n;
				int mm = c.getDao().getPm() + n;
				int aa = c.getDao().getPa() + n;
				int cc = c.getDao().getPc() + n;

				if(ll<c.getPointsLifeMax() || mm<c.getPointsMagicMax() || aa<c.getPointsActionMax() || cc < c.getPointsCharmMax())
				{
					//if still not at maximum, update time
					time = time + (n * InfiniteCst.CHARACTER_REGENERATION_TIME);
				}
				else{
					//else set timet to zero
					time = 0;
				}

				try {
					c.setPointsLife(ll,false);
					c.setMagicPoints(mm,false);
					c.setPointsAction(aa,false);
					c.setPointsCharm(cc,false);
					c.getDao().setStatsMod(time);
					c.saveDao();
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}


			}

		}		
		return c;
	}



	@Override
	public int getAttackType(FightInterface defender) {
		// TODO this is done just for testing, implements it really
		return InfiniteCst.ATTACK_TYPE_WEAPON;
	}
	
	public String[] getAttackName(){
		//TODO this is done just for testing, implements it really
		
		String ret = "";
		String[] szNames = getDao().getAttack().split(";");
		for (int i = 0; i < szNames.length; i++) {
			ret += ","+szNames[i].substring(0, szNames[i].indexOf(","));

		}
		return  new String[]{ret.substring(1),ret.substring(1)};
	}

	@Override
	public float getRewardGold() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getRewardPX() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean rollSavingThrow(Spell s, FightInterface caster) {
		return FightEngine.rollSavingThrow(s, caster, this);
	}
	
	
	private void setHandRight(Item handRight) {
		this.handRight = handRight;
	}
	private void setHandLeft(Item handLeft) {
		this.handLeft = handLeft;
	}
	private void setBody(Item body) {
		this.body = body;
	}

}
