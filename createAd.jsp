<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - System Support</title>
</head>
<body>

Welcome System Support!
<br>
	<%
      if(request.getAttribute("adStatus") != null){
   		 out.print(request.getAttribute("adStatus"));  
      }
    %> 
<br>
	<form method="post" action="newAd.jsp">
	<table>
	<tr>    
	<td>Company: </td><td><input type="text" name="company"></td>
	</tr>
	<tr>
	<td>Advertisement: </td><td><textarea rows="4" cols="25" name="advert"></textarea></td>
	</tr>
	<tr>
	<td>Price: </td><td><input type="text" name="price"></td>
	</tr>
	</table>
	<br>
	<input type="submit" value="Add new advertisement">
	</form>
<br>

<br>

[<a href="systemIndex.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/createAd.jsp">GitHub Page</a>] [<a href="index.jsp">Logout</a>] 

</body>
</html>