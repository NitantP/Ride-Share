<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Create Ride Request</title>
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
		String newStart = request.getParameter("startinglocation");
		String newDestination = request.getParameter("destination");
		String newDate = request.getParameter("date");
		String newTime = request.getParameter("time");
		String newNumPassengers = request.getParameter("numpassengers");
		String checkRecurring = request.getParameter("recurring");
		
		//Make an insert statement for the Ride Offers table:
		String insert = "INSERT INTO riderequests(Username, Date, Time, NumPassengers, Recurring, Origin, Destination)"
						+ " VALUES (?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, (String)session.getAttribute("currentuser"));
		ps.setString(2, newDate);
		ps.setString(3, newTime);
		ps.setString(4, newNumPassengers);
		ps.setString(5, checkRecurring);
		ps.setString(6, newStart);
		ps.setString(7, newDestination);
		
		//INSERT INPUT CHECKS HERE
		boolean error = false;
		
		if (error)
		{
			RequestDispatcher ed = request.getRequestDispatcher("register.jsp");
        	ed.forward(request, response);
		}

			//Run the query against the DB
			ps.executeUpdate();
			
			out.print("Insert successful! <br><br>");
			out.print("From: " + newStart + "<br>" +
					  "To: " + newDestination + "<br>" +
					  "Date: " + newDate + "<br>" +
					  "Time: " + newTime + "<br>" +
					  "Passengers: " + newNumPassengers + "<br>");	
		
		con.close();
	}
	catch (Exception ex) {
		ex.printStackTrace();
		out.print("Insert failed!");
	}
	%>
	
	<p><a href="index.jsp">Return to main (login) page</a></p>
	
</body>
</html>
	