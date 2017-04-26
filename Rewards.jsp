<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rewards</title>
</head>
<body>
Rewards
		<%
		try 
		{
			//Create a connection string
			String url = "jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "cs336project", "csteam14");
					
			Statement stmt = con.createStatement();
			String str = "SELECT * FROM userlist WHERE Username = \"" + (String)session.getAttribute("currentuser") + "\"";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			%>
			<FORM method = "POST" >
			<table border="1">
			<tr>
			<td>Username</td>
			<td>Rewards</td>
			<td>RidesGiven</td>
			<td>RidesTaken</td>
			</tr>
		  <%
			if(result.next())
			{
					%>
					<tr>
					<td><%=result.getString("Username")%></td>
					<td>$<%=result.getString("Rewards")%></td>
					<td><%=result.getString("RidesGiven")%></td>
					<td><%=result.getString("RidesTaken")%></td>
					</tr>
					<%
			}
			%>
			</table>
			<br>

			</FORM>
			<%
		}
		catch (Exception ex) 
		{
			out.print("System failure");	
		}
			%>
</body>
</html>