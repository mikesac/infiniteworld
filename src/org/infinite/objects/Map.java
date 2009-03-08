package org.infinite.objects;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.infinite.db.Manager;
import org.infinite.db.dao.Area;
import org.infinite.db.dao.AreaItem;

public class Map {

	private Area dao;
	private List<AreaItem> items;
	
	public static int MAP_WIDTH = 4 * 3 * 72;
	public static int MAP_HEIGHT = 4 * 3 * 42;
	
	@SuppressWarnings("unchecked")
	public Map(Area a) {
		
		setDao(a);
		setItems( Manager.listByQery("select a from org.infinite.db.dao.AreaItem a where a.area.name='"+getDao().getName()+"'") );
		
		
	}

	private void setDao(Area dao) {
		this.dao = dao;
	}

	public Area getDao() {
		return dao;
	}

	private void setItems(List<AreaItem> items) {
		this.items = items;
	}

	public List<AreaItem> getItems() {
		return items;
	}
	
	public int getNx(){
		return getDao().getNx();
	}
	
	public int getNy(){
		return getDao().getNy();
	}
	
	public String getAreaName(){
		return getDao().getName();
	}
	
	public String getAreaDesc(){
		return getDao().getDescription();
	}
	
	public List<AreaItem> getAreaItem(int x, int y){
		
		ArrayList<AreaItem> l = new ArrayList<AreaItem>();
		for (Iterator iterator = getItems().iterator(); iterator.hasNext();) {
			AreaItem areaItem = (AreaItem) iterator.next();
			if(areaItem.getAx()==x && areaItem.getAy()==y)
				l.add(areaItem);
			
		}
		
		return l;
	}
	
	
	
}
