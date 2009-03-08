package org.infinite.objects;

import java.util.List;
import java.util.Vector;

import org.hibernate.Session;
import org.infinite.db.Manager;
import org.infinite.db.dao.Area;
import org.infinite.db.dao.Item;
import org.infinite.db.dao.Player;
import org.infinite.db.dao.Spell;
import org.infinite.util.GenericUtil;
import org.infinite.util.InfiniteCst;

public class Character {

	//TODO multiple attack

	Player player = null;
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
	
	public Character(String name, String accountName){

		player = (Player)Manager.listByQery("from org.infinite.db.dao.Player p join fetch p.area a where p.tomcatUsers.user='"+accountName+"' and p.name='"+name+"'").get(0);
	
		
		initCharacterPoints();
	}



	private boolean initCharacterPoints() {
		//TODO questo andrà sostituito con la procedura di rigenerazione punti
		
		getDao().setPl(getMaxLifePoints());
		getDao().setPm(getMaxMagicPoints());
		getDao().setPa(getMaxActionPoints());
		getDao().setPc(getMaxCharmPoints());
		return saveDao();	
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

	public int getAttackType(Monster defender){
	//TODO getAttackType
		return -1;
	}

	public String[] getAttackName(){
		//TODO getAttackName
		return null;
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
		return getLifePoints()>0?true:false;
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

	public int getBaseLifePoint() {
		return getDao().getBasePl();
	}

	
	public int getBaseMagicPoint() {
		return getDao().getBasePm();
	}
	

	public int getBaseActionPoint() {
		return getDao().getBasePa();
	}
	
	public int getBaseCharmPoint() {
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



	public Vector<Item> getInventory() {
		return inventory;
	}



	public Vector<Spell> getSpellBookFight() {
		return spellBookFight;
	}

	public Player getDao(){
		return player;
	}

	private boolean saveDao(){
		return Manager.update(getDao());
	}
	
	public int getMaxActionPoints(){
		int mod = getDao().getBasePa();		
		mod += (getDexterity()/5);
		return mod;
	}

	public int getMaxLifePoints(){
		int mod = getDao().getBasePl();		
		mod += (getStrenght()/5);
		return mod;
	}

	public int getMaxCharmPoints(){
		int mod = getDao().getBasePc();		
		mod += (getCharisma()/5);
		return mod;
	}

	public int getMaxMagicPoints(){
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
		return setLifePoints( getLifePoints() + points );
	}
	
	public int addMagicPoints(int points) throws Exception {
		return setMagicPoints( getMagicPoints() + points);
	}
	
	public int addActionPoints(int points) throws Exception {
		return setActionPoints( getActionPoints() + points);
		}
	
	public int addCharmPoints(int points) throws Exception {
		return setCharmPoints( getCharmPoints() + points);	
	}
	
	public int getActionPoints(){
		return getDao().getPa();
	}

	public int getLifePoints(){
		return getDao().getPl();
	}

	public int getCharmPoints(){
		return getDao().getPc();
	}

	public int getMagicPoints(){
		return getDao().getPm();
	}
	
	public int setActionPoints(int points) throws Exception{
		
		if(points<0)
			points=0;
		if(points>getMaxActionPoints())
			points = getMaxActionPoints();
		
		getDao().setPa(points);
		
		if(!saveDao())
			throw new Exception("Could not save DAO object");
		
		return getDao().getPa();
	}

	public int setLifePoints(int points) throws Exception{
		
		if(points<0)
			points=0;
		if(points>getMaxLifePoints())
			points = getMaxLifePoints();
		
		getDao().setPl(points);
		
		if(!saveDao())
			throw new Exception("Could not save DAO object");
		
		return getDao().getPl();
	}

	public int setCharmPoints(int points) throws Exception{
		
		if(points<0)
			points=0;
		if(points>getMaxCharmPoints())
			points = getMaxCharmPoints();
		
		getDao().setPc(points);		
		if(!saveDao())
			throw new Exception("Could not save DAO object");
		
		return getDao().getPc();
	}

	public int setMagicPoints(int points) throws Exception{
		
		if(points<0)
			points=0;
		if(points>getMaxMagicPoints())
			points = getMaxMagicPoints();
		
		getDao().setPm(points);
		
		if(!saveDao())
			throw new Exception("Could not save DAO object");
		
		return getDao().getPm();
	}

}
