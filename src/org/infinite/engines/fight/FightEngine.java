package org.infinite.engines.fight;

import java.util.ArrayList;
import java.util.Date;
import java.util.Vector;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infinite.db.Manager;
import org.infinite.db.dao.Item;
import org.infinite.db.dao.PlayerKnowSpell;
import org.infinite.db.dao.Spell;
import org.infinite.db.dao.SpellAffectPlayer;
import org.infinite.util.GenericUtil;
import org.infinite.util.InfiniteCst;


public class FightEngine {

	private static final Log log = LogFactory.getLog(FightEngine.class);

	
	public static ArrayList<FightRound> runFight(ArrayList<PlayerInterface> firstSide, ArrayList<PlayerInterface> secondSide) throws Exception{

		ArrayList<FightRound> report = new ArrayList<FightRound>();
		
		Vector<PlayerInterface> fightOrder = new Vector<PlayerInterface>();
		int[] targetOrder = null;

		//prepare for fight
		prepareForFight(firstSide,secondSide);
		
		int round = 0;
		do {

			//evaluate init & choose targets
			targetOrder = evaluateInit(round,firstSide, secondSide, fightOrder, targetOrder);

			evaluateAffectingSpell(fightOrder,round,report);
			
			
			//loop and attack
			for (int i = 0; i < fightOrder.size(); i++) {
				
				FightRound r = new FightRound(round);

				//get attacker
				PlayerInterface attacker = fightOrder.elementAt( i );

				//attacker has already been killed, skip!
				if(! attacker.isAlive() )
					continue;

				//get defender
				PlayerInterface defender = fightOrder.elementAt( targetOrder[i] );

				//defender has already been killed, skip!
				if(! defender.isAlive() )
					continue;

				//fight!				
				int atkType = attacker.getAttackType(defender);

				r.setAttacker( attacker.getName() );
				r.setDefender( defender.getName() );
				r.setFirstSide( firstSide.contains(attacker) );


				switch (atkType) {
				case InfiniteCst.ATTACK_TYPE_WEAPON:					
					meleeFight(round, attacker, defender,r );
					break;
				case InfiniteCst.ATTACK_TYPE_MAGIC:
					magicFight(round, attacker, defender,r );
					break;
				default: //InfiniteCst.ATTACK_TYPE_IDLE
					idleFight(round, attacker, r );
					
				break;
				}

				//after attack is resolved check if someone died

				//if defender dies
				if( ! defender.isAlive() ){

					r.setEndRound(true);
					loot(attacker,defender,r);
										
					if( firstSide.remove(defender) ){
						log.debug(defender.getName()+" removed from firstSide "+firstSide.size()+" remains");
					}
					if( secondSide.remove(defender) ){
						log.debug("------> "+defender.getName()+" removed from secondSide "+secondSide.size()+" remains");
					}
				}
				
				report.add(r);
			}//for - fightorder
			
			round++;
			
		} while ( firstSide.size()> 0 && secondSide.size()>0);

		
		//TODO add recap XML

		return report;
	}

	private static void evaluateAffectingSpell(Vector<PlayerInterface> fightOrder, int round,	ArrayList<FightRound> report) {
		// TODO evaluate spells effects
		
		for (int i = 0; i < fightOrder.size(); i++) {
			
			PlayerInterface p = fightOrder.get(i);
			
			//fist check if some spell elapsed
			checkForElapsedSpells(p);
			
			for (int j = 0; j < p.getSpellsAffecting().size(); j++) 
			{
				
				Spell s = p.getSpellsAffecting().get(j).getSpell();
				
				FightRound r = new FightRound(round);
				r.setSpellEffect(true);
				r.setAttacker( s.getName() );
				r.setAttackImg( s.getImage() );
				r.setDefender( p.getName() );
				r.setAttackType(s.getSpelltype());
				r.setRoundType(InfiniteCst.ATTACK_TYPE_MAGIC);
				
				switch (s.getSpelltype()) {
				case InfiniteCst.MAGIC_ATTACK:
					int dmg=0;
						try {
							dmg = GenericUtil.rollDice( s.getDamage() );
						} catch (Exception e) {
							log.error("evaluateAffectingSpell - DIce:"+s.getDamage(),e);
						}
					p.inflictDamage(dmg);
					r.setAttackDmg(dmg);
					
					break;
				case InfiniteCst.MAGIC_HEAL:

					int heal=0;
					try {
						heal = GenericUtil.rollDice( s.getDamage() );
					} catch (Exception e) {
						log.error("evaluateAffectingSpell - DIce:"+s.getDamage(),e);
					}
					p.healDamage(heal);
					r.setAttackDmg(heal);
					
					break;
				case InfiniteCst.MAGIC_DEFEND:
					//this should not have any active effect, only stats modification
					break;
				}
				
				report.add(r);
				
			}
			
			
		}
		
		
	}

	private static void loot(PlayerInterface attacker, PlayerInterface defender, FightRound r) {	
		
		attacker.addGold( defender.getRewardGold() );
		r.setGold(defender.getRewardGold());
		
		attacker.addExperience( defender.getRewardPX() );
		r.setPx(defender.getRewardPX());
		
		ArrayList<Item> items = defender.getRewardItems();
		attacker.lootItems( items );
		r.addItems(items);
	}

	
	private static void idleFight(int round, PlayerInterface attacker, FightRound r) {
		int points = attacker.restRound(1);
		r.setAttacker(attacker.getName());
		r.setAttackDmg(points);
		r.setRoundType(InfiniteCst.ATTACK_TYPE_IDLE);
		
	}

	
	private static void magicFight(int round, PlayerInterface attacker, PlayerInterface defender,FightRound r ) {		
		

		String[] szAtkData = attacker.getAttackName(round);
		
		r.setAttackName(szAtkData[0]);
		r.setAttackImg(szAtkData[1]);
		r.setRoundType(InfiniteCst.ATTACK_TYPE_MAGIC);

		Spell spell = ((PlayerKnowSpell)attacker.getCurrentAttack(round)).getSpell();
		
		
		spell = attacker.castSpell( spell );
		
		if(spell==null){
			r.setAttackType(InfiniteCst.MAGIC_UNCAST);
			return;
		}
		
		int type = spell.getSpelltype();
		r.setAttackType(type);

		switch (type) 
		{
		case InfiniteCst.MAGIC_ATTACK:

			int dmg=0;
			try {
				dmg = GenericUtil.rollDice( spell.getDamage() );
			} catch (Exception e) {
				log.error("magicFight DICE:"+spell.getDamage(),e);
			}

			if( (spell.getSavingthrow() >= 0 ) && defender.rollSavingThrow(spell, attacker) ){
				dmg = Math.round(dmg/2);
			}

			defender.inflictDamage(dmg);
			r.setAttackDmg(dmg);
			break;
			
		case InfiniteCst.MAGIC_HEAL:

			try {
					int heal = GenericUtil.rollDice( spell.getDamage() );
					attacker.healDamage( heal );
					//out.setTextContent("Healed for "+heal+"HP");
					r.setAttackDmg(heal);
				} catch (Exception e) {
					log.error("DICE:"+spell.getDamage(),e);
				}

			break;

		default:
			break;
		}

		if(spell.getDuration()>0){
			//attack spells last on target, protection & heal last on caster
			if( spell.getSpelltype()== InfiniteCst.MAGIC_ATTACK )
				defender.addToAffectingSpells(spell);
			else
				attacker.addToAffectingSpells(spell);
		}
		
	}

	
	private static void meleeFight(int round, PlayerInterface attacker, PlayerInterface defender, FightRound r ) {

		int atkRoll = attacker.getRollToAttack();
		int defCA = defender.getTotalCA();

		String[] szAtkData = attacker.getAttackName(round);
		
		r.setRoundType(InfiniteCst.ATTACK_TYPE_WEAPON);
		r.setAttackName(szAtkData[0]);
		r.setAttackImg(szAtkData[1]);
		r.setAttackRoll(atkRoll);
		r.setDefenderCA(defCA);

		if(atkRoll>= defCA){
			int inflict = attacker.getAttackDamage(round);
			int remain = defender.inflictDamage(inflict);
			r.setHit(true);
			r.setAttackDmg(inflict);
			r.setRemainHp(remain);
		}
		else{
			r.setHit(false);
		}

	}
	
	
	private static void prepareForFight(ArrayList<PlayerInterface> firstSide, ArrayList<PlayerInterface> secondSide) {
		
		for (int i = 0; i < firstSide.size(); i++) {
			firstSide.get(i).prepareForFight();
		}
		
		for (int i = 0; i < secondSide.size(); i++) {
			secondSide.get(i).prepareForFight();
		}

	}

	
	private static int[] evaluateInit(int round, ArrayList<PlayerInterface> firstSide, ArrayList<PlayerInterface> secondSide, Vector<PlayerInterface> fightOrder, int[] targetOrder) {

		//populate target arrays & temporary whole array
		fightOrder.removeAllElements();
		Vector<PlayerInterface> tmpOrder = new Vector<PlayerInterface>();
		tmpOrder.addAll(firstSide);
		tmpOrder.addAll(secondSide);

		//get all init values
		int[] initValues = new int[tmpOrder.size()];
		int[] initOrder = new int[initValues.length];
		targetOrder = new int[initValues.length];
		for (int i = 0; i < initValues.length; i++) {
			initValues[i] = tmpOrder.elementAt(i).getInitiative( round );			
		}

		//sort init array and get vector order
		initOrder = GenericUtil.quickSort(initValues);
		for (int i = 0; i < initValues.length; i++) {
			fightOrder.add(i, tmpOrder.elementAt(initOrder[i]));
		}

		/*
		System.out.println("\n----- Fight Order -----");
		for (int i = 0; i < fightOrder.size(); i++) {
			System.out.println(i+":"+fightOrder.elementAt(i).getName());
		}
		 */

		//every fighter of first choose a target of second side
		for (int i = 0; i < firstSide.size(); i++) {

			//choose randomly a target from the other side
			int iRandomChoose = (int) Math.floor(  Math.random()  * (secondSide.size()-1) );

			//which position has the defender ?
			PlayerInterface defender = secondSide.get(iRandomChoose);
			int iDefenderIndex = fightOrder.indexOf(defender);

			//which position has the attacker ?
			PlayerInterface attacker = firstSide.get(i);
			int iAttackerIndex = fightOrder.indexOf(attacker);

			targetOrder[iAttackerIndex] = iDefenderIndex;
		}


		//do the same for other side
		for (int i = 0; i < secondSide.size(); i++) {

			//choose randomly a target from the other side
			int iRandomChoose = (int) Math.floor(  Math.random()  * (firstSide.size()-1) );

			//which position has the defender ?
			PlayerInterface defender = firstSide.get(iRandomChoose);
			int iDefenderIndex = fightOrder.indexOf(defender);

			//which position has the attacker ?
			PlayerInterface attacker = secondSide.get(i);
			int iAttackerIndex = fightOrder.indexOf(attacker);

			targetOrder[iAttackerIndex] = iDefenderIndex;
		}

		return targetOrder;
	}

	
	public static Item[] parseUnarmedAttack( String attack) {

		String[] szNames = attack.split("/");
		Item[] items = new Item[szNames.length];
		
		for (int i = 0; i < items.length; i++) {
			szNames = attack.split(",");
			Item it = new Item(szNames[0],"",szNames[0], 1,0,0,0,0,0,0,0,0,0,0,1,1,szNames[1],1,-1,InfiniteCst.EQUIP_ISWEAPON);
			items[i] = it;
		}	
		
		return items;
	}
	
	
	public static int getAvailableAttackSlot(PlayerInterface p) {
		int slots = 10;//p.getLevel() / InfiniteCst.CFG_LV_TO_BATTLE_PLAN_SLOTS +1;
		return slots;
	}

	
	public static void checkForElapsedSpells(PlayerInterface p){

		long now = (new Date()).getTime();
		for (int i = 0; i < p.getSpellsAffecting().size(); i++) {

			SpellAffectPlayer sap = p.getSpellsAffecting().get(i);
			if(sap.getElapsing() <= now ){
				p.removeSpellsAffecting( p.getSpellsAffecting().get(i).getId() );
				Manager.delete( sap );
			}		
			
		}		
	}
	
}
