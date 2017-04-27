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
	</tr>
	<tr>
	<td>Subject:</td><td><input type="text" name="subject"></td>
	</tr>
	<tr>
	<td>Time:</td><td><input type="text" name="time"></td>
	<% if (request.getAttribute("time") != null)
	{
		out.print(request.getAttribute("time"));
	}%>
	</tr>
	<tr>
	<td>Date:</td><td><input type="text" name="date"></td>
	<%
      if(request.getAttribute("date") != null){
   		 out.print(request.getAttribute("date"));  
      } 
    %>
	</tr>
	<tr>
	<td>Message (max. 100):</td><td><textarea rows="4" cols="25" name="content"></textarea></td>
	</tr>
	</table>
	<input type="submit" value="Send">
	</form>
<br>

<br>

[<a href="messageIndex.jsp">Messages</a>] [<a href="homepage.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/createMessage.jsp">GitHub Page</a>]

</body>
</html>