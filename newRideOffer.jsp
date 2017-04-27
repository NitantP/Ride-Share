<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Create Ride Offer</title>
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
		String newMaxPassengers = request.getParameter("maxpassengers");
		String LicensePlate = request.getParameter("licenseplate");
		String checkRecurring = request.getParameter("recurring");
		
		//Make an insert statement for the Ride Offers table:
		String insert = "INSERT INTO rideoffers(Username, Date, Time, MaxPassengers, LicensePlate, Recurring, Origin, Destination)"
				+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, (String)session.getAttribute("currentuser"));
		ps.setString(2, newDate);
		ps.setString(3, newTime);
		ps.setString(4, newMaxPassengers);
		ps.setString(5, LicensePlate);
		if (checkRecurring == null)
		{
			checkRecurring = "false";
		}
		ps.setString(6, checkRecurring);
		ps.setString(7, newStart);
		ps.setString(8, newDestination);
		
		
		
		//INSERT INPUT CHECKS HERE
		boolean error = false;
		boolean isDigit = true;
		boolean isDigit2 = true;
		if (newDate.length() != 10 || newTime.length() != 5)
		{
			request.setAttribute("time", "Please use the format hour:minute");
			request.setAttribute("date", "Please use the format year-month-day eg 2017-01-01");
			RequestDispatcher ed = request.getRequestDispatcher("createRideOffer.jsp");
			ed.forward(request, response);	
		}
		else
		{
			for (int i = 0; i < 10; i++)
			{
				if (i != 4 && i != 7)
				{
					if (!Character.isDigit(newDate.charAt(i))) 
			        {
			        	isDigit2 = false;
			        }
				}
			}
			for (int i = 0; i < 5; i++)
			{
				if (i != 2)
				{
					if (!Character.isDigit(newTime.charAt(i))) 
			        {
			        	isDigit = false;
			        }
				}
			}
			if(!isDigit || !isDigit2 || Integer.parseInt(newTime.substring(0, 2)) > 24 || Integer.parseInt(newTime.substring(3, newTime.length())) > 59 || newTime.charAt(2) != ':'
					|| Integer.parseInt(newDate.substring(0, 4)) != 2017 || Integer.parseInt(newDate.substring(5, 7)) > 12 
					|| (Integer.parseInt(newDate.substring(5, 7)) < 4 && Integer.parseInt(newDate.substring(8, 10)) < 26) || Integer.parseInt(newDate.substring(8, 10)) > 31)
			{
				request.setAttribute("time", "Please use the format HH:MM");
				request.setAttribute("date", "Please use the format YYYY-MM-DD");
				RequestDispatcher ed = request.getRequestDispatcher("createRideOffer.jsp");
				ed.forward(request, response);	
			}
			else
			{
				String date = newDate.substring(0, 3) + newDate.substring(5,6) + newDate.substring(8,9);
				String startTime;
				String test = "SELECT * FROM rideoffers r WHERE r.Username = \"" + (String)session.getAttribute("currentuser")
				+ "\" AND r.Date = \"" + date + "\"AND r.Time = \"" + newTime +  
				"\"AND r.Origin = \""  + newStart + "\" AND r.Destination = \""  + newDestination +"\"";
				ResultSet result = stmt.executeQuery(test);
				if (result.next())
				{
					request.setAttribute("duplicate","Duplicate Offer");
					error = true;
				}
				if(LicensePlate == null || LicensePlate.equals("")){
					request.setAttribute("insertStatus","Error: no license plate selected!");
					error = true;
				}
				
				if (error)
				{
					RequestDispatcher ed = request.getRequestDispatcher("createRideOffer.jsp");
					ed.forward(request, response);	
				}
				else
				{
					ps.executeUpdate();
					
					out.print("Insert successful! <br><br>");
					out.print("From: " + newStart + "<br>" +
							  "To: " + newDestination + "<br>" +
							  "Date: " + newDate + "<br>" +
							  "Time: " + newTime + "<br>" +
							  "Max Passengers: " + newMaxPassengers + "<br>" +
							  "License Plate: " + LicensePlate + "<br>");	
				}
			}
		}
		con.close();
	}
	catch (Exception ex) {
		ex.printStackTrace();
		out.print("Insert failed!");
	}
	%>
<br>
<br>	
[<a href="createRideOffer.jsp">Ride offers</a>] [<a href="homepage.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/newRideOffer.jsp">GitHub Page</a>]
</body>
</html>
	