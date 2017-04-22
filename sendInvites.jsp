<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to Ride Share</title>
</head>	
<body>

<%! String[] inviteList; %>

<% 
   inviteList = request.getParameterValues("invited");
   if (inviteList != null){
      for (int i = 0; i < inviteList.length; i++){
         out.println ("<b>"+inviteList[i]+ "<b>");
      }
   }
   else out.println ("<b>None invited!<b>");
%>

</body>
</html>
