<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.DecimalFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Comments</title>
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
		
		//Make a SELECT query from the users table with the username and password matches with the input
		String str = "SELECT * FROM comments ORDER BY Username";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		
%>
		<b>Comments</b>
		<table border="1">
		<tr>
		<td>Username</td>
		<td>Commentor</td>
		<td>Comment</td>
		</tr>

		<%   
		while(result.next())
		{
		%>	
		<tr>
		<td><%=result.getString("Username") %></td>
		<td><%=result.getString("Commentor") %></td>
		<td><%=result.getString("Comment") %></td>
		<tr>
		</table>
	<%	}
		result.close();
		stmt.close();
		con.close();
		
		}	catch (Exception ex) {
			out.print("System failure");	
		}
	%>
</body>
</html>