package org.infinite.engines.dialog;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.io.IOException;

import junit.framework.Assert;

import org.junit.Test;


public class FullDialogEngineTest {
	
	@Test
	public void getDialogDataTest() {
		
	
		FullDialog fd = null;
		try {
			fd = FullDialogEngine.getDialogData("dialog.properties");
		} catch (IOException e) {
			Assert.fail(e.getMessage());
		}
		assertNotNull(fd);
		
		assertEquals("getNpcSentence","Welcome stranger, how are you?",fd.getSentenceString(0));
		assertEquals("getPcAnswers size",3,fd.getAnswersString(0).length);
		assertEquals("getPcAnswers txt","Not your bussines see ya!",fd.getAnswersString(0)[2]);
		assertEquals("getPcAnswers goto",3,fd.getAnswersRedirect(0, 2) );
		
		assertEquals("getNpcSentence","Rumors? Nope, this is a really quiet town!",fd.getSentenceString(2));
		assertEquals("getPcAnswers",1,fd.getAnswersString(2).length);
		assertEquals("getPcAnswers","Never mind, see you",fd.getAnswersString(2)[0]);
		assertEquals("getPcAnswers goto",3,fd.getAnswersRedirect(2, 0) );
	}
	
	
}
