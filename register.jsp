<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share</title>
</head>
<body>

Ride Share (TEAM 14) 
<br>
									  
<br>
	<form method="post" action="newUser.jsp">
	<table>
	<tr>    
	<td>Username:</td><td><input type="text" name="username">
	<%
      if(request.getAttribute("userFailed") != null){
   		 out.print(request.getAttribute("userFailed"));  
      } 
    %>
	</td>
	</tr>
	<tr>
	<td>Password:</td><td><input type="password" name="password">
	<%
      if(request.getAttribute("passFailed") != null){
   		 out.print(request.getAttribute("passFailed"));  
      } 
    %>
	</td>
	</tr>
	<tr>
	<td>E-mail:</td><td><input type="text" name="email">
	<%
      if(request.getAttribute("emailFailed") != null){
   		 out.print(request.getAttribute("emailFailed"));  
      } 
    %>
	</td>
	</tr>
	<tr>
	<td>RUID:</td><td><input type="text" name="ruid">
	<%
      if(request.getAttribute("RUIDFailed") != null){
   		 out.print(request.getAttribute("RUIDFailed"));  
      } 
    %>
	</td>
	</tr>
	</table>
	<input type="submit" value="Register">
	</form>
<br>


</body>
</html>