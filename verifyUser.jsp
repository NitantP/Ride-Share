<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Login</title>
</head>
<body>

<!-- Verify a user account that is trying to log into the system -->
<!-- Takes from/returns to index.jsp -->

<% 
		List<String> list = new ArrayList<String>();
		
		try {
		//Create a connection string
		String url = "jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "cs336project", "csteam14");
		//Create an SQL statement
		Statement stmt = con.createStatement();

		//Check to see whether user exists and is banned
		String un = request.getParameter("username");
		String pw = request.getParameter("password");
		String str = "SELECT * FROM userlist WHERE Username = \"" + un + "\" AND Password = \"" + pw + "\";";
		ResultSet result = stmt.executeQuery(str);

		if(result.next()) {
			String banRUID = result.getString("RUID");
			String AccountType = result.getString("AccountType");
			String ban = "SELECT * FROM banlist WHERE RUID = \"" + banRUID + "\"";
			result = stmt.executeQuery(ban);
			if (!result.next()) {
				session.setAttribute("currentuser", un);
				String hasRating = "SELECT HasRating FROM userlist WHERE Username = \"" + un + "\"";
				result = stmt.executeQuery(hasRating);
				result.next();
				//Redirect according to account type
				if(AccountType.equals("Admin")) {
					response.sendRedirect("adminIndex.jsp");
				} else if(AccountType.equals("System Support")) {
					response.sendRedirect("systemIndex.jsp");
				} else {
					//Redirect a user to a rating page for previous ride, if available
					if (!result.getString("HasRating").equals("0")) {
						response.sendRedirect("giveRating.jsp");
					} else {
						response.sendRedirect("homepage.jsp");
					}
				}
			} else {
				request.setAttribute("banned", "You Are Banned");
				RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
				rd.forward(request, response);
			}
		} else {
			request.setAttribute("loginFailed", "Invalid username or password!");
	        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
	        rd.forward(request, response);
		}

		con.close();
		
		} catch (Exception ex) {
			ex.printStackTrace();
			out.print("System failure");	
		}
%>

<br>
<br>
[<a href="https://github.com/NitantP/Ride-Share/blob/master/verifyUser.jsp">GitHub Page</a>] 


</body>
</html>