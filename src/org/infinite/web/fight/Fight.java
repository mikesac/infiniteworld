package org.infinite.web.fight;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.engines.AI.AIEngine;
import org.infinite.engines.fight.FightEngine;
import org.infinite.engines.fight.FightRound;
import org.infinite.engines.fight.PlayerInterface;

public class Fight  extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {
		
		resp.setContentType("text/html");
		PrintWriter pw = resp.getWriter();
		
		String party2 = req.getParameter("party2");
		String party1 = req.getParameter("party1");
		
		if(party1==null){
			pw.write("Missing Party 1");
			return;
		}
		
		if(party2==null){
			pw.write("Missing Party 2");
			return;
		}
		
		ArrayList<PlayerInterface> side1  = new ArrayList<PlayerInterface>();
		ArrayList<PlayerInterface> side2  = new ArrayList<PlayerInterface>();

		String[] allParty = party1.split(",");
		for (int i = 0; i < allParty.length; i++) {
			try {
				side1.add( AIEngine.spawn(allParty[i]) );
			} catch (Exception e) {
				pw.write("ERROR:"+e.toString());
				return;
			}
		}
		
		allParty = party2.split(",");
		for (int i = 0; i < allParty.length; i++) {
			try {
				side2.add( AIEngine.spawn(allParty[i]) );
			} catch (Exception e) {
				pw.write("ERROR:"+e.toString());
				e.printStackTrace();
				return;
			}
		}
				

		try {
			
			ArrayList<FightRound> report =  FightEngine.runFight(side1,side2);			
			
			resp.setContentType("text/html");
			
		} catch (Exception e) {
			pw.write("ERROR:"+e.toString());
			e.printStackTrace();
			return;
		}


	
		
		
			
		
	}
	

}
