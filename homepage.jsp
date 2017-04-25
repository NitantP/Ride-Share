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

Welcome to Ride Share, <%= session.getAttribute("currentuser") %>! [<a href="index.jsp">Logout</a>]

<br>

<p><a href="testpage.jsp">test page (NOT PERMANENT, JUST TO SEE HOW SQL TABLES CAN BE DISPLAYED)</a></p>

<div align="center">
	[<a href="messageIndex.jsp">Messages</a>]  [<a href="userSettings.jsp">Settings</a>]
</div>

<div align="left">
	<p><a href="availableMatches.jsp">Available matches</a></p>
	----------------------------------------------------------
	<p><a href="createRideOffer.jsp">Create ride offer</a></p>
	<%
	try {
		//Create a connection string
		String url = "jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "cs336project", "csteam14");
				
		Statement stmt = con.createStatement();
		
		//Make a SELECT query from the users table with the username and password matches with the input
		String str = "SELECT * FROM rideoffers O ORDER BY O.offerID DESC";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
	%>		
		<table border="1">
		<tr>
		<td>Username</td>
		<td>Date</td>
		<td>Time</td>
		<td>Number of Spots Left</td>
		<td>Origin</td>
		<td>Destination</td>
		</tr>

		<%   
		while(result.next())
		{
		%>	
		<tr>
		<td><%=result.getString("Username") %></td>
		<td><%=result.getString("Date") %></td>
		<td><%=result.getString("Time") %></td>
		<td align="center"><%=result.getString("MaxPassengers") %></td>
		<td><%=result.getString("Origin") %></td>
		<td><%=result.getString("Destination") %></td>
		</tr>
		<%
		}
		%>
		</table>
	<%	
		result.close();
		stmt.close();
		con.close();
		
		}	catch (Exception ex) {
			out.print("System failure");	
		}
	%>
	--------------------------------------------------------------
	<p><a href="createRideRequest.jsp">Create ride request</a></p>
	<%
	try {
		//Create a connection string
		String url = "jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "cs336project", "csteam14");
				
		Statement stmt = con.createStatement();
		
		//Make a SELECT query from the users table with the username and password matches with the input
		String str = "SELECT * FROM riderequests R ORDER BY R.requestID DESC";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
	%>		
		<table border="1">
		<tr>
		<td>Username</td>
		<td>Date</td>
		<td>Time</td>
		<td>Number of Spots Desired</td>
		<td>Origin</td>
		<td>Destination</td>
		</tr>

		<%   
		while(result.next())
		{
		%>	
		<tr>
		<td><%=result.getString("Username") %></td>
		<td><%=result.getString("Date") %></td>
		<td><%=result.getString("Time") %></td>
		<td align="center"><%=result.getString("NumPassengers") %></td>
		<td><%=result.getString("Origin") %></td>
		<td><%=result.getString("Destination") %></td>
		</tr>
		<%
		}
		%>
		</table>
	<%	
		result.close();
		stmt.close();
		con.close();
		
		}	catch (Exception ex) {
			out.print("System failure");	
		}
	%>
</div>

<p><a href="https://github.com/NitantP/Ride-Share/blob/master/homepage.jsp">GitHub Page</a></p>

</body>