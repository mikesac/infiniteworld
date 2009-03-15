package org.infinite.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.engines.AI.AIEngine;
import org.infinite.objects.Monster;
import org.infinite.util.XmlUtil;

import com.thoughtworks.xstream.XStream;

public class MonsterXML  extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {
		resp.setContentType("text/html");
		PrintWriter pw = resp.getWriter();
		
		String monsterName = req.getParameter("m");
		if(monsterName==null){
			pw.write("Missing Moster Name");
			return;
		}
		
		Monster m = null;
		try {
			m = AIEngine.spawn(monsterName );
		} catch (Exception e) {
			pw.write("ERROR:"+e.toString());
			e.printStackTrace();
			return;
		}
					
		XStream xstream = new XStream();
		xstream.alias("monster", m.getDao().getClass() );
		xstream.omitField(m.getDao().getClass(), "id");
		xstream.omitField(m.getDao().getClass(), "area");
		xstream.omitField(m.getDao().getClass(), "npcOwnItems");
		String xml = xstream.toXML(m.getDao()) ;

		try {
			xml = XmlUtil.xml2String(xml, "monster/monster");
		} catch (Exception e) {
			pw.write(e.toString());
			e.printStackTrace();
		}
		pw.write( xml );
		
		
	}
	

}
