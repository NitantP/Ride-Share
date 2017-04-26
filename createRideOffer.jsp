<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Create Ride Offers</title>
</head>
<body>

Ride Share (TEAM 14) 
<br>
<form method="post" action="delete.jsp">

<table border="1">
<tr>
<td>Delete?</td>
<td>Offer ID</td>
<td>Origin</td>
<td>Destination</td>
<td>Date</td>
<td>Time</td>
<td>Max Passengers</td>
<td>License Plate</td>
</tr>

<%
try
{
Class.forName("com.mysql.jdbc.Driver");
String url="jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
String cu = (String)session.getAttribute("currentuser");
String query="SELECT * FROM rideoffers r WHERE r.Username = \"" + cu + "\"";

Connection conn=DriverManager.getConnection(url, "cs336project", "csteam14");
Statement stmt=conn.createStatement();
ResultSet rs=stmt.executeQuery(query);
while(rs.next())
{

%>
<tr>
<td align="center"><input type="checkbox" name="deleteid" value=<%=rs.getString("offerID") %>></td>
<td align="center"><%=rs.getInt("offerID") %>
<td><%=rs.getString("Origin") %></td>
<td><%=rs.getString("Destination") %></td>
<td><%=rs.getString("Date") %></td>
<td><%=rs.getString("Time") %></td>
<td><%=rs.getString("MaxPassengers") %></td>
<td><%=rs.getString("LicensePlate") %></td>
</tr>

 <%

}
%>
</table>
<br>
<input type="submit" name="submit" value="Delete">
<input type="hidden" name="deletetype" value="offer">

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
<%

ResultSet result = null;

try {
	
	//Create a connection string
	String url = "jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");
	//Create a connection to your DB
	Connection con = DriverManager.getConnection(url, "cs336project", "csteam14");
	//Create a SQL statement
	String currentun = (String)session.getAttribute("currentuser");
	Statement stmt = con.createStatement();
	result = stmt.executeQuery("SELECT c.LicensePlate FROM carlist c WHERE c.Username = \"" + currentun + "\" ");
%>
									  
<br>
	<form method="post" action="newRideOffer.jsp">
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
	<td>Max Number of Passengers:</td><td><input type="text" name="maxpassengers">
	</td>
	</tr>
	<tr>
	<td>Select a car (by license plate):</td><td><select name="licenseplate">
        <%  while(result.next()){ %>
            <option value=<%=result.getString(1)%>><%= result.getString(1)%></option>
        <% } %>
        </select>
    </td>
    </tr>
	<tr>
	<td>Recurring? </td><td><input type="checkbox" name="recurring" value="true">
	</td>
	</tr>
	</table>
	<br>
	<input type="submit" value="Submit Request">
	</form>

<%
	} catch (Exception e) {
	out.println("System failure!");
	}
%>
<br>
<br>
[<a href="homepage.jsp">Back to main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/createRideOffer.jsp">GitHub Page</a>]

</body>
</html>