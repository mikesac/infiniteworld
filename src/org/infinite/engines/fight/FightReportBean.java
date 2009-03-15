package org.infinite.engines.fight;

import java.util.Vector;

import org.infinite.objects.FightInterface;

public class FightReportBean {

	private Vector<FightInterface> firstSide;
	private Vector<FightInterface> secondSide;
	
	private Vector<Round> rounds;
	
	
	public void setRounds(Round rounds) {
		this.rounds.add(rounds);
	}

	public void setFirstSide(Vector<FightInterface> firstSide) {
		this.firstSide = firstSide;
	}

	public Vector<FightInterface> getFirstSide() {
		return firstSide;
	}

	public void setSecondSide(Vector<FightInterface> secondSide) {
		this.secondSide = secondSide;
	}

	public Vector<FightInterface> getSecondSide() {
		return secondSide;
	}

	public void setRounds(Vector<Round> rounds) {
		this.rounds = rounds;
	}

	public Vector<Round> getRounds() {
		return rounds;
	}
	
}
	class Round{
		
		private int numRound;
		Vector<Attack> atks;
		
		public void addAttk(String attacker,String defender,String name,String typeName,String img,int ca, int roll,int hit,int type){
			atks.add(new Attack(attacker,defender,name,typeName,img,ca, roll,hit,type));
		}

		public void setNumRound(int numRound) {
			this.numRound = numRound;
		}

		public int getNumRound() {
			return numRound;
		}
		
	}
	
	class Attack{
		
		String attacker,defender,name,typeName,img;
		int ca, roll,hit,type;
		
		
		public Attack(String attacker,String defender, String name,String typeName,String img,int ca, int roll,int hit,int type) {
			setAttacker(attacker);
			setDefender(defender);
			setName(name);
			setTypeName(typeName);
			setImg(img);
			setCa(ca);
			setRoll(roll);
			setHit(hit);
			setType(type);
		}
		
		
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getTypeName() {
			return typeName;
		}
		public void setTypeName(String typeName) {
			this.typeName = typeName;
		}
		public String getImg() {
			return img;
		}
		public void setImg(String img) {
			this.img = img;
		}
		public int getCa() {
			return ca;
		}
		public void setCa(int ca) {
			this.ca = ca;
		}
		public int getRoll() {
			return roll;
		}
		public void setRoll(int roll) {
			this.roll = roll;
		}
		public int getHit() {
			return hit;
		}
		public void setHit(int hit) {
			this.hit = hit;
		}
		public int getType() {
			return type;
		}
		public void setType(int type) {
			this.type = type;
		}


		public String getAttacker() {
			return attacker;
		}


		public void setAttacker(String attacker) {
			this.attacker = attacker;
		}


		public String getDefender() {
			return defender;
		}


		public void setDefender(String defender) {
			this.defender = defender;
		}
		
	}
	



