package org.infinite.engines.magic;

import java.util.Date;

import org.infinite.db.Manager;
import org.infinite.db.dao.Player;
import org.infinite.db.dao.PlayerKnowSpell;
import org.infinite.db.dao.Spell;
import org.infinite.db.dao.SpellAffectPlayer;
import org.infinite.engines.fight.PlayerInterface;
import org.infinite.util.GenericUtil;
import org.infinite.util.InfiniteCst;


public class MagicEngine {


	public static void persistKnowSpell(PlayerKnowSpell pks, int status){
		pks.setStatus(status);
		Manager.update(pks);
	}

	public static Spell castSpell(PlayerInterface player, Spell s) {
		
		//not enough magic point to cast
		if( player.getPointsMagic()<s.getCostMp() )
			return null;
		
		try {
			player.addMagicPoints( -1* s.getCostMp() );
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	/**
	 * Roll a saving throw against a spell
	 * @param s
	 * @param caster
	 * @param victim
	 * @return
	 */
	public static boolean rollSavingThrow(Spell s, PlayerInterface caster, PlayerInterface victim) {
		int roll = GenericUtil.rollDice(1 , 20 , 0 ); 
		int success = s.getSavingthrow() - victim.getIntelligence() + caster.getIntelligence();
		return (roll>=success || roll==20);
	}



	public static void  learnSpell(PlayerInterface player,Spell spell) {
		PlayerKnowSpell pks = new PlayerKnowSpell((Player)player.getDao(),spell,InfiniteCst.SPELL_KNOWN);
		learnSpell(player,pks, true);
	}


	public static void learnSpell(PlayerInterface player,PlayerKnowSpell pks,boolean persist){

		switch ( pks.getSpell().getSpelltype() ) {
		case InfiniteCst.MAGIC_ATTACK:
			player.getSpellBookFight().add(pks);
			break;
		case InfiniteCst.MAGIC_HEAL:
			player.getSpellBookHeal().add(pks);
			break;
		case InfiniteCst.MAGIC_DEFEND:
			player.getSpellBookProtect().add(pks);
			break;
		}

		if( pks.getStatus() == InfiniteCst.SPELL_READY){
			player.addToPreparedSpells(pks);
		}
		if(persist){
			Manager.create(pks);
		}
	}




	public static void prepareSpell(PlayerInterface player,PlayerKnowSpell pks){
		prepareSpell(player,pks,true);
	}

	public static void prepareSpell(PlayerInterface player,PlayerKnowSpell pks,boolean persist) {

		pks.setStatus(InfiniteCst.SPELL_READY);

		player.addToPreparedSpells(pks);
		if(persist){
			Manager.update(pks);
		}
	}



	public static void unprepareSpell(PlayerInterface player,int pksId) {
		PlayerKnowSpell pks = null;
		for (int i = 0; i < player.getPreparedSpells().size(); i++) {

			if( player.getPreparedSpells().get(i).getId() == pksId){
				pks = player.getPreparedSpells().remove(i);
				break;
			}			
		}

		if(pks!=null){
			pks.setStatus(InfiniteCst.SPELL_KNOWN);
			Manager.update(pks);

		}
	}

	public static int getAvailableSpellSlots(PlayerInterface p) {
		int slot = p.getIntelligence()/InfiniteCst.CFG_MP_TO_SPELLS_SLOTS - p.getPreparedSpells().size();
		return slot<0?0:slot;
	}

	public static void affectSpells(PlayerInterface p, Spell s,boolean persist) {
		
		SpellAffectPlayer sap= new SpellAffectPlayer();
		sap.setPlayer( (Player) p.getDao() );
		sap.setSpell( s );
		sap.setElapsing( (new Date()).getTime() + s.getDuration() );
		
		p.addToAffectingSpells(sap);
		
		if(persist){
			Manager.create(sap);
		}
		
		
	}

}
