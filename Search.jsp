<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search For a User Here</title>
Search for a User Here
<p></p>
</head>
<body>
<br>
	<form method="post" action="SearchController.jsp">
	<table>
	<tr>    
	<td>User:</td><td><input type="text" name="user">
	<%
		if (request.getAttribute("none") != null)
		{
			out.println(request.getAttribute("none"));
		}
	%>
	</td>
	</tr>
	</table>
	<input type="submit" value="Search">
	</form>
<br>
<br>
[<a href="homepage.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/Search.jsp">GitHub Page</a>] 
</body>
</html>