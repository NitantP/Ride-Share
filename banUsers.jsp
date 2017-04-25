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
		String str = "SELECT * FROM userlist u WHERE Reported > 5";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
%>

<FORM method = "POST" ACTION = "ban.jsp">
		<table border="1">
		<tr>
		<td>Check</td>
		<td>Username</td>
		<td>Reported</td>
		</tr>

<%		
		while(result.next())
		{

		%>
		<tr>
		<td><input type=checkbox name=invited VALUE = <%=result.getString("Username")%>></td>
		<td><%=result.getString("Username") %></td>
		<td><%=result.getString("Reported") %></td>
		</tr>

		<%

		}
		%>
		</table>
		<input type=submit name=submit value="Reset Passwords">
</FORM>
		
	<%
		
		result.close();
		stmt.close();
		con.close();
		
		}	catch (Exception ex) {
			out.print("System failure");	
		}
%>
<p><a href="systemIndex.jsp">Return to System Support page</a></p>