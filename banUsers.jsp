<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Ban Users</title>
</head>
<body>

<!-- Displays users that are eligible to receive a ban -->

<% 	
	try {
	//Create a connection string
	String url = "jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");
	//Create a connection to your DB
	Connection con = DriverManager.getConnection(url, "cs336project", "csteam14");
	//Create an SQL statement
	Statement stmt = con.createStatement();
	
	String currentun = (String)session.getAttribute("currentuser");
	
	String str = "SELECT * FROM userlist u WHERE Reported > 5";
	ResultSet result = stmt.executeQuery(str);
%>

<FORM method = "POST" ACTION = "ban.jsp">
		<table border="1">
		<tr>
		<td>Username</td>
		<td>Reported</td>
		</tr>

<%		//Choose users to ban
		while(result.next())
		{

		%>
		<tr>
		<td><%=result.getString("Username") %></td>
		<td><%=result.getString("Reported") %></td>
		</tr>

		<%

		}
		%>
		</table>
		<input type=submit name=submit value="Ban Users">
</FORM>
		
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

[<a href="systemIndex.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/banUsers.jsp">GitHub Page</a>] [<a href="index.jsp">Logout</a>] 

</body>
</html>