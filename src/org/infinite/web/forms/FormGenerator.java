package org.infinite.web.forms;

import org.infinite.db.dao.Item;
import org.infinite.db.dao.Spell;
import org.infinite.util.XmlUtil;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

public class FormGenerator {

	
	
	public static void main(String[] args) {
		
		try {
			generateItemForm();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	public static void generateItemForm() throws Exception{
		
		XStream xstream = new XStream(new DomDriver());
		String xml = xstream.toXML(new Spell());
		
		System.out.println(xml);
		
		xml = XmlUtil.xml2String(xml, "forms/item");
		
		
	}
	
}
