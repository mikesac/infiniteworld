<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.util.GenericUtil"%>
<%@page import="org.infinite.objects.Monster"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>Fight Testbed</title>
</head>
<body>
<h3>Fight Testbed</h3>

<table>
	<tr>
		<td valign="top">


		<table>
			<tr>
				<th><select id="monsters" name="monsters"></select>
				<button onclick="openSheet()">Show Monster Sheet</button>
				</th>
				<th>
				<button onclick="addMonster(1)">Add to First Party</button>
				<button onclick="addMonster(2)">Add to Second Party</button>
				</th>
			</tr>
			<tr>
				<th>Party 1</th>
				<th>Party 2</th>
			</tr>
			<tr>
				<td id="p1" class="round">&nbsp;</td>
				<td id="p2" class="round">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<button onclick="fight()">Fight!</button>
				<button onclick="init()">Reset</button>
				</td>
			</tr>
		</table>

		</td>
		<td>
		<iframe name="sheet" style="border:0px;" height="600" width="800" src=""></iframe>
		</td>
	</tr>
</table>
<form>
<input type="hidden" name="party1" />
<input type="hidden" name="party2" />
</form>

<script>
var monsterOption = [ <%=GenericUtil.array2String(Monster.getMonsterListing(),",", "\"")%> ];

for(var i =0;i<monsterOption.length;i++){
	var op = document.createElement("option");
	op.value=monsterOption[i];
	op.innerHTML = monsterOption[i];
	document.getElementById("monsters").appendChild(op);
}
init();

function init(){
document.forms[0].elements["party1"].value="";
document.forms[0].elements["party2"].value="";
document.getElementById("p1").innerHTML = "&nbsp;";
document.getElementById("p2").innerHTML = "&nbsp;";
}

function addMonster(id){
	
	if(document.forms[0].elements["party"+id].value.length==0){
		document.forms[0].elements["party"+id].value += document.getElementById("monsters").value;
	}
	else{
		document.forms[0].elements["party"+id].value += ","+document.getElementById("monsters").value;
	}
	document.getElementById("p"+id).innerHTML += "<div><center><img src='<%=request.getContextPath()%>/imgs/monster/"+document.getElementById("monsters").value.toLowerCase() + ".png' title='"+document.getElementById("monsters").value + "'/><br/>"+document.getElementById("monsters").value + "</center></div>";
	
}

function openSheet(){
	window.frames[0].location="<%=request.getContextPath()%>/monsterXML?m="+document.getElementById("monsters").value;
}

function fight(){

	if( document.forms[0].elements["party1"].value=="" || document.forms[0].elements["party2"].value==""){
		alert("Populate both party!");
		return;
	}
	
	var url = "<%=request.getContextPath()%>/fight?party1="+document.forms[0].elements["party1"].value+"&party2="+document.forms[0].elements["party2"].value;
	document.location=url;

}

</script>
</body>
</html>



