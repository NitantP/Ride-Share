<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Admin</title>
</head>
<body>

<!-- Home page for administrators -->

Welcome, <%=(String)session.getAttribute("currentuser") %> [<a href="index.jsp">Logout</a>] 
<br>
<br>
[<a href="createSystemAccount.jsp">Create system support account</a>]
<br>
[<a href="Stats.jsp">Statistics</a>]

<br>
<br>

[<a href="homepage.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/adminIndex.jsp">GitHub Page</a>]

</body>
</html>