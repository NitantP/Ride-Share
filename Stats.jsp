<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Available Matches</title>
</head>
<body>


<FORM method = "POST" ACTION ="StatesDisplay.jsp">
		<table border="1">
		<tr>
		<td>Username<input type=text name=user></td>
		</tr>
		<tr>
		<td>Date<input type=text name=date></td>
		</tr>
		<tr>
		<td>Time<input type=text name=time></td>
		</tr>
		<tr>
		<td>Origin<input type=text name=origin></td>
		</tr>
		<tr>
		<td>Destination<input type=text name=destination></td>
		</tr>
		</table>
		<br>
		<input type=submit name=submit value="See Stats">

</FORM>


<br>
<br>
[<a href="availableMatchesIntermediate.jsp">Back</a>] [<a href="homepage.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/availableMatches.jsp">GitHub Page</a>] [<a href="index.jsp">Logout</a>] 

</body>
</html>