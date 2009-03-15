<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Infinite World Test Server</title>
</head>
<body>


<center>
<table cellpadding="0" cellspacing="0" border="0" style="width: 350px">
	<tr>
		<td id="side-nw"></td>
		<td id="side-n"></td>
		<td id="side-ne"></td>
	</tr>
	<tr>
		<td id="side-w"></td>
		<td id="side" valign="middle">
		<center>
		<form name="register" method="post" action="<%=request.getContextPath()%>/register">
		<table>
			<tr>
				<td colspan="2" align="center" ><img class="round"
					align="center" src="<%=request.getContextPath()%>/imgs/web/infinite.png">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">Please provide your data
				</td>
			</tr>
			
			<tr>
				<td colspan="2" align="center">
				<%
					if(request.getAttribute("error")!=null){
						out.println("<div class='error'>");
						out.println( request.getAttribute("error") );
						out.println("</div>");
						}
				%>
				</td>
			</tr>
			
			<tr>
				<td>Username</td>
				<td><input type="text" name="username" /></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" name="password" /></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input type="text" name="email" /></td>
			</tr>
			
			<tr>
				<td colspan="2" align="center" ><img src="<%=request.getContextPath()%>/jcaptcha"></td>
			</tr>
			<tr>
				<td>Captcha	</td>
				<td><input type='text' name='j_captcha_response' value=''></td>
			</tr>
		</table>
		<input type="submit" />
		</form>
		</center>
		</td>
	<td id="side-e"></td>
	</tr>
	<tr>
		<td id="side-sw"></td>
		<td id="side-s"></td>
		<td id="side-se"></td>
	</tr>
</table>


</center>



</body>
</html>