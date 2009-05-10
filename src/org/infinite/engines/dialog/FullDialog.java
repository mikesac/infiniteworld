package org.infinite.engines.dialog;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Properties;

public class FullDialog {


	private Properties p = new Properties();
	private HashMap<String , int[]> answers = new HashMap<String, int[]>();

	protected void storeProperties(String filename) throws IOException{
		p.load( FullDialog.class.getClassLoader().getResourceAsStream(filename)  );		
	}
	
	protected void storeProperties(InputStream is) throws IOException{
		p.load( is  );		
	}


	protected void storeAnswer(String sentenceKey,int[] answerIndexes){
		answers.put(sentenceKey, answerIndexes);
	}

	public String getSentenceString(int sentenceIndex){
		
		String out = p.getProperty(FullDialogEngine.S+sentenceIndex,"[Sentence not found!]");
		out = FullDialogEngine.parsePagesCST(out);
		return out;
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
	
	public boolean isUrl(String sentence){
		return sentence.startsWith("/");			
	}


	

}
