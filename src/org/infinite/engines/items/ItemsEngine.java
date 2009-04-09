package org.infinite.engines.items;

import org.infinite.db.Manager;
import org.infinite.db.dao.Item;
import org.infinite.db.dao.PlayerOwnItem;
import org.infinite.objects.Character;
import org.infinite.util.InfiniteCst;

public class ItemsEngine {

	
	public static void persistOwnItem(PlayerOwnItem poi,int bodypart, int status){
		poi.setBodypart(bodypart);
		poi.setStatus(status);
		Manager.update(poi);
	}

	public static void moveToInventory(Character player,PlayerOwnItem poi) {
		moveToInventory(player,poi,true);
	}

	public static void moveToInventory(Character player,PlayerOwnItem poi,boolean persist) {

		poi.setBodypart(InfiniteCst.EQUIP_STORE);

		player.addToInventory(poi);
		if(persist){
			Manager.update(poi);
		}
	}

	public static void addToInventory(Character player,Item item){
		addToInventory(player,item, true);
	}
	
	public static void addToInventory(Character player,Item item,boolean persist) {

		PlayerOwnItem poi = new PlayerOwnItem(player.getDao(),item,0,InfiniteCst.EQUIP_STORE);

		player.addToInventory(poi);
		if(persist){
			Manager.create(poi);
		}
	}

	public static void removeFromInventory(Character player,int poiId) {
		
		for (int i = 0; i < player.getInventory().size(); i++) {
			
			if( player.getInventory().get(i).getId() == poiId){
				player.getInventory().remove(i);
				break;
			}			
		}		
	}


	public static void dropItem(Character player,PlayerOwnItem poi){
		removeFromInventory(player,poi.getId());
		Manager.delete(poi);
	}

	public static int equipItem(Character player,PlayerOwnItem poi){
		
		int previousId = -1;
		switch ( poi.getBodypart() ) {
		case InfiniteCst.EQUIP_BODY:
			previousId = equipBody( player, poi , false);
			break;
		case InfiniteCst.EQUIP_HAND_LEFT:
			previousId = equipHandLeft( player,poi,false );
			break;
		case InfiniteCst.EQUIP_HAND_RIGHT:				
			previousId = equipHandRight( player,poi,false);
			break;
		default:
			moveToInventory( player,poi,false);
		break;
		}
		return previousId;
	}
	
	public static int wearItem(Character player,PlayerOwnItem poi) throws Exception {
		
		int previousId = -1; 
		if(poi.getItem().getType() == InfiniteCst.ITEM_TYPE_WEAPON)
			previousId = equipHandRight(player,poi);
		else if ( poi.getItem().getType() == InfiniteCst.ITEM_TYPE_SHIELD) {
			previousId = equipHandLeft(player,poi);
		}
		else if(poi.getItem().getType() == InfiniteCst.ITEM_TYPE_ARMOR){
			previousId = equipBody(player,poi);
		}else{
			throw new Exception( "Cannot equip "+poi.getItem().getName() );
		}
		return previousId;
	}
	

	public static int equipHandRight(Character player,PlayerOwnItem poi) {	
		return equipHandRight(player,poi,true);
	}

	public static int equipHandRight(Character player,PlayerOwnItem poi, boolean persist) {	

		int previousId = -1;
		//if another item is equipped put in inventory
		PlayerOwnItem previous = player.getHandRightPoi(); 
		if( previous!=null){
			moveToInventory(player,previous);
			previousId = previous.getId();
		}

		player.setHandRight(poi);
		removeFromInventory(player,poi.getId());
		if(persist){
			persistOwnItem(poi, InfiniteCst.EQUIP_HAND_RIGHT, 0);
		}
		
		return previousId;
	}


	public static int equipHandLeft(Character player,PlayerOwnItem poi) {	
		return equipHandLeft(player,poi,true);
	}

	public static int equipHandLeft(Character player,PlayerOwnItem poi, boolean persist) {	

		int previousId = -1;
		//if another item is equipped put in inventory
		PlayerOwnItem previous = player.getHandLeftPoi(); 
		if( previous!=null){
			moveToInventory(player,previous);
			previousId = previous.getId();
		}

		player.setHandLeft(poi);
		if(persist){
			persistOwnItem(poi, InfiniteCst.EQUIP_HAND_LEFT, 0);
		}
		removeFromInventory(player,poi.getId());
		
		return previousId;
	}


	public static int equipBody(Character player,PlayerOwnItem poi) {	
		return equipBody(player,poi,true);
	}

	public static int equipBody(Character player,PlayerOwnItem poi, boolean persist) {	

		int previousId = -1;
		//if another item is equipped put in inventory
		PlayerOwnItem previous = player.getBodyPoi(); 
		if( previous!=null){
			moveToInventory(player,previous);
			previousId = previous.getId();
		}

		player.setBody(poi);
		if(persist){
			persistOwnItem(poi, InfiniteCst.EQUIP_BODY, 0);
		}
		removeFromInventory(player,poi.getId());
		return previousId;
	}
	
	
	
	
}
