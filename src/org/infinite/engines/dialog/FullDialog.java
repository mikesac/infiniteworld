package org.infinite.engines.dialog;

import java.io.IOException;
import java.util.HashMap;
import java.util.Properties;

public class FullDialog {


	private Properties p = new Properties();
	private HashMap<String , int[]> answers = new HashMap<String, int[]>();

	protected void storeProperties(String filename) throws IOException{
		p.load( FullDialog.class.getResourceAsStream(filename)  );
	}


	protected void storeAnswer(String sentenceKey,int[] answerIndexes){
		answers.put(sentenceKey, answerIndexes);
	}

	public String getSentenceString(int sentenceIndex){
		return p.getProperty(FullDialogEngine.S+sentenceIndex,"[Sentence not found!]");
	}

	public String[] getAnswersString(int sentenceIndex){

		int[] indexes = answers.get(FullDialogEngine.S+sentenceIndex);
		String[] out = new String[indexes.length];

		for (int i = 0; i < out.length; i++) {			
			out[i] = p.getProperty(FullDialogEngine.A+sentenceIndex+"."+indexes[i]);			
		}

		return out;
	}

	public int getAnswersRedirect(int sentenceIndex,int answerIndex){

		int[] indexes = answers.get(FullDialogEngine.S+sentenceIndex);
		return indexes[answerIndex];
	}




}
