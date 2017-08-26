<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reset Password</title>
</head>
<body>

<!-- Page to ask for password reset (forgot password) -->

	<form method="post" action="forgotController.jsp">
	<table>
	<tr>
	<td>Enter Username:</td><td><input type="text" name="user"></td>
	<%
      if(request.getAttribute("userFailed") != null){
   		 out.print(request.getAttribute("userFailed"));  
      } 
    %>
	</tr>
	</table>
	<input type="submit" value="Submit">
	</form>

<br>
<br>
[<a href="userSettings.jsp">User settings</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/newUserSettings.jsp">GitHub Page</a>] 
	
</body>
</html>
	