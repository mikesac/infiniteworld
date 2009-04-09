package org.infinite.objects;

import static org.junit.Assert.*;

import org.infinite.objects.Monster;
import org.junit.Test;

public class MonsterTest {

	@Test
	public void testMonster() {
		
		Monster m = new Monster("TestMonster");
		assertNotNull("Monster is null", m);
			
		System.out.println("m.getArmorCA()"+m.getArmorCA());
		System.out.println("m.getBaseCA()"+m.getBaseCA());
		System.out.println("m.getInitiative()"+m.getInitiative());
		System.out.println("m.getShieldCA()"+m.getShieldCA());
		System.out.println("m.getTotalCA()"+m.getTotalCA());
		
		
		m = new Monster("FightingMonster");
		assertNotNull("FightingMonster is null", m);
			
		System.out.println("f.getArmorCA()"+m.getArmorCA());
		System.out.println("f.getBaseCA()"+m.getBaseCA());
		System.out.println("f.getInitiative()"+m.getInitiative());
		System.out.println("f.getShieldCA()"+m.getShieldCA());
		System.out.println("f.getTotalCA()"+m.getTotalCA());
		
	}

}
