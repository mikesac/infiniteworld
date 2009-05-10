package org.infinite.engines.dialog;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Iterator;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

import org.infinite.util.GenericUtil;
import org.infinite.web.PagesCst;

public class FullDialogEngine {

	protected static final String S = "sentence.";
	protected static final String A = "answer.";

	public static FullDialog getDialogData(String filename) throws IOException {
		return getDialogData( FullDialogEngine.class.getResourceAsStream(filename));
	}

	public static FullDialog getDialogData(InputStream is) throws IOException {

		FullDialog fd = new FullDialog();
		
		is.mark(is.available());
		fd.storeProperties(is);
		is.reset();
		
		BufferedReader br = new BufferedReader( new InputStreamReader( is ));

		String sentence = "";
		String sentenceKey = "";
		ArrayList<Integer> answersGoto = new ArrayList<Integer>();
		boolean firstloop=true;
		try {
			//Read File Line By Line
			while ((sentence = br.readLine()) != null)   {

				if(sentence.startsWith("#") || sentence.length()==0)
					continue;				

				if(sentence.toLowerCase().startsWith(S))
				{					
					if(firstloop){
						firstloop = false;
					}
					else{
						storeAnswers(fd,sentenceKey, answersGoto);
					}
					sentenceKey = sentence;
					answersGoto.clear();	

				}
				else{
					answersGoto.add( getAnswerGoto(sentence));

				}
			}

			br.close();
		} catch (IOException e) {
			GenericUtil.err(FullDialogEngine.class.getName(), e);
		}
		storeAnswers(fd,sentenceKey, answersGoto);

		return fd;





	}

	private static void storeAnswers(FullDialog fd , String sentenceKey, ArrayList<Integer> answersGoto) {
		int[] gotovalues = new int[answersGoto.size()];
		int i=0;
		for (Iterator<Integer> iterator = answersGoto.iterator(); iterator.hasNext();) {
			gotovalues[i++] = iterator.next();							
		}
		fd.storeAnswer( getPropertyName(sentenceKey), gotovalues);
	}



	private static String getPropertyName(String line){

		String out = line;

		if(out.indexOf("=")!=-1)	
			out = out.substring(0, out.indexOf("="));

		return out;
	}


	private static int getAnswerGoto(String line){

		String out = line;

		if(out.indexOf("=")!=-1)	
			out = out.substring(0, out.indexOf("="));

		out = out.substring( out.lastIndexOf(".")+1);

		return GenericUtil.toInt(out, 0);
	}

	protected static String parsePagesCST(String myinput){

		if( myinput.startsWith(PagesCst.class.getName()) ){

			ScriptEngine js = new ScriptEngineManager().getEngineByName("javascript");

			js.put("myinputjs", myinput);

			try {
				myinput = (String) js.eval("eval(myinputjs);"
				);
			} catch (ScriptException e) {
				GenericUtil.err("Rinho error:", e);
			}

		}
		return myinput;
	}


}
