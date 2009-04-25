package org.infinite.objects;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.infinite.db.Manager;
import org.infinite.db.dao.Area;
import org.infinite.db.dao.AreaItem;
import org.infinite.engines.map.MapEngine;

public class Map {

	private Area dao;
	private List<AreaItem> items;
	private List<Integer> itemsStatus = new ArrayList<Integer>();
	
	public static int MAP_WIDTH = 4 * 3 * 72;
	public static int MAP_HEIGHT = 4 * 3 * 42;
	
	@SuppressWarnings("unchecked")
	public Map(Area a,Character c) {
		
		setDao(a);
		setItems( Manager.listByQuery("select a from org.infinite.db.dao.AreaItem a where a.areaid='"+getDao().getId()+"'") );
		
		for (int i = 0; i < getItems().size(); i++) {
			int status = MapEngine.getAreaStatus(c, getItems().get(i) );
			getItemsStatus().add(i, status); 
		}
		
		
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
		for (Iterator<AreaItem> iterator = getItems().iterator(); iterator.hasNext();) {
			AreaItem areaItem = iterator.next();
			if(areaItem.getAreax()==x && areaItem.getAreay()==y){
				l.add(areaItem);	
			}
		}		
		return l;
	}
		
		public List<Integer> getAreaStatus(int x, int y){
			
			ArrayList<Integer> l = new ArrayList<Integer>();
			for (Iterator<AreaItem> iterator = getItems().iterator(); iterator.hasNext();) {
				AreaItem areaItem = iterator.next();
				if(areaItem.getAreax()==x && areaItem.getAreay()==y){
					int index = getItems().indexOf(areaItem);
					l.add( getItemsStatus().get( index ) );
				}
			}		
			return l;
		}

		

		public List<Integer> getItemsStatus() {
			return itemsStatus;
		}
	
	
	
}
