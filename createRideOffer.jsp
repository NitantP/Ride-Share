<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Create Ride Offers</title>
</head>
<body>

Ride Share (TEAM 14) 
<br>
									  
<br>
	<form method="post" action="newRideOffer.jsp">
	<table>
	<tr>    
	<td>From:</td><td><input type="text" name="startinglocation">
	</td>
	</tr>
	<tr>
	<td>To:</td><td><input type="text" name="destination">
	</td>
	</tr>
	<tr>
	<td>Date:</td><td><input type="text" name="date">
	</td>
	</tr>
	<tr>
	<td>Time:</td><td><input type="text" name="time">
	</td>
	</tr>
	<tr>
	<td>Max Number of Passengers:</td><td><input type="text" name="maxpassengers">
	</td>
	</tr>
	<tr>
	<td>Recurring? </td><td><input type="checkbox" name="recurring" value="true">
	</td>
	</tr>
	</table>
	<input type="submit" value="Submit Request">
	</form>
<br>

<p><a href="homepage.jsp">Back to main page</a></p>

</body>
</html>