<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	try {

		
		//Create a connection string
		String url = "jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/?user=cs336project";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");

		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "student", "student");

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the main.jsp		
		String newRUID = request.getParameter("ruid");
		String newUsername = request.getParameter("username");
		String newPassword = request.getParameter("password");
		String newEmail = request.getParameter("email");

		//float price = Float.valueOf(request.getParameter("price"));
		
		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO users(ruid, username, password, email)"
				+ "VALUES (?, ?, ?, ?)";

		PreparedStatement ps = con.prepareStatement(insert);
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, newUsername);
		ps.setString(2, newPassword);
		ps.setString(2, newEmail);
		ps.setString(2, newRUID);
		//Run the query against the DB
		ps.executeUpdate();
		
		con.close();
	}
	catch (Exception ex) {
		out.print("insert failed");
	}
	%>
</body>
</html>