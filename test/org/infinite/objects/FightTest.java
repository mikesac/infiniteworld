package org.infinite.objects;

import static org.junit.Assert.assertNotNull;

import java.util.ArrayList;
import java.util.Date;

import org.infinite.engines.AI.AIEngine;
import org.infinite.engines.fight.FightEngine;
import org.infinite.engines.fight.FightRound;
import org.infinite.engines.fight.PlayerInterface;
import org.junit.Test;

public class FightTest {

	@Test
	public void testFight() {

		ArrayList<PlayerInterface> side1  = new ArrayList<PlayerInterface>();
		ArrayList<PlayerInterface> side2  = new ArrayList<PlayerInterface>();

		try {
			
			side1.add( AIEngine.spawn("Hobgoblin") );
			side1.add( AIEngine.spawn("Hobgoblin") );

			side2.add( AIEngine.spawn("Goblin") );
			side2.add( AIEngine.spawn("Goblin") );

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			long t1 = (new Date()).getTime();
			ArrayList<FightRound> report =  FightEngine.runFight(side1,side2);
			assertNotNull(report);
			long t2 = (new Date()).getTime();
			System.out.println("time:"+(t2-t1));
			
			
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


	}

	@Test
	public void testSpawn() {


		try {
			System.out.print("Fight stress test:");
			for (int i = 0; i < 100; i++) {
				System.out.print(".");
				Monster m = AIEngine.spawn("Hobgoblin");
				assertNotNull(m);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

}
