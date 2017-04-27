<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Passwords Reset</title>
</head>
<body>

<%
	try {
		
		//Create a connection string
		String url = "jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "cs336project", "csteam14");
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Get parameters from the HTML form at the createRideOffer.jsp		

		//Make an update statement for the userlist table:
		String update;
		PreparedStatement ps;
		
		update = "UPDATE userlist SET Password = \"" + " " + "\" WHERE ForgotPass = 1";
		ps = con.prepareStatement(update);
		ps.executeUpdate();
		update = "UPDATE userlist SET ForgotPass = 0 WHERE ForgotPass = 1";
		ps = con.prepareStatement(update);
		ps.executeUpdate();
		//Run the query against the DB
		out.print("Successful Password Reset");
		
		stmt.close();
		con.close();
	}
	catch (Exception ex) {
		ex.printStackTrace();
		out.print("Insert failed!");
	}
	%>
	
	<br>
	<br>
	[<a href="systemIndex.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/resetPass.jsp">GitHub Page</a>] [<a href="index.jsp">Logout</a>] 
	
</body>
</html>
	