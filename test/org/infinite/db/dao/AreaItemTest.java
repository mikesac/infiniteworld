package org.infinite.db.dao;

import org.infinite.db.Manager;
import org.junit.Test;
import static org.junit.Assert.assertNotNull;

public class AreaItemTest {

	String aiName = "NewAreaItem"; 	
	String aiIcon = "temp"; 	
	int aiCost = 0; 	
	int aiAreaX = 0; 	
	int aiAreaY = 0; 	
	int aiX = 0; 	
	int aiY = 0; 	
	String aiLock = ""; 	
	String aiQLock = ""; 	
	String aiUrl = ""; 	
	boolean aiDirect = false; 	
	boolean aiLoop = false; 	
	boolean aiHide = false; 	
	int aiLevel = 0; 	
	String aiNpcs = "";
	
	int iAreaID = 999;
	
	@Test
	public void createTest() {
		// TODO Auto-generated constructor stub
		
		
		AreaItem ai = new AreaItem(aiName, aiIcon, aiCost, iAreaID,
				 (short)aiAreaX, (short)aiAreaY, aiX, aiY, aiLock,aiQLock, aiUrl,  
				 aiLoop, aiHide, aiLevel, aiNpcs);
		
		assertNotNull(ai);
		
		
		
		Manager.create(ai);
		
		
		
		
		
		
	}
	
	
	
}
