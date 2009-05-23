package org.infinite.engines.AI;

import java.util.Vector;

import javax.xml.transform.TransformerException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infinite.db.dao.Item;
import org.infinite.db.dao.Spell;
import org.infinite.objects.Monster;
import org.infinite.util.GenericUtil;
import org.infinite.util.InfiniteCst;
import org.infinite.util.XmlUtil;
import org.w3c.dom.Document;
import org.w3c.dom.Node;

import com.sun.org.apache.xpath.internal.XPathAPI;


public class AIEngine {

	private static final Log log = LogFactory.getLog(AIEngine.class);

	@Deprecated
	public static Monster spawn(String szName) throws Exception{
		
		Monster m = new Monster(szName);
		//String szXML = XmlUtil.XMLPATH + "monster/" + m.getNpc().getXmlItems();
		String szXML = "xml/monster/baseitem.xml";
		
		Document doc = XmlUtil.name2Doc(szXML);
		
		log.debug(szName);
		
		String szUrl = "//level"+m.getDao().getLevel();
		
		Node n = XPathAPI.selectSingleNode(doc.getFirstChild(), szUrl);
		
		if(n!=null){
		
		int a = GenericUtil.toInt( n.getAttributes().getNamedItem("a").getNodeValue() , 0 );
		int h = GenericUtil.toInt(n.getAttributes().getNamedItem("h").getNodeValue() , 0 );
		int p = GenericUtil.toInt(n.getAttributes().getNamedItem("p").getNodeValue() , 0 );
		
		
		double rate = Math.round((99.0f * Math.random())+1);
		String szHandRightURL = szUrl + "/handright[@rate <= "+rate+"]";
		Node nHR;
		try {
			log.debug("rate="+rate);
			nHR = XPathAPI.selectNodeList(n, szHandRightURL).item(0);
			
			if(nHR!=null){
				m.equipItems(new String[]{nHR.getTextContent()} );
				log.debug("--->"+nHR.getTextContent());
			}
			
		} catch (Exception e1) {}
		
		
		StringBuilder sb  = new StringBuilder("");
		for (int i = 0; i < a; i++) {
			rate = (99 * Math.random())+1;
			log.debug("rate="+rate);
			String szSpellURL = szUrl + "/spellfight[@rate <= "+rate+"]";
			Node nSP;
			try {
				nSP = XPathAPI.selectNodeList(n, szSpellURL).item(0);
			} catch (TransformerException e) {
				continue;
			}
			if(nSP!=null){
				sb.append(",").append(nSP.getTextContent());
				log.debug("--->"+nSP.getTextContent());
			}
		}

		for (int i = 0; i < h; i++) {
			rate = (99 * Math.random())+1;
			log.debug("rate="+rate);
			String szSpellURL = szUrl + "/spellheal[@rate <= "+rate+"]";
			Node nSP;
			try {
				nSP = XPathAPI.selectNodeList(n, szSpellURL).item(0);
			} catch (TransformerException e) {
				continue;
			}
			if(nSP!=null){
				sb.append(",").append(nSP.getTextContent());
				log.debug("--->"+nSP.getTextContent());
			}
		}

		for (int i = 0; i < p; i++) {
			rate = (99 * Math.random())+1;
			log.debug("rate="+rate);
			String szSpellURL = szUrl + "/spellprotect[@rate <= "+rate+"]";
			Node nSP;
			try {
				nSP = XPathAPI.selectNodeList(n, szSpellURL).item(0);
			} catch (TransformerException e) {
				continue;
			}
			if(nSP!=null){
				sb.append(",").append(nSP.getTextContent());
				log.debug("--->"+nSP.getTextContent());
			}
		}
		
		String spells = sb.toString();
		if(spells.length()>1){
			spells = spells.substring(1);
			m.learnSpells( spells.split(",") );
		}
		
		}
		
		return m;
	}
	
	
	public static void chooseBestAttack(Monster m){

		Vector<Object>  availableAttacks = new Vector<Object>();


		int totalCost = 0;
		int totalMax = 0;
		int totalMin = 0;
		int totalInit = 0;

		//get all available weapons		
		for (int i = 0; i < m.getInventory().size(); i++) {						
			if(m.getInventory().get(i).getItem().getType()==InfiniteCst.EQUIP_ISWEAPON){
				availableAttacks.add( m.getInventory().get(i).getItem());
				totalCost += m.getInventory().get(i).getItem().getCostAp();
				totalInit += m.getInventory().get(i).getItem().getInitiative();
				totalMax += GenericUtil.getMaxRollDice( m.getInventory().get(i).getItem().getDamage() );
				totalMin += GenericUtil.getMinRollDice( m.getInventory().get(i).getItem().getDamage() );
			}
		}

		//check unarmed attack
		if(availableAttacks.size()==0){
			Item ua = m.parseUnarmedAttack();
			availableAttacks.add( ua);
			totalCost += ua.getCostAp();
			totalInit += ua.getInitiative();
			totalMax += GenericUtil.getMaxRollDice( ua.getDamage() );
			totalMin += GenericUtil.getMinRollDice( ua.getDamage() );
		}

		//get all available spells which can be cast
		for (int i = 0; i < m.getSpellBookFight().size(); i++) {						
			if(m.getSpellBookFight().get(i).getSpell().getCostMp() <= m.getPointsMagic() ){
				availableAttacks.add( m.getSpellBookFight().get(i).getSpell());
				totalCost += m.getSpellBookFight().get(i).getSpell().getCostMp();
				totalInit += m.getSpellBookFight().get(i).getSpell().getInitiative();
				totalMax += GenericUtil.getMaxRollDice( m.getSpellBookFight().get(i).getSpell().getDamage() );
				totalMin += GenericUtil.getMinRollDice( m.getSpellBookFight().get(i).getSpell().getDamage() );
			}
		}

		int totalPoints = m.getPointsAction() + m.getPointsMagic();
		int n = availableAttacks.size();
		int[] probs = new int[n];
		for (int i = 0; i < probs.length; i++) {

			int cost = 0;
			int dMax = 0;
			int dMin = 0;
			int init = 0;
			int points = 0;
//			String szName = "";

			if(availableAttacks.elementAt(i) instanceof Item){
				Item item = (Item)availableAttacks.elementAt(i);
				cost = item.getCostAp();
				dMax = GenericUtil.getMaxRollDice( item.getDamage() );
				dMin = GenericUtil.getMinRollDice( item.getDamage() );
				init = item.getInitiative();
				points = m.getPointsAction();
//				szName = item.getName();
			}
			else if(availableAttacks.elementAt(i) instanceof Spell){
				Spell spell = (Spell)availableAttacks.elementAt(i);
				cost = spell.getCostMp();
				dMax = GenericUtil.getMaxRollDice( spell.getDamage() );
				dMin = GenericUtil.getMinRollDice( spell.getDamage() );
				init = spell.getInitiative();
				points = m.getPointsMagic();
//				szName = spell.getName();
			}

			float p = (1.0f*points/totalPoints)+(1.0f*dMax/totalMax)+(1.0f*dMin/totalMin);

			if(n>1){
				p += (2 -(1.0f*cost/totalCost) - (1.0f*init/totalInit))  /  (n-1);
				p = p/3;
			}
			else
				p = p/5;

			//System.out.println(i +" - "+ szName+ " = "+Math.round(p*100)+"%");
		}



		//TODO do also for items
	}

}
