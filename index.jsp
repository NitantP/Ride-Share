<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to Ride Share</title>
</head>
<body>

Welcome to the Ride Share website (TEAM 14)

<br>
<br>
	<form method="post" action="verifyUser.jsp">
	<table>
	<tr>    
	<td>Username:</td><td><input type="text" name="username">  
    </td>
	</tr>
	<tr>
	<td>Password:</td><td><input type="password" name="password"></td>
	</tr>
	</table>
	<input type="submit" value="Login">
	<%
		if(request.getAttribute("loginFailed") != null){
			out.print(request.getAttribute("loginFailed"));  
		}
		if(request.getAttribute("banned") != null){
			out.print(request.getAttribute("banned"));  
		}
    %>
	</form>
	<br>
	<form method="post" action="register.jsp"><input type="submit" value="Register"></form>
	<form method="post" action="forgot.jsp"><input type="submit" value="Reset Password"></form>
<br>

[<a href="https://github.com/NitantP/Ride-Share">GitHub Repository</a>]
</body>
</html>