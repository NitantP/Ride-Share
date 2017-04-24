<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Settings</title>
</head>
<body>

Ride Share (TEAM 14) 
<br>

<form method="post">

<table border="1">
<tr>
<td>LicensePlate</td>
<td>Make</td>
<td>Model</td>
<td>Year</td>
<td>MaxPassengers</td>
</tr>

<%
try
{
Class.forName("com.mysql.jdbc.Driver");
String url="jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
String cu = (String)session.getAttribute("currentuser");
String query="SELECT * FROM carlist c WHERE c.Username = \"" + cu + "\"";

Connection conn=DriverManager.getConnection(url, "cs336project", "csteam14");
Statement stmt=conn.createStatement();
ResultSet rs=stmt.executeQuery(query);
while(rs.next())
{

%>
<tr>
<td><%=rs.getString("LicensePlate") %></td>
<td><%=rs.getString("Make") %></td>
<td><%=rs.getString("Model") %></td>
<td><%=rs.getString("Year") %></td>
<td><%=rs.getString("MaxPassengers") %></td>
</tr>

 <%

}
%>
</table>
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
	<form method="post" action="newCarSettings.jsp">
	<table>
	<tr>    
	<td>License Plate:</td><td><input type="text" name="licenseplate">
	<%
      if(request.getAttribute("licenseFailed") != null){
   		 out.print(request.getAttribute("licenseFailed"));  
      } 
    %>
	</td>
	</tr>
	<tr>
	<td>Make:</td><td><input type="text" name="make">
	<%
      if(request.getAttribute("makeFailed") != null){
   		 out.print(request.getAttribute("makeFailed"));  
      } 
    %>
	</td>
	</tr>
	<tr>
	<td>Model:</td><td><input type="text" name="model">
	<%
      if(request.getAttribute("modelFailed") != null){
   		 out.print(request.getAttribute("modelFailed"));  
      } 
    %>
	</td>
	</tr>
	<tr>
	<td>Year:</td><td><input type="text" name="year">
	<%
      if(request.getAttribute("yearFailed") != null){
   		 out.print(request.getAttribute("yearFailed"));  
      } 
    %>
	</td>
	</tr>
	<tr>
	<td>Max Number of Passengers:</td><td><input type="text" name="maxpassengers">
	<%
      if(request.getAttribute("passengerFailed") != null){
   		 out.print(request.getAttribute("passengerFailed"));  
      } 
    %>
	</td>
	</tr>
	</table>
	<input type="submit" value="Add New Car">
	</form>
<br>

<p><a href="homepage.jsp">Back to main page</a></p>

</body>
</html>