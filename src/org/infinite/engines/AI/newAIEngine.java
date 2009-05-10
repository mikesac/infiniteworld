package org.infinite.engines.AI;


public class newAIEngine {
	
	private static int LEVEL_PX = 100;
	
	private static int LEVEL_RNDM_NOT = 8;
	private static int LEVEL_RNDM_DWN = LEVEL_RNDM_NOT + 40;
	private static int LEVEL_RNDM_EQ = LEVEL_RNDM_DWN + 50;
	private static int LEVEL_RNDM_UP = LEVEL_RNDM_EQ + 2;
	
	
	public static int getLevelPx(int level){
		
		int px = 0;
		for (int i = 0; i <= level; i++) {
			px += i * LEVEL_PX;
		}
		
		return px;
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
	
	
}
