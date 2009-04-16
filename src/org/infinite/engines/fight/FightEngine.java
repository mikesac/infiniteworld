package org.infinite.engines.fight;

import java.util.Vector;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.infinite.db.dao.Item;
import org.infinite.db.dao.Player;
import org.infinite.db.dao.PlayerKnowSpell;
import org.infinite.db.dao.Spell;
import org.infinite.util.GenericUtil;
import org.infinite.util.InfiniteCst;
import org.infinite.util.XmlUtil;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;


public class FightEngine {

	public static String runFight(Vector<PlayerInterface> firstSide, Vector<PlayerInterface> secondSide) throws Exception{

		Vector<PlayerInterface> fightOrder = new Vector<PlayerInterface>();
		int[] targetOrder = null;

		DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();			
		Document dFight = docBuilder.newDocument();

		Element parent = dFight.createElement("fight");

		//prepare for fight
		prepareForFight(firstSide,secondSide);

		Element eParties = dFight.createElement("parties");
		Element eFirstSide = dFight.createElement("firstside");
		for (int i = 0; i < firstSide.size(); i++) {
			eFirstSide.appendChild( getFighterXml( firstSide.elementAt(i) , dFight,true)  );
		}
		eParties.appendChild(eFirstSide);

		Element eSecondSide = dFight.createElement("secondside");
		for (int i = 0; i < secondSide.size(); i++) {
			eSecondSide.appendChild( getFighterXml( secondSide.elementAt(i) , dFight,false)  );
		}
		eParties.appendChild(eSecondSide);
		parent.appendChild(eParties);

		
		
		int round = 0;
		do {

			
			Element eRound = dFight.createElement("round");
			eRound.setAttribute("num", ""+(round++) );

			//evaluate init & choose targets
			targetOrder = evaluateInit(round,firstSide, secondSide, fightOrder, targetOrder);


			//loop and attack
			for (int i = 0; i < fightOrder.size(); i++) {

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

				Element eAttack = dFight.createElement("attack");
				eAttack.appendChild( getFightXml(attacker, dFight,"attacker",firstSide.contains(attacker)) );
				eAttack.appendChild( getFightXml(defender, dFight,"defender",firstSide.contains(defender)) );

				switch (atkType) {
				case InfiniteCst.ATTACK_TYPE_WEAPON:					
					eAttack.appendChild( meleeFight(round, attacker, defender,dFight) );
					break;
				case InfiniteCst.ATTACK_TYPE_MAGIC:
					eAttack.appendChild( magicFight(round, attacker, defender,dFight) );
					break;
				default: //InfiniteCst.ATTACK_TYPE_IDLE
					eAttack.appendChild( idleFight(round, attacker, dFight) );
					
				break;
				}

				//after attack is resolved check if someone died

				//if defender dies
				if( ! defender.isAlive() ){
					//TODO handle monster death
					Element eDeath = dFight.createElement("death");
					eDeath.setAttribute("name", defender.getName());

					Element eGold = dFight.createElement("gold");
					eGold.setTextContent( ""+defender.getRewardGold());
					eDeath.appendChild(eGold);

					Element ePx = dFight.createElement("xp");
					ePx.setTextContent(""+defender.getRewardPX() );
					eDeath.appendChild(ePx);

					Element eItem = dFight.createElement("items");
					eItem.setTextContent("0"); //TODO items xml
					eDeath.appendChild(eItem);


					if( firstSide.removeElement(defender) ){
						//						System.out.println("------> "+defender.getName()+" removed from firstSide "+firstSide.size()+" remains");
					}
					if( secondSide.removeElement(defender) ){
						//						System.out.println("------> "+defender.getName()+" removed from secondSide "+secondSide.size()+" remains");
					}

					eAttack.appendChild(eDeath);
				}
				eRound.appendChild(eAttack);
			}


			parent.appendChild(eRound);
		} while ( firstSide.size()> 0 && secondSide.size()>0);

		Element esum = dFight.createElement("summary");
		//TODO add recap XML
		if(firstSide.size()==0)
			esum.setTextContent("Second side wins!");
		else
			esum.setTextContent("First side wins!");
		parent.appendChild(esum);		

		dFight.appendChild(parent);

		return XmlUtil.xml2String(dFight);
	}

	private static Node idleFight(int round, PlayerInterface attacker, Document dFight) {
		attacker.restRound(1);
		return dFight.createElement("idle");
		
	}

	private static Node magicFight(int round, PlayerInterface attacker, PlayerInterface defender,Document doc) {		
		Element out = doc.createElement("magic");

		String[] szAtkData = attacker.getAttackName(round);
		out.setAttribute("name", szAtkData[0]);
		out.setAttribute("img", szAtkData[1]);

		Spell spell = attacker.castSpell( ((PlayerKnowSpell)attacker.getCurrentAttack(round)).getSpell() );
		int type = spell.getSpelltype();
		out.setAttribute("type", ""+type);

		switch (type) 
		{
		case InfiniteCst.MAGIC_ATTACK:

			int dmg=0;
			try {
				dmg = GenericUtil.rollDice( spell.getDamage() );
			} catch (Exception e) {
				GenericUtil.err("DICE:"+spell.getDamage(),e);
				e.printStackTrace();
			}

			if( (spell.getSavingthrow() >= 0 ) && defender.rollSavingThrow(spell, attacker) ){
				dmg = Math.round(dmg/2);
			}

			defender.inflictDamage(dmg);
			out.setAttribute("dmg",""+dmg);
			break;
			
		case InfiniteCst.MAGIC_HEAL:

			try {
					int heal = GenericUtil.rollDice( spell.getDamage() );
					attacker.healDamage( heal );
					//out.setTextContent("Healed for "+heal+"HP");
					out.setAttribute("dmg",""+heal);
				} catch (Exception e) {
					GenericUtil.err("DICE:"+spell.getDamage(),e);
					e.printStackTrace();
				}

			break;

		default:
			break;
		}


		//TODO stack effects

		// TODO magicFight
		//TODO Damage & Saving Throw
		//TODO Effects stack
		return out;
	}

	private static Element meleeFight(int round, PlayerInterface attacker, PlayerInterface defender, Document doc) {

		Element out = doc.createElement("melee");
		int atkRoll = attacker.getRollToAttack();
		int defCA = defender.getTotalCA();

		String[] szAtkData = attacker.getAttackName(round);
		out.setAttribute("type", szAtkData[0]);
		out.setAttribute("img", szAtkData[1]);
		out.setAttribute("roll", ""+atkRoll);
		out.setAttribute("ca", ""+defCA);


		if(atkRoll>= defCA){
			int inflict = attacker.getAttackDamage(round);
			int remain = defender.inflictDamage(inflict);
			out.setAttribute("hit", "1");
			out.setAttribute("dmg", ""+inflict);
			out.setAttribute("rhp", ""+remain);
		}
		else{
			out.setAttribute("hit", "0");
		}

		return out;
	}

	private static void prepareForFight(Vector<PlayerInterface> firstSide, Vector<PlayerInterface> secondSide) {
		
		for (int i = 0; i < firstSide.size(); i++) {
			firstSide.get(i).prepareForFight();
		}
		
		for (int i = 0; i < secondSide.size(); i++) {
			secondSide.get(i).prepareForFight();
		}

	}

	private static int[] evaluateInit(int round, Vector<PlayerInterface> firstSide, Vector<PlayerInterface> secondSide, Vector<PlayerInterface> fightOrder, int[] targetOrder) {

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


	private static Element getFighterXml(PlayerInterface m,Document doc,boolean isFirstPary){
		return getFightXml(m, doc,null,isFirstPary);
	}

	private static Element getFightXml(PlayerInterface m,Document doc,String szAttName,boolean isFirstPary){
		Element em = doc.createElement("monster");
		if(szAttName!=null && szAttName.length()>0)
			em.setAttribute("type", szAttName);
		em.setAttribute("name", m.getName() );
		em.setAttribute("first", ""+isFirstPary );
		
		if(m.getDao() instanceof Player){
			em.setAttribute("img", "../player/"+m.getPic() );
		}
		else{
			em.setAttribute("img", m.getPic() );
		}
		em.setAttribute("thp", ""+m.getPointsLifeMax() );
		em.setAttribute("chp", ""+m.getPointsLife() );
		em.setAttribute("tmp", ""+m.getPointsMagicMax() );
		em.setAttribute("cmp", ""+m.getPointsMagic() );
		em.setAttribute("tap", ""+m.getPointsActionMax() );
		em.setAttribute("cap", ""+m.getPointsAction() );

		return em;
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

	
}
