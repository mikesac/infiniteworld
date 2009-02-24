package org.infinite.engines.fight;

import java.util.Vector;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.infinite.db.dao.Spell;
import org.infinite.objects.Monster;
import org.infinite.util.GenericUtil;
import org.infinite.util.InfiniteCst;
import org.infinite.util.XmlUtil;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;


public class FightEngine {

	public static String runFight(Vector<Monster> firstSide, Vector<Monster> secondSide) throws Exception{

		Vector<Monster> fightOrder = new Vector<Monster>();
		int[] targetOrder = null;

		DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();			
		Document dFight = docBuilder.newDocument();

		Element parent = dFight.createElement("fight");

		//prepare for fight
		prepareForFight(firstSide,secondSide);

		Element eParties = dFight.createElement("parties");
		Element eFirstSide = dFight.createElement("firstside");
		for (int i = 0; i < firstSide.size(); i++) {
			eFirstSide.appendChild( getMonsterXml( firstSide.elementAt(i) , dFight,true)  );
		}
		eParties.appendChild(eFirstSide);

		Element eSecondSide = dFight.createElement("secondside");
		for (int i = 0; i < secondSide.size(); i++) {
			eSecondSide.appendChild( getMonsterXml( secondSide.elementAt(i) , dFight,false)  );
		}
		eParties.appendChild(eSecondSide);
		parent.appendChild(eParties);

		int round = 0;
		do {


			Element eRound = dFight.createElement("round");
			eRound.setAttribute("num", ""+(round++) );

			//evaluate init & choose targets
			targetOrder = evaluateInit(firstSide, secondSide, fightOrder, targetOrder);


			//loop and attack
			for (int i = 0; i < fightOrder.size(); i++) {

				//get attacker
				Monster attacker = fightOrder.elementAt( i );

				//attacker has already been killed, skip!
				if(! attacker.isAlive() )
					continue;

				//get defender
				Monster defender = fightOrder.elementAt( targetOrder[i] );

				//defender has already been killed, skip!
				if(! defender.isAlive() )
					continue;

				//fight!				
				int atkType = attacker.getAttackType(defender);

				Element eAttack = dFight.createElement("attack");
				eAttack.appendChild( getMonsterXml(attacker, dFight,"attacker",firstSide.contains(attacker)) );
				eAttack.appendChild( getMonsterXml(defender, dFight,"defender",firstSide.contains(defender)) );

				switch (atkType) {
				case InfiniteCst.ATTACK_TYPE_WEAPON:					
					eAttack.appendChild( meleeFight(attacker, defender,dFight) );
					break;
				case InfiniteCst.ATTACK_TYPE_MAGIC:
					eAttack.appendChild( magicFight(attacker, defender,dFight) );
					break;
				default: //InfiniteCst.ATTACK_TYPE_IDLE
					eAttack.appendChild( idleFight(attacker, dFight) );
					
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

	private static Node idleFight(Monster attacker, Document dFight) {
		attacker.restRound(1);
		return dFight.createElement("idle");
		
	}

	private static Node magicFight(Monster attacker, Monster defender,Document doc) {		
		Element out = doc.createElement("magic");

		String[] szAtkData = attacker.getAttackName();
		out.setAttribute("name", szAtkData[0]);
		out.setAttribute("img", szAtkData[1]);

		Spell spell = attacker.castSpell();
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

	private static Element meleeFight(Monster attacker, Monster defender, Document doc) {

		Element out = doc.createElement("melee");
		int atkRoll = attacker.getRollToAttack();
		int defCA = defender.getTotalCA();

		String[] szAtkData = attacker.getAttackName();
		out.setAttribute("type", szAtkData[0]);
		out.setAttribute("img", szAtkData[1]);
		out.setAttribute("roll", ""+atkRoll);
		out.setAttribute("ca", ""+defCA);


		if(atkRoll>= defCA){
			int inflict = attacker.getAttackDamage();
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



	private static void prepareForFight(Vector<Monster> firstSide, Vector<Monster> secondSide) {
		// TODO use this to be sure all data are available inside player/npc

	}

	private static int[] evaluateInit(Vector<Monster> firstSide, Vector<Monster> secondSide, Vector<Monster> fightOrder, int[] targetOrder) {

		//populate target arrays & temporary whole array
		fightOrder.removeAllElements();
		Vector<Monster> tmpOrder = new Vector<Monster>();
		tmpOrder.addAll(firstSide);
		tmpOrder.addAll(secondSide);

		//get all init values
		int[] initValues = new int[tmpOrder.size()];
		int[] initOrder = new int[initValues.length];
		targetOrder = new int[initValues.length];
		for (int i = 0; i < initValues.length; i++) {
			initValues[i] = tmpOrder.elementAt(i).getInitiative();			
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
			Monster defender = secondSide.get(iRandomChoose);
			int iDefenderIndex = fightOrder.indexOf(defender);

			//which position has the attacker ?
			Monster attacker = firstSide.get(i);
			int iAttackerIndex = fightOrder.indexOf(attacker);

			targetOrder[iAttackerIndex] = iDefenderIndex;
		}


		//do the same for other side
		for (int i = 0; i < secondSide.size(); i++) {

			//choose randomly a target from the other side
			int iRandomChoose = (int) Math.floor(  Math.random()  * (firstSide.size()-1) );

			//which position has the defender ?
			Monster defender = firstSide.get(iRandomChoose);
			int iDefenderIndex = fightOrder.indexOf(defender);

			//which position has the attacker ?
			Monster attacker = secondSide.get(i);
			int iAttackerIndex = fightOrder.indexOf(attacker);

			targetOrder[iAttackerIndex] = iDefenderIndex;
		}

		return targetOrder;
	}


	private static Element getMonsterXml(Monster m,Document doc,boolean isFirstPary){
		return getMonsterXml(m, doc,null,isFirstPary);
	}

	private static Element getMonsterXml(Monster m,Document doc,String szAttName,boolean isFirstPary){
		Element em = doc.createElement("monster");
		if(szAttName!=null && szAttName.length()>0)
			em.setAttribute("type", szAttName);
		em.setAttribute("name", m.getName() );
		em.setAttribute("first", ""+isFirstPary );
		em.setAttribute("img", m.getPic() );
		em.setAttribute("thp", ""+m.getLifePoints() );
		em.setAttribute("chp", ""+m.getCurrLifePoint() );
		em.setAttribute("tmp", ""+m.getMagicPoints() );
		em.setAttribute("cmp", ""+m.getCurrMagicPoint() );
		em.setAttribute("tap", ""+m.getActionPoints() );
		em.setAttribute("cap", ""+m.getCurrActionPoint() );

		return em;
	}

}
