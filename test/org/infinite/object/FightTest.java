package org.infinite.object;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Date;
import java.util.Vector;

import org.infinite.objects.Monster;
import org.infinite.util.GenericUtil;
import org.infinite.util.XmlUtil;
import org.infinte.engines.AI.AIEngine;
import org.infinte.engines.fight.FightEngine;
import org.junit.Test;

public class FightTest {

	@Test
	public void testFight() {

		Vector<Monster> side1  = new Vector<Monster>();
		Vector<Monster> side2  = new Vector<Monster>();

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
			String xml =  FightEngine.runFight(side1,side2);
			long t2 = (new Date()).getTime();
			System.out.println("time:"+(t2-t1));
			
			xml = XmlUtil.xml2String(xml, "fight");
			FileOutputStream fos = new FileOutputStream(new File("./out/fight.html"));
			fos.write(xml.getBytes());
			fos.flush();
			fos.close();
			System.out.println( "html written" );
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


	}

	@Test
	public void testSpawn() {


		try {

			for (int i = 0; i < 1000; i++) {
				GenericUtil.log("----------------------------------------"+i);
				Monster m1 = AIEngine.spawn("Hobgoblin");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

}
