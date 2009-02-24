<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div style="width: 150px">
<table width="100%">
	<tr>
		<td align="center" colspan="2"><img alt="No Character"
			src="<%=request.getContextPath()%>/imgs/web/pg_void.png"></td>
	</tr>
	<tr>
		<td align="center" colspan="2">No Name</td>
	</tr>
	<tr>
		<td align="center" colspan="2">No Level</td>
	</tr>
	<tr>
		<td align="center" colspan="2">
		<hr />
		</td>
	</tr>

	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/lp.png"
			alt="Life Points" title="Life Points"></td>
		<td>
		<div class="thp_big">
		<div class="chp_big" style="width: 100px;" />
		<div class="hpt_big">13 / 13</div>
		</div>
		</td>
	</tr>
	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/mp.png"
			alt="Magic Points" title="Magic Points"></td>
		<td>
		<div class="tmp_big">
		<div class="cmp_big" style="width: 100px;" />
		<div class="mpt_big">13 / 13</div>
		</div>
		</td>
	</tr>
	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/ap.png"
			alt="Action Points" title="Action Points"></td>
		<td>
		<div class="tap_big">
		<div class="cap_big" style="width: 100px;" />
		<div class="apt_big">13 / 13</div>
		</div>
		</td>
	</tr>
	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/cp.png"
			alt="Charm Points" title="Charm Points"></td>
		<td>
		<div class="tcp_big">
			<div class="ccp_big" style="width: 100px;" />
			<div class="cpt_big">13 / 13</div>
		</div>
		</td>
	</tr>

	<tr>
		<td align="center" colspan="2">
		<hr />
		</td>
	</tr>

	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/str.png"
			alt="Strenght" title="Strenght"></td>
		<td><input type="text" size="10" readonly="readonly" value="10"
			style="text-align: right;" /></td>
	</tr>

	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/int.png"
			alt="Intelligence" title="Intelligence"></td>
		<td><input type="text" size="10" readonly="readonly" value="10"
			style="text-align: right;" /></td>
	</tr>

	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/dex.png"
			alt="Dexterity" title="Dexterity"></td>
		<td><input type="text" size="10" readonly="readonly" value="10"
			style="text-align: right;" /></td>
	</tr>

	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/cha.png"
			alt="Charisma" title="Charisma"></td>
		<td><input type="text" size="10" readonly="readonly" value="10"
			style="text-align: right;" /></td>
	</tr>
	<tr>
		<td align="center" colspan="2">
		<hr />
		</td>
	</tr>

	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/ca.png"
			alt="Armor Class" title="Armor Class"></td>
		<td><input type="text" size="10" readonly="readonly" value="10"
			style="text-align: right;" /></td>
	</tr>
	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/px.png"
			alt="Experience" title="Experience"></td>
		<td><input type="text" size="10" readonly="readonly" value="0"
			style="text-align: right;" /></td>
	</tr>
	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/gp.png"
			alt="Gold" title="Gold"></td>
		<td><input type="text" size="10" readonly="readonly" value="10"
			style="text-align: right;" /></td>
	</tr>

</table>
</div>
</body>
</html>