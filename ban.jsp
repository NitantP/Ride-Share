<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Ban Users</title>
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
		String insert;
		PreparedStatement ps;
		PreparedStatement ps2;
		
		d= "SELECT * From userlist u WHERE u.Reported > 5";
		ps = con.prepareStatement(d);
		ResultSet result = stmt.executeQuery(d);
		while (result.next())
		{
			insert = "INSERT INTO banlist(RUID, Email)"
					+ " VALUES (?, ?)";
			ps2 = con.prepareStatement(insert);
			ps2.setString(1, result.getString("RUID"));
			ps2.setString(2, result.getString("Email"));
			ps2.executeUpdate();
		}
		//Run the query against the DB
		out.print("Users Banned");
		
		result.close();
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
[<a href="banUsers.jsp">Ban page</a>] [<a href="systemIndex.jsp">Home page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/ban.jsp">GitHub Page</a>] [<a href="index.jsp">Logout</a>] 	

<body>
</html>
	