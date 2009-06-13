package org.infinite.engines.fight;

import java.util.ArrayList;

import org.infinite.db.dao.Item;
import org.infinite.util.InfiniteCst;

public class FightRound {

	private int numround;
	private boolean firstSide = false;
	private String attacker ="";
	private String attackName ="";
	private String attackImg ="";
	private int attackType;
	private String defender ="";
	
	private int attackRoll;
	private int defenderCA;
	private int attackDmg;
	private int remainHp;
	private boolean hit = false;
	private int roundType= InfiniteCst.ATTACK_TYPE_IDLE;

	private boolean isEndRound = false;
	private boolean isSpellEffect = false;
	private long px;
	private float gold;
	private ArrayList<Item> items = new ArrayList<Item>();
	
	
	public FightRound(int round) {
		setNumround(round);
	}
	
	public String getAttacker() {
		return attacker;
	}
	public void setAttacker(String attacker) {
		this.attacker = attacker;
	}
	public String getAttackName() {
		return attackName;
	}
	public void setAttackName(String attackName) {
		this.attackName = attackName;
	}
	public String getDefender() {
		return defender;
	}
	public void setDefender(String defender) {
		this.defender = defender;
	}
	public boolean isEndRound() {
		return isEndRound;
	}
	public void setEndRound(boolean isEndRound) {
		this.isEndRound = isEndRound;
	}
	public long getPx() {
		return px;
	}
	public void setPx(long px) {
		this.px = px;
	}
	public float getGold() {
		return gold;
	}
	public void setGold(float f) {
		this.gold = f;
	}
	public ArrayList<Item> getItems() {
		return items;
	}
	
	public void addItems(ArrayList<Item> items) {
		
		if(items!=null){
			for (int i = 0; i < items.size(); i++) {
				this.items.add( items.get(i) );
			}
		}
	}

	public void setNumround(int numround) {
		this.numround = numround;
	}

	public int getNumround() {
		return numround;
	}

	public void setFirstSide(boolean firstSide) {
		this.firstSide = firstSide;
	}

	public boolean isFirstSide() {
		return firstSide;
	}


	public void setAttackImg(String attackImg) {
		this.attackImg = attackImg;
	}

	public String getAttackImg() {
		return attackImg;
	}

	public int getAttackRoll() {
		return attackRoll;
	}

	public void setAttackRoll(int attackRoll) {
		this.attackRoll = attackRoll;
	}

	public int getDefenderCA() {
		return defenderCA;
	}

	public void setDefenderCA(int defenderCA) {
		this.defenderCA = defenderCA;
	}

	public int getAttackDmg() {
		return attackDmg;
	}

	public void setAttackDmg(int attackDmg) {
		this.attackDmg = attackDmg;
	}

	public int getRemainHp() {
		return remainHp;
	}

	public void setRemainHp(int remainHp) {
		this.remainHp = remainHp;
	}

	public boolean isHit() {
		return hit;
	}

	public void setHit(boolean hit) {
		this.hit = hit;
	}

	public void setAttackType(int type) {
		this.attackType = type;
	}

	public int getAttackType() {
		return attackType;
	}

	public void setRoundType(int roundType) {
		this.roundType = roundType;
	}

	public int getRoundType() {
		return roundType;
	}

	public void setSpellEffect(boolean isSpellEffect) {
		this.isSpellEffect = isSpellEffect;
	}

	public boolean isSpellEffect() {
		return isSpellEffect;
	}
	
	
	
	
}
