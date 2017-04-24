<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
		String license = request.getParameter("licenseplate");
		String make = request.getParameter("make");
		String model = request.getParameter("model");
		String year = request.getParameter("year");
		String newMaxPassengers = request.getParameter("maxpassengers");
		String checkRecurring = request.getParameter("default");

		//Make an insert statement for the Ride Offers table:
		String insert = "INSERT INTO carlist(LicensePlate, Username, MaxPassengers, Make, Model, Year)"
				+ " VALUES (?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, license);
		ps.setString(2, (String)session.getAttribute("currentuser"));
		ps.setString(3, newMaxPassengers);
		ps.setString(4, make);
		ps.setString(5, model);
		ps.setString(6, year);
		
		boolean error = false;
		boolean isDigit = true;
		int intYear = -1;
		if (license.isEmpty())
		{
			request.setAttribute("licenseFailed", "Invalid License Plate");
			error = true;
		}
		if(newMaxPassengers.isEmpty() || newMaxPassengers.compareTo("0") < 0 || newMaxPassengers.compareTo("8") > 0)
		{
			request.setAttribute("passengerFailed", "Invalid number of passengers");
			error = true;
		}
		
		if(model.isEmpty())
		{
			request.setAttribute("modelFailed", "Invalid number of passengers");
			error = true;
		}
		
		if(make.isEmpty())
		{
			request.setAttribute("makeFailed", "Invalid number of passengers");
			error = true;
		}
		int size = year.length();
		
		for (int i = 0; i < size; i++) 
	    {
	        if (!Character.isDigit(year.charAt(i))) 
	        {
	        	isDigit = false;
	        }
	    }
		

		
		if(year.isEmpty() || !isDigit || year.length() != 4 || year.compareTo("1900") < 0 || year.compareTo("2017") > 0)
		{
			//(intYear < 1900 && intYear != -1) || intYear > 2017
			request.setAttribute("yearFailed", "Invalid year");
			error = true;
		}
		
		if(error)
		{
			out.print("failed");
			RequestDispatcher ed = request.getRequestDispatcher("userSettings.jsp");
        	ed.forward(request, response);
		}
		else
		{
			//Run the query against the DB
			ps.executeUpdate();
			
			out.print("Insert successful! <br>");
			out.print("License Plate: " + license + "<br>" +
					  "Username: " + "defaultusername" + "<br>" +
					  "Make: " + make + "<br>" +
					  "Model: " + model + "<br>" +
					  "Year: " + year + "<br>" +
					  "Max Passengers : " + newMaxPassengers + "<br>");	
		}
		con.close();
	}
	catch (Exception ex) {
		ex.printStackTrace();
		out.print("Insert failed!");
	}
	%>
	
	<p><a href="userSettings.jsp">Return to settings page</a></p>
	
	<p><a href="homepage.jsp">Return to main page</a></p>
	
	<p><a href="https://github.com/NitantP/Ride-Share/blob/master/newUserSettings.jsp">GitHub Page</a></p>
	
	
</body>
</html>
	