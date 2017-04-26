<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Statistics</title>
</head>
<body>

<%

out.println(request.getParameter("input"));
out.println(request.getParameter("querytype1"));
out.println("----------------------------------------------");
out.println(request.getParameter("input1") + " to " + request.getParameter("input2"));
out.println(request.getParameter("querytype2"));

%>

</body>
</html>