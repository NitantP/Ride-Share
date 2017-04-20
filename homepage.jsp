<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share</title>
</head>
<body>

Welcome to Ride Share, <%= session.getAttribute("currentuser") %>! If you're seeing this, you logged in correctly!

<br>
**WARNING: Site still under construction!**

<p><a href="testpage.jsp">test page (NOT PERMANENT, JUST TO SEE HOW SQL TABLES CAN BE DISPLAYED)</a></p>

<p><a href="createRideOffer.jsp">Create ride offer</a></p>

<p><a href="createRideRequest.jsp">Create ride request</a></p>

<p><a href="userSettings.jsp">Settings</a></p>

<p><a href="index.jsp">logout</a></p>

</body>
