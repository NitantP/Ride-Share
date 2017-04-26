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

<form method="post" action="newUserSettings.jsp">

<table border="1">


<%
try
{
Class.forName("com.mysql.jdbc.Driver");
String url="jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
Connection conn=DriverManager.getConnection(url, "cs336project", "csteam14");
String cu = (String)session.getAttribute("currentuser");
String query="SELECT * FROM userlist c WHERE c.Username = \"" + cu + "\"";
Statement stmt=conn.createStatement();
ResultSet rs=stmt.executeQuery(query);
while(rs.next())
{

		String name = rs.getString("Name");
		String phone = rs.getString("PhoneNumber");
		String address = rs.getString("Address");
		%>
		<tr>
		<td>Set Visibility</td>
		<td>Settings</td>
		<td>Values</td>
		</tr>
		<tr>
		<td><input type=checkbox name=Vis value = <%=rs.getString("Name")%>/></td>
		<td>Name</td>
		<td><%=rs.getString("Name") %></td>
		</tr>
		<tr>
		<td><input type=checkbox name=Vis2 value = <%=rs.getString("PhoneNumber")%>/></td>
		<td>Phone Number</td>
		<td><%=rs.getString("PhoneNumber") %></td>
		</tr>
		<tr>
		<td><input type=checkbox name=Vis3 value = <%=rs.getString("Address")%>/></td>
		<td>Address</td>
		<td><%=rs.getString("Address") %></td>
		</tr>
		<tr>
		<tr>
		<td><input type=checkbox name=Vis4 value = <%=rs.getString("Email")%>/></td>
		<td>Email</td>
		<td><%=rs.getString("Email") %></td>
		</tr>
		<tr>
		<td></td>
		<td>Password</td>
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
Class.forName("com.mysql.jdbc.Driver");
String url="jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
Connection conn=DriverManager.getConnection(url, "cs336project", "csteam14");
String cu = (String)session.getAttribute("currentuser");
String query="SELECT * FROM userlist c WHERE c.Username = \"" + cu + "\"";
Statement stmt=conn.createStatement();
ResultSet rs=stmt.executeQuery(query);
while(rs.next())
{
%>

									  
<br>
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
	 <%

}
%>
	</table>
	<input type="submit" value="Change Settings">
	</form>
<br>

<p><a href="carSettings.jsp"><b>Add and Delete Cars</b></a></p>

<br>
<br>
[<a href="userSettings.jsp">User settings</a>] [<a href="homepage.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/userSettings.jsp">GitHub Page</a>] [<a href="index.jsp">Logout</a>] 

</body>
</html>