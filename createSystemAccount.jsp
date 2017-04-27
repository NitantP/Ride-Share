<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share -- Admin</title>
</head>
<body>

<br>
	<form method="post" action="newSystemAccount.jsp">
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
	</table>
	<input type="submit" value="Create">
	</form>
<br>

<br>
[<a href="adminIndex.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/createSystemAccount.jsp">GitHub Page</a>]

</body>
</html>