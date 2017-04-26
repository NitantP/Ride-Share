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

<%	
		try {
		//Create a connection string
		String url = "jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "cs336project", "csteam14");
				
		Statement stmt = con.createStatement();
		
		String currentun = (String)session.getAttribute("currentuser");
		
		//Make a SELECT query from the users table with the username and password matches with the input
		String str = "SELECT * FROM rideoffers O WHERE O.Username = \"" + currentun + "\"";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
%>
		<form method = "POST" ACTION = "availableMatches.jsp">
		<table border="1">
		<b>Matches to Your Ride Offers</b>
		<tr>
		<td>See Matches For</td>
		<td>Offer ID</td>
		<td>Date</td>
		<td>Time</td>
		<td>Number of Passengers</td>
		<td>Origin</td>
		<td>Destination</td>
		</tr>

<%      
		while(result.next())
		{
		%>
		<tr>
		<td align="center"><input type="radio" name="offer" value=<%=result.getInt("O.offerID")%>></td>
		<td align="center"><%=result.getInt("O.offerID") %></td>
		<td><%=result.getString("O.Date") %></td>
		<td><%=result.getString("O.Time") %></td>
		<td align="center"><%=result.getString("O.MaxPassengers") %></td>
		<td><%=result.getString("O.Origin") %></td>
		<td><%=result.getString("O.Destination") %></td>
		
		</tr>
		
		<%

		}
		%>
		</table>
		<br>
		<input type=submit name=submit value="See Matches">

</FORM>
<br>
<br>
		<form method = "POST" ACTION = "availableInvites.jsp">
		<b>Invites to Your Ride Requests</b>
		<table border="1">
		<tr>
		<td>See Invites For</td>
		<td>Request ID</td>
		<td>Date</td>
		<td>Time</td>
		<td>Number of Passengers</td>
		<td>Origin</td>
		<td>Destination</td>
		</tr>

<%      
		str = "SELECT * FROM riderequests R WHERE R.Username = \"" + currentun + "\" AND R.requestID NOT IN (SELECT requestID FROM acceptedRides)";
		result = stmt.executeQuery(str);
		while(result.next())
		{
		%>
		<tr>
		<td align="center"><input type="radio" name="invited" value=<%=result.getInt("R.requestID")%>></td>
		<td align="center"><%=result.getInt("R.requestID") %></td>
		<td><%=result.getString("R.Date") %></td>
		<td><%=result.getString("R.Time") %></td>
		<td align="center"><%=result.getString("R.NumPassengers") %></td>
		<td><%=result.getString("R.Origin") %></td>
		<td><%=result.getString("R.Destination") %></td>
		
		</tr>
		
		<%

		}
		%>
		</table>
		<br>
		<input type=submit name=submit value="See Matches">

</FORM>
	<%
		
		result.close();
		stmt.close();
		con.close();
		
		}	catch (Exception ex) {
			ex.printStackTrace();
			out.print("System failure");	
		}
%>

<br>
<br>
[<a href="homepage.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/availableMatchesIntermediate.jsp">GitHub Page</a>] [<a href="index.jsp">Logout</a>] 
</body>
</html>