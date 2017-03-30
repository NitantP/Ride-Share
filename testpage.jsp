<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Test Page</title>
</head>
<body>

<form method="post">

<table border="1">
<tr>
<td>RUID</td>
<td>Username</td>
<td>Password</td>
<td>E-mail</td>
</tr>

<%
try
{
Class.forName("com.mysql.jdbc.Driver");
String url="jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
String query="SELECT * FROM userlist";
Connection conn=DriverManager.getConnection(url, "cs336project", "csteam14");
Statement stmt=conn.createStatement();
ResultSet rs=stmt.executeQuery(query);
while(rs.next())
{

%>
<tr>
<td><%=rs.getString("RUID") %></td>
<td><%=rs.getString("Username") %></td>
<td><%=rs.getString("Password") %></td>
<td><%=rs.getString("Email") %></td>
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

</body>
</html>