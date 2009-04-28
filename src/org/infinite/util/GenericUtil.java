package org.infinite.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class GenericUtil {

	private static final Log log = LogFactory.getLog(GenericUtil.class);

	public static int rollDice(String szDiceType) throws Exception{

		szDiceType = szDiceType.toLowerCase().trim();
		
		if(szDiceType.indexOf("d")==0)
			return Integer.valueOf(szDiceType);
		
		int[] values = splitValues(szDiceType);

		return rollDice(values[0], values[1], values[2]);
	}
	
	
	public static int getMaxRollDice(String szDiceType){

		szDiceType = szDiceType.toLowerCase().trim();
		
		if(szDiceType.indexOf("d")==-1)
			return Integer.valueOf(szDiceType);
		
		int ret = 0;
		
		try {
			int[] values = splitValues(szDiceType);
			ret = (values[0] * values[1]) + values[2];
		} catch (Exception e) {
			err("getMaxRollDice DICE:"+szDiceType,e);
		}
		
		return ret;
	}
	
	
	public static int getMinRollDice(String szDiceType){

		szDiceType = szDiceType.toLowerCase().trim();
		
		if(szDiceType.indexOf("d")==-1)
			return Integer.valueOf(szDiceType);
		
		int ret = 0;
		
		try {
			int[] values = splitValues(szDiceType);
			ret = values[0]  + values[2];
		} catch (Exception e) {
			err("getMinRollDice DICE:"+szDiceType,e);
		}
		
		return ret;
	}
	


	private static int[] splitValues(String szDiceType) throws Exception {

		szDiceType = szDiceType.toLowerCase().trim();

		int times = 1;
		int dicemax = 1;
		int modifier = 0;

		String[] aszTmp = szDiceType.split("d");

		if(aszTmp.length!=2)
			throw new Exception("malformed dice rol definition:"+szDiceType);

		times = toInt(aszTmp[0], times);

		if(aszTmp[1].indexOf("+")!=-1){
			aszTmp = aszTmp[1].split("+");
			dicemax = toInt(aszTmp[0], dicemax);
			modifier = toInt(aszTmp[1], modifier);
		}
		else if(aszTmp[1].indexOf("-")!=-1){
			aszTmp = aszTmp[1].split("-");
			dicemax = toInt(aszTmp[0], dicemax);
			modifier = toInt(aszTmp[1], modifier);
		}
		else{
			dicemax = toInt(aszTmp[1], dicemax);
		}
		
		return new int[]{times, dicemax, modifier};
	}


	/*
	 * rolling 2d6-1 = rollDice(2 , 6 , -1)
	 */
	public static int rollDice(int times,int dicemax,int modifier){

		int result = 0;
		for (int i = 0; i < times; i++) {
			result += (int)(Math.ceil( Math.random()*(dicemax*1.0d) ));
		}
		result += modifier;

		return result;		
	}

	/**
	 * Sort array using quick sort
	 * @param toSort - array to be sorted
	 * @return - array with the indexes of the original positions
	 */
	public static int[] quickSort(int[] toSort){
		boolean swapped = false;
		int n= toSort.length;

		int[] ind = new int[toSort.length];
		for (int i = 0; i < ind.length; i++) {
			ind[i]=i;
		}


		do {
			swapped = false;
			n = n-1;
			for (int i = 0; i < n; i++) {
				if(toSort[i] > toSort[i+1]){
					int tmp = toSort[i+1];
					int tmp2 = ind[i+1];
					toSort[i+1] = toSort[i];
					ind[i+1] = ind[i];
					toSort[i] = tmp;
					ind[i] = tmp2;
					swapped = true;
				}
			}
		} while (swapped);	

		return ind;
	}

	public static int toInt(String value, int idefault){
		int out = 0;
		try{
			out = Integer.valueOf(value);
		}catch (NumberFormatException e) {
			out = idefault;
		}
		return out;
	}

	
	public static void err(String txt, Exception e){
		if(e==null)
			log.error(txt);
		else{
			log.error(txt, e);
		}
	}
	

	public static String array2String(String[] s,String sep, String quote){
		
		if(s.length==0)
			return "";
		
		StringBuilder sb = new StringBuilder("");
		for (int i = 0; i < s.length; i++) {
			sb.append(sep).append(quote).append(s[i]).append(quote);
		}
		return sb.toString().substring(sep.length());
	}

	public static void main(String[] args) {
		int[] i = new int[]{1,7,2,8,0,9,3};
		for (int j = 0; j < i.length; j++) {
			System.out.print(i[j]+",");
		}
		int[] ind = quickSort(i);
		System.out.println(" - ");

		for (int j = 0; j < i.length; j++) {
			System.out.print(i[j]+",");
		}
		System.out.println(" - ");

		for (int j = 0; j < i.length; j++) {
			System.out.print(ind[j]+",");
		}
	}
	
	
	
	
}
