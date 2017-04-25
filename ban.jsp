<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Passwords Were Reset</title>
</head>
<body>

<%
	try {
		//ban those that have >5 reports?
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
		String d;
		String insert = "";
		PreparedStatement ps;
		
		d= "SELECT * From userlist u WHERE u.Reported > 5";
		ps = con.prepareStatement(d);
		ResultSet result = stmt.executeQuery(d);
		while (result.next())
		{
			insert = "INSERT INTO userlist(RUID, Email)"
					+ " VALUES (?, ?)";
			ps.setString(1, result.getString("RUID"));
			ps.setString(2, result.getString("Email"));
			ps = con.prepareStatement(insert);
			ps.executeUpdate();
		}
		//Run the query against the DB
		out.print("Successful Password Reset");
		con.close();
	}
	catch (Exception ex) {
		ex.printStackTrace();
		out.print("Insert failed!");
	}
	%>
	
	<p><a href="systeIndex.jsp">Return to settings page</a></p>
	
</body>
</html>
	