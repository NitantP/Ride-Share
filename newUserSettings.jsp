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
		String name = request.getParameter("name");
		String phoneNum = request.getParameter("phoneNum");
		String address = request.getParameter("address");
		String password = request.getParameter("password");

		//Make an update statement for the userlist table:
		String update;
		PreparedStatement ps;
		boolean error = false;
		boolean nameDigit = false;
		boolean phoneDigit = true;
		
		for (int i = 0; i < Math.max(name.length(), phoneNum.length()); i++) 
	    {
	        if (phoneNum.length() > i + 1) 
	        {
	        	if(!Character.isDigit(phoneNum.charAt(i)))
	        	{
	        		phoneDigit = false;
	        	}
	        }
	        if (name.length() > i + 1) 
	        {
	        	if(Character.isDigit(name.charAt(i)))
	        	{
	        		nameDigit = true;
	        	}
	        }
	    }
		if (name.length() != 0 && !nameDigit)
		{
			update = "UPDATE userlist SET Name =\"" + name + "\" WHERE Username =\"" + (String)session.getAttribute("currentuser")+ "\"";
			ps = con.prepareStatement(update);
			ps.executeUpdate();
		}
		else if (nameDigit)
		{
			request.setAttribute("nameFailed", "Invalid name");
			error = true;
		}
		
		if (phoneNum.length() <= 15 && phoneDigit && phoneNum.length() >= 7)
		{
			update = "UPDATE userlist SET PhoneNumber =\"" + phoneNum + "\" WHERE Username =\"" + (String)session.getAttribute("currentuser")+ "\"";
			ps = con.prepareStatement(update);
			ps.executeUpdate();
		}
		else if (!phoneDigit)
		{
			request.setAttribute("phoneNumFailed", "Invalid phone number");
			error = true;
		}
		if (address.length() != 0)
		{
			update = "UPDATE userlist SET Address =\"" + address + "\" WHERE Username =\"" + (String)session.getAttribute("currentuser")+ "\"";
			ps = con.prepareStatement(update);
			ps.executeUpdate();
		}
		if (password.length() != 0)
		{
			update = "UPDATE userlist SET Password =\"" + password + "\" WHERE Username =\"" + (String)session.getAttribute("currentuser")+ "\"";
			ps = con.prepareStatement(update);
			ps.executeUpdate();
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
			out.print("Insert successful! <br>");
			out.print("Namee: " + name + "<br>" +
					  "Phone Number: " + phoneNum + "<br>" +
					  "Address: " + address + "<br>" +
					  "Password: " + password+ "<br>");	
		}
		con.close();
	}
	catch (Exception ex) {
		ex.printStackTrace();
		out.print("Insert failed!");
	}
	%>
	
	<p><a href="userSettings.jsp">Return to settings page</a></p>
	
</body>
</html>
	