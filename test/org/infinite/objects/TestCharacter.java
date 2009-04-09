package org.infinite.objects;

import static org.junit.Assert.*;

import java.util.ArrayList;

import org.infinite.db.dao.PlayerKnowSpell;
import org.infinite.db.dao.PlayerOwnItem;
import org.junit.Test;


public class TestCharacter {

	private Character c=null;
	
	
	public TestCharacter() throws Exception {
		testChar();
	}
	
	@Test
	public void testChar() throws Exception{
		
		c = new Character("testChar","mike");		
		assertNotNull(c);
	}
	
	
	@Test
	public void testBattlePlanSerialization() throws Exception{
	
		String input = "A7,S1,s1,s1";
		
		//test Deserialize
		ArrayList<Object> deserializeBattlePlan = c.deserializeBattlePlan(input);
		
		assertEquals(input.split(",").length , deserializeBattlePlan.size());
		assertNotNull(deserializeBattlePlan.get(0));
		assertNotNull(deserializeBattlePlan.get(1));
		assertTrue(7==((PlayerOwnItem)deserializeBattlePlan.get(0)).getId() );
		assertTrue(1 == ((PlayerKnowSpell)deserializeBattlePlan.get(1)).getId() );
		
		//test Serialize
		String out = c.serializeBattlePlan( deserializeBattlePlan );
		assertTrue(input.equalsIgnoreCase(out) );
		
		//testRemoveSerialize
		c.setBattlePlan( deserializeBattlePlan );
		c.changeFromBattlePlan("A5","A5");
		
		out = c.serializeBattlePlan( c.getBattlePlan() );
		assertTrue(out.equalsIgnoreCase("S1,s1,s1") );
		
		
	}
	
}
