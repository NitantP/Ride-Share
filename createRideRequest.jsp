<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Create Ride Request</title>
</head>
<body>

Ride Share (TEAM 14) 
<br>
<form method="post" action="delete.jsp">

<table border="1">
<tr>
<td>Delete?</td>
<td>Request ID</td>
<td>Origin</td>
<td>Destination</td>
<td>Date</td>
<td>Time</td>
<td>Number of Passengers</td>
</tr>

<%
try
{
Class.forName("com.mysql.jdbc.Driver");
String url="jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
String cu = (String)session.getAttribute("currentuser");
String query="SELECT * FROM riderequests r WHERE r.Username = \"" + cu + "\"";

Connection conn=DriverManager.getConnection(url, "cs336project", "csteam14");
Statement stmt=conn.createStatement();
ResultSet rs=stmt.executeQuery(query);
while(rs.next())
{

%>
<tr>
<td align="center"><input type="checkbox" name="deleteid" value=<%=rs.getString("requestID") %>></td>
<td align="center"><%=rs.getInt("requestID") %>
<td><%=rs.getString("Origin") %></td>
<td><%=rs.getString("Destination") %></td>
<td><%=rs.getString("Date") %></td>
<td><%=rs.getString("Time") %></td>
<td><%=rs.getString("NumPassengers") %></td>
</tr>

 <%

}
%>
</table>
<br>
<input type="submit" name="submit" value="Delete">
<input type="hidden" name="deletetype" value="request">
<%
rs.close();
stmt.close();
conn.close();
}
catch(Exception e)
{
e.printStackTrace();
}
%>
</form>			  

<br>

	<form method="post" action="newRideRequest.jsp">
	<table>
	<tr>    
	<td>From:</td><td><input type="text" name="startinglocation">
	<%
		if (request.getAttribute("duplicate") != null)
		{
			out.println(request.getAttribute("duplicate"));
		}
	%>
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
	<td>Number of Passengers:</td><td><input type="text" name="numpassengers">
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
<br>

[<a href="homepage.jsp">Main page</a>] [<a href="homepage.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/createRideRequest.jsp">GitHub Page</a>]

</body>
</html>