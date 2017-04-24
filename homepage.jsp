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

Welcome to Ride Share, <%= session.getAttribute("currentuser") %>!

<br>

<p><a href="testpage.jsp">test page (NOT PERMANENT, JUST TO SEE HOW SQL TABLES CAN BE DISPLAYED)</a></p>

<p><a href="createRideOffer.jsp">Create ride offer</a></p>

<p><a href="createRideRequest.jsp">Create ride request</a></p>

<p><a href="availableMatches.jsp">See available matches to invite to ride (based on your offers)</a></p>

<p><a href="createMessage.jsp">Send message to a user</a></p>

<p><a href="userSettings.jsp">Settings</a></p>

<p><a href="index.jsp">logout</a></p>

<p><a href="https://github.com/NitantP/Ride-Share/blob/master/homepage.jsp">GitHub Page</a></p>

</body>
