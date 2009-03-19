package org.infinite.util;

public class InfiniteCst {

	
	public static final int FIGHT_BASE_CA = 10;
	
	public static final int MAGIC_BASE_ST = 10;
	
	public static final int EQUIP_STORE			= 0;
	public static final int EQUIP_HAND_RIGHT 	= 1;
	public static final int EQUIP_HAND_LEFT 	= 2;
	public static final int EQUIP_BODY 			= 3;
	
	public static final int EQUIP_ISWEAPON			= 0;
	public static final int EQUIP_ISSHIELD			= 1;
	public static final int EQUIP_ISITEM			= 2;
	
	public static final int POI_EQUIP = 0;
	public static final int POI_DROP = 1;
	
	public static final int ITEM_TYPE_EMPTY = 0;
	public static final int ITEM_TYPE_WEAPON = 1;
	public static final int ITEM_TYPE_SHIELD = 2;
	public static final int ITEM_TYPE_ARMOR = 3;
	
	
	public static final int OWN_STATUS_OWNED	= 0;
	public static final int OWN_STATUS_EQUIPPED	= 1;
	
	public static final int MAGIC_ATTACK 	= 0;
	public static final int MAGIC_HEAL 		= 1;
	public static final int MAGIC_DEFEND 	= 2;
	
	public static final int NPC_BEHAVE_IDLE 	= -1;
	public static final int NPC_BEHAVE_TALK 	= 0;
	public static final int NPC_BEHAVE_SELL 	= 1;
	public static final int NPC_BEHAVE_FIGHT 	= 2;
	public static final int NPC_BEHAVE_DEFEND 	= 3;
	public static final int NPC_BEHAVE_HEAL 	= 4;
	
	public static final int ATTACK_TYPE_IDLE = -1;
	public static final int ATTACK_TYPE_WEAPON = 0;
	public static final int ATTACK_TYPE_MAGIC = 1;
	public static final int ATTACK_TYPE_ITEM = 2;

	/**
	 * Amount of milliseconds for let regeneration occurs on Character stats
	 */
	public static final long CHARACTER_REGENERATION_TIME = 5 * 60 * 1000; 
	
	
}
