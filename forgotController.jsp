<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reset Password</title>
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
		String user = request.getParameter("user");

		
		
		String str = "SELECT * FROM userlist v WHERE v.Username =\"" + user+ "\"";
		ResultSet result = stmt.executeQuery(str);
		if (result.next())
		{
			System.out.println("hello");
			str = "UPDATE userlist SET ForgotPass = 1 WHERE Username = \"" + user + "\"";
			PreparedStatement ps = con.prepareStatement(str);
			ps.executeUpdate();
			out.print("Sent a password reset request! <br>");
		}
		else
		{
			request.setAttribute("userFailed", "Not a user");
			RequestDispatcher ed = request.getRequestDispatcher("forgot.jsp");
        	ed.forward(request, response);
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
[<a href="index.jsp">Login</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/newUserSettings.jsp">GitHub Page</a>] 
	
</body>
</html>
	