<%@page import="org.infinite.db.dao.AreaItem"%><%@page import="org.infinite.db.Manager"%><%@page import="org.infinite.util.GenericUtil"%><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%	int id = GenericUtil.toInt( request.getParameter("id"),-1 );
	AreaItem ai = (AreaItem) Manager.findById( AreaItem.class.getName(),id);%>
{
	"act":1,
	"id":"<%= ai.getId() %>",
	"name":"<%= ai.getName() %>",
	"icon":"<%= ai.getIcon() %>",
	"cost":<%= ai.getCost() %>,
	"areaid":<%= ai.getAreaid() %>,
	"areax":<%= ai.getAreax() %>,
	"areay":<%= ai.getAreay() %>,
	"x":<%= ai.getX() %>,
	"y":<%= ai.getY() %>,
	"arealock":"<%= ai.getArealock() %>",
	"questlock":"<%= ai.getQuestlock() %>",
	"url":"<%= ai.getUrl() %>",
	"loop":<%= ai.isDoublestep() %>,
	"hide":<%= ai.isHidemode() %>,
	"areaItemLevel":<%= ai.getAreaItemLevel() %>,
	"npcs":"<%= ai.getNpcs() %>"
}