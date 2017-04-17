<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>newUser</title>
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
		//Get parameters from the HTML form at the main.jsp		
		String newEmail = request.getParameter("email");
		String newUsername = request.getParameter("username");
		String newPassword = request.getParameter("password");
		
		//Make an insert statement for the Users table:
		String insert = "INSERT INTO userlist(RUID, Email, Username, Password, RidesGiven, RidesTaken, AccountType)"
				+ " VALUES (?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, "000000000");
		ps.setString(2, newEmail);
		ps.setString(3, newUsername);
		ps.setString(4, newPassword);
		ps.setInt(5, 0);
		ps.setInt(6, 0);
		ps.setString(7, "System Support");
		
		boolean error = false;
		
		//jc1997@rutgers.edu
		if (!newEmail.toLowerCase().contains("@rutgers.edu") || newEmail.substring(newEmail.indexOf("@")).equals("rutgers.edu"))
		{
			request.setAttribute("emailFailed", "Invalid email (must be an @rutgers.edu address!)");
			error = true;
		}
		
		if(newUsername.isEmpty())
		{
			request.setAttribute("userFailed", "Invalid username (cannot be blank!)");
			error = true;
		}
		if(newPassword.isEmpty())
		{
			request.setAttribute("passFailed", "Invalid password (cannot be blank!)");
			error = true;
		}
		
		if (error)
		{
			RequestDispatcher ed = request.getRequestDispatcher("register.jsp");
        	ed.forward(request, response);
		}

			//Run the query against the DB
			ps.executeUpdate();

			out.print("Insert successful! <br>");
			out.print("Username: " + newUsername + "<br>" +
					  "Password: " + newPassword + "<br>" +
					  "Email: " + newEmail + "<br>");	
		
		con.close();
	}
	catch (Exception ex) {
		ex.printStackTrace();
		out.print("Insert failed!");
	}
	%>
	
	<p><a href="adminIndex.jsp">Return to main page</a></p>
	
</body>
</html>