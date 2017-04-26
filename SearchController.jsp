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
		
		//Make an insert statement for the Ride Offers table:
		String insert = "SELECT *  FROM userlist u WHERE u.Username = \"" + request.getParameter("user") + "\"";
		ResultSet result = stmt.executeQuery(insert);
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		
		//INSERT INPUT CHECKS HERE
		boolean error = false;
		if(!result.next())
		{
			error = true;
		}
		if (error)
		{
			request.setAttribute("none", "There are no users with that username");
			RequestDispatcher ed = request.getRequestDispatcher("Search.jsp");
        	ed.forward(request, response);
		}
		else
		{
			//Run the query against the DB
			out.print("Search successful! <br><br>");
			out.println("Username: " + result.getString("Username"));
			out.println("<br>");
			out.println("Name: " + result.getString("Name"));
			out.println("<br>");
			out.println("Address: " + result.getString("Address"));
			out.println("<br>");
			out.println("Phone Number: " + result.getString("PhoneNumber"));
			out.println("<br>");
			out.println("Email: " + result.getString("Email"));
			out.println("<br>");
			out.println("Rating: " + result.getString("Rating"));
		}
		con.close();
	}
	catch (Exception ex) {
		ex.printStackTrace();
		out.print("Insert failed!");
	}
	%>
	
	<p><a href="homepage.jsp">Return to main (login) page</a></p>
	
</body>
</html>
	