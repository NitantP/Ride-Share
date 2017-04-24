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

<%

ResultSet registeredcars = null;

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
	registeredcars = stmt.executeQuery("SELECT c.LicensePlate FROM carlist c WHERE c.Username = \"" + currentun + "\" ");
} catch (Exception e) {
	out.println("System failure!");
}
%>
									  
<br>
	<form method="post" action="newRideOffer.jsp">
	<table>
	<tr>    
	<td>From:</td><td><input type="text" name="startinglocation">
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
        <%  while(registeredcars.next()){ %>
            <option value=<%=registeredcars.getString(1)%>><%= registeredcars.getString(1)%></option>
        <% } %>
        </select>
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

<p><a href="homepage.jsp">Back to main page</a></p>

<p><a href="https://github.com/NitantP/Ride-Share/blob/master/createRideOffer.jsp">GitHub Page</a></p>

</body>
</html>