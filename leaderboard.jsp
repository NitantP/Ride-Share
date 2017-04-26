<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Leaderboard</title>
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
		String str = "SELECT RidesGiven, RidesTaken, Rating FROM userlist WHERE AccountType = 'User' AND Username = \"" + currentun + "\"";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
%>
<div align="center">
		<b>My statistics:</b>
		<br>
		<table border="1">
		<tr>
		<td>Rides Given</td>
		<td>Rides Taken</td>
		<td>Rating</td>
		</tr>
<%		
		while(result.next())
		{

		%>
		<tr>
		<td align="center"><%=result.getString("RidesGiven") %></td>
		<td align="center"><%=result.getInt("RidesTaken") %></td>
		<td><%=result.getDouble("Rating") %></td>
		</tr>

		<%

		}
		%>
		</table>
</div>

<%		//Make a SELECT query from the users table with the username and password matches with the input
		str = "SELECT Username, RidesGiven, Rating FROM userlist WHERE AccountType = 'User' ORDER BY RidesGiven DESC";
		//Run the query against the database.
	 	result = stmt.executeQuery(str);
%>
<div align="center">
		<br>
		<b>LEADERBOARD (TOP 10)</b>
		<table border="1">
		<tr>
		<td>Username</td>
		<td>Rides Given</td>
		<td>Rating</td>
		</tr>
<%		
		int shown = 0;
		while(result.next())
		{
			if(shown > 9){
				break;
			}
		%>
		<tr>
		<td><%=result.getString("Username") %></td>
		<td align="center"><%=result.getInt("RidesGiven") %></td>
		<td><%=result.getDouble("Rating") %></td>
		</tr>
		<%
		shown++;
		}
		%>
		</table>
</div>
		<%
		
		result.close();
		stmt.close();
		con.close();
		
		}	catch (Exception ex) {
			out.print("System failure");	
		}
%>

<br>
<br>

[<a href="homepage.jsp">Main page</a>] [<a href="homepage.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/leaderboard.jsp">GitHub Page</a>] [<a href="index.jsp">Logout</a>] 

</body>
</html>