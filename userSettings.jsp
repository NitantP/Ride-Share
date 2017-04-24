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
<td>Name</td>
<td>Phone Number</td>
<td>Address</td>
<td>Password</td>
</tr>

<%
try
{
Class.forName("com.mysql.jdbc.Driver");
String url="jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
String cu = (String)session.getAttribute("currentuser");
String query="SELECT * FROM userlist c WHERE c.Username = \"" + cu + "\"";

Connection conn=DriverManager.getConnection(url, "cs336project", "csteam14");
Statement stmt=conn.createStatement();
ResultSet rs=stmt.executeQuery(query);
while(rs.next())
{

%>
<tr>
<td><%=rs.getString("Name") %></td>
<td><%=rs.getString("PhoneNumber") %></td>
<td><%=rs.getString("Address") %></td>
<td><%=rs.getString("Password") %></td>
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
	<form method="post" action="newUserSettings.jsp">
	<table>
	<tr>    
	<td>Name:</td><td><input type="text" name="name">
	<%
      if(request.getAttribute("nameFailed") != null){
   		 out.print(request.getAttribute("nameFailed"));  
      } 
    %>
	</td>
	</tr>
	<tr>
	<td>Phone Number:</td><td><input type="text" name="phoneNum">
	<%
      if(request.getAttribute("phoneNumFailed") != null){
   		 out.print(request.getAttribute("phoneNumFailed"));  
      } 
    %>
	</td>
	</tr>
	<tr>
	<td>Address:</td><td><input type="text" name="address">
	</td>
	</tr>
	<tr>
	<td>Password:</td><td><input type="text" name="password">
	</td>
	</tr>
	</table>
	<input type="submit" value="Change Settings">
	</form>
<br>

<p><a href="homepage.jsp">Back to main page</a></p>

<p><a href="https://github.com/NitantP/Ride-Share/blob/master/userSEttings.jsp">GitHub Page</a></p>

</body>
</html>