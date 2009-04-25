package org.infinite.engines.map;

import org.infinite.db.Manager;
import org.infinite.db.dao.Area;
import org.infinite.db.dao.AreaItem;
import org.infinite.objects.Character;

public class MapEngine {

	public static final int AREA_STATUS_HERE = 0;
	public static final int AREA_STATUS_BANNED = 1;
	public static final int AREA_STATUS_LOCKED = 2;
	public static final int AREA_STATUS_HIDDEN = 3;
	public static final int AREA_STATUS_FAR = 4;
	public static final int AREA_STATUS_ACCESSIBLE = 5;
	
	
	
	
	/**
	 * Check if player can move to the selected item, if so set player to the new area
	 * @param p Player
	 * @param ai Area to move into
	 * @return true if move is successful
	 */
	public static Area moveToAreaItem(Character p , AreaItem ai) {
		
		Area out= getAreaFromAreaItem(p.getAreaItem());		
	
		int status = getAreaStatus(p,ai);
		
		if( status == AREA_STATUS_ACCESSIBLE || status == AREA_STATUS_HERE ){
			p.getDao().setAreaItem(ai);
			
				try {
					p.addActionPoints( -1 * ai.getCost() );
					out = getAreaFromAreaItem(ai);
				} catch (Exception e) {
					e.printStackTrace();
				}			
		}	
		return out;
	}
	
	
	
	private static boolean isSteppable(String lock, int id){
		
		if(lock.length()==0)
			return true;
		
		return ( ("," + lock + ",").indexOf( ""+id ) != -1 );
	}
	
	public static int getAreaStatus(Character p , AreaItem ai){
		
		int out = AREA_STATUS_FAR;
		
		//I'm near enough to access it
		if(  isSteppable( ai.getArealock() , p.getAreaItem().getId()) )
			out = AREA_STATUS_ACCESSIBLE;
		
		//Areal level is to high to access
		if( p.getDao().getLevel() < ai.getAreaItemLevel() ){
			out = AREA_STATUS_BANNED;
		}
		
		//TODO quest lock
		
		//if is not reachable an bust be hidden, change status
		if( out!=AREA_STATUS_ACCESSIBLE && out !=AREA_STATUS_HERE && ai.isHidemode() )
			out = AREA_STATUS_HIDDEN;
		
		//if i'm on the area it cannot be unaccessible
		if( ai.getId().equals( p.getAreaItem().getId()) )
			out = AREA_STATUS_HERE;
		
		return out;
		
	}
	
	public static Area getAreaFromAreaItem(AreaItem ai){
		
		return (Area)Manager.findById(Area.class.getName(), ai.getAreaid());
		
	}
}
