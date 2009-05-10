package org.infinite.engines.AI;

import org.junit.Test;

public class newAIEngineTest {

	@Test
	public void testGetLevelPx() {
		
		for (int i = 0; i < 50; i++) {
			System.out.println(i + " - "+ newAIEngine.getLevelPx(i));
		}
	}

	@Test
	public void testGetMatchingLevel() {
		
		int level = 15;
		System.out.println(level + " vs ");
		for (int i = 0; i < 1000; i++) {
			int out = newAIEngine.getMatchingLevel(level);
			System.out.println(out + " " + ((out!=0)?Math.round(level/out):0) );
		}
		
		System.out.print("END");
		
		
	}

}
