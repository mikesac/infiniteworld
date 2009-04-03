package org.infinite.engines.items;

import org.infinite.db.dao.Item;
import org.infinite.db.dao.PlayerOwnItem;

public interface ItemsInterface {

	
	public void moveToInventory(PlayerOwnItem poi);

	public void addToInventory(Item item);
	
	public void dropItem(PlayerOwnItem poi);

	public void equipItem(PlayerOwnItem poi);
	
	public void wearItem(PlayerOwnItem poi) throws Exception;
	
}
