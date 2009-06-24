package org.infinite.engines.AI;

import java.util.ArrayList;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infinite.db.Manager;
import org.infinite.db.dao.Item;
import org.infinite.db.dao.PlayerOwnItem;
import org.infinite.db.dao.Spell;
import org.infinite.engines.magic.MagicEngine;
import org.infinite.objects.Monster;
import org.infinite.util.InfiniteCst;


public class newAIEngine {

	private static final Log log = LogFactory.getLog(newAIEngine.class);

	

	private static int LEVEL_RNDM_NOT = 8;
	private static int LEVEL_RNDM_DWN = LEVEL_RNDM_NOT + 40;
	private static int LEVEL_RNDM_EQ = LEVEL_RNDM_DWN + 50;
	private static int LEVEL_RNDM_UP = LEVEL_RNDM_EQ + 2;


	public static int getLevelPx(int level){

		int px = 0;
		for (int i = 0; i <= level; i++) {
			px += i * InfiniteCst.CFG_LEVEL_PX;
		}

		return px;
	}
	
	public static int getLevelByPx(int Px){

		int level = 0;
		int loop = Px;
		while( loop>=0 ){
			level++;
			loop = Px - getLevelPx(level);
		}

		return level;
	}


	public static int getMatchingLevel(int level){

		if(level==0)
			return 0;

		double rand =  100 * Math.random() ;
		int out = 0;
		if( rand <= LEVEL_RNDM_NOT ){
			out = 0;
		}
		else if( rand <= LEVEL_RNDM_DWN ){
			out = getMatchingLevel(--level);
		}
		else if( rand <= LEVEL_RNDM_EQ ){
			out = level;
		}
		else if( rand <= LEVEL_RNDM_UP ){
			out = level++;
		}

		return out;		
	}


	public static int getRandomNumber(int min,int max){		
		return (int) (Math.floor( (Math.random() * (max-min))) + min);		
	}



	@SuppressWarnings("unchecked")
	public static Monster spawn(String szName) throws Exception{

		log.debug("Starting to spaw "+szName);

		Monster m = new Monster(szName);

		log.debug("monster generated: "+m.getName() );

		int level = m.getLevel();

		//if monster can use weapons
		if( m.getDao().isUseWpn()){			
			spawinInventory(m, level,InfiniteCst.ITEM_TYPE_WEAPON,InfiniteCst.EQUIP_HAND_RIGHT);
		}

		//if monster can use Shields
		if( m.getDao().isUseShld()){
			spawinInventory(m, level,InfiniteCst.ITEM_TYPE_SHIELD,InfiniteCst.EQUIP_HAND_LEFT);
		}

		//if monster can use Shields
		if( m.getDao().isUseArm()){
			spawinInventory(m, level,InfiniteCst.ITEM_TYPE_ARMOR,InfiniteCst.EQUIP_BODY);
		}

		int nItems = m.getDao().getNitem();
		for (int i = 0; i < nItems; i++) {
			//TODO add items to inventory
		}

		
		//check if monster can cast spell
		int nSpellSlots = MagicEngine.getAvailableSpellSlots(m);
		for (int i = 0; i < nSpellSlots; i++) {
			
			int spellLevel = getMatchingLevel(nSpellSlots);
			if(spellLevel>0){
				log.debug("max spell level:"+spellLevel);
				//list all weapons within such level
				ArrayList<Spell> spells = (ArrayList<Spell>) Manager.listByQuery("from "+Spell.class.getName()+" s where s.lev<='"+spellLevel+"'");

				if(spells.size()>0){
					//choose randomly and equip 
					int index = getRandomNumber(0, spells.size());
					Spell s = spells.get(index);
					m.learnSpells( new String[]{s.getName()});
					System.out.println(s.getName());
					
				}
			}
			else{
				log.debug("no item spawned");
			}
			
			
			
			
			
		}



		return m;
	}


	@SuppressWarnings("unchecked")
	private static void spawinInventory(Monster m, int level,int itemType,int bodyPart) {
		//get weapon max level randomly
		int wpnLevel = getMatchingLevel(level);
		if(wpnLevel>0){
			log.debug("max item level:"+wpnLevel);
			//list all weapons within such level
			ArrayList<Item> items = (ArrayList<Item>) Manager.listByQuery("from "+Item.class.getName()+" i where i.type='"+itemType+"' and i.lev<='"+wpnLevel+"'");

			if(items.size()>0){
				//choose randomly and equip 
				int index = getRandomNumber(0, items.size());
				Item it = items.get(index);
				PlayerOwnItem poi = new PlayerOwnItem(null,it,0,bodyPart);
				m.equipItem( poi );
			}
		}
		else{
			log.debug("no item spawned");
		}
	}



}
