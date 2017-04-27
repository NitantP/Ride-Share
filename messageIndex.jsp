<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Messages</title>
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
		String str = "SELECT * FROM SEND_EMAIL e WHERE e.Recipient = \"" + currentun + "\" ORDER BY e.Date, e.Time DESC";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
%>		
		<form method="post" action="delete.jsp">
		<table border="1">
		<tr>
		<td>Delete?</td>
		<td>From</td>
		<td>Date</td>
		<td>Time</td>
		<td>Subject</td>
		<td>Content</td>
		</tr>

<%      
		while(result.next())
		{
		%>
		<tr>
		<td><input type="checkbox" name="deleteid" value=<%=result.getString("e.Sender") + "," + result.getString("e.Date") + "," + result.getString("e.Time")%>></td>
		<td><%=result.getString("e.Sender") %></td>
		<td><%=result.getString("e.Date") %></td>
		<td><%=result.getString("e.Time") %></td>
		<td><%=result.getString("e.Subject") %></td>
		<td><%=result.getString("e.Content") %></td>
		</tr>
		
		<%

		}
		%>
		</table>
		<input type="submit" name="deletebutton" value="Delete">(DOES NOT WORK YET)
		<input type="hidden" name="deletetype" value="message">
		</form>	
		<br>
		[<a href="createMessage.jsp"><b>New message</b></a>]
<%
		
		result.close();
		stmt.close();
		con.close();
		
		} catch (Exception ex){
			ex.printStackTrace();
			out.println("--");
		}
%>

		<br>
		<br>
[<a href="homepage.jsp">Main page</a>] [<a href="index.jsp">Logout</a>]
</body>
</html>