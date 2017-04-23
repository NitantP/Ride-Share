<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Send Message</title>
</head>
<body>

	<%
      if(request.getAttribute("messageStatus") != null){
   		 out.print(request.getAttribute("messageStatus"));  
      } 
    %> 

<br>
	<form method="post" action="newMessage.jsp">
	<table>
	<tr>    
	<td>To:</td><td><input type="text" name="recipient"></td>
<!--<%
      if(request.getAttribute("loginFailed") != null){
   		 out.print(request.getAttribute("loginFailed"));  
      } 
    %> -->
	</tr>
	<tr>
	<td>Subject:</td><td><input type="text" name="subject"></td>
	</tr>
	<tr>
	<td>Message (max. 100):</td><td><textarea rows="4" cols="30" name="content"></textarea></td>
	</tr>
	</table>
	<input type="submit" value="Send">
	</form>
<br>

</body>
</html>