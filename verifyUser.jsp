<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>verifyUser</title>
</head>
<body>
<% 
		List<String> list = new ArrayList<String>();
		
		try {
		//Create a connection string
		String url = "jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "cs336project", "csteam14");
		
		Statement stmt = con.createStatement();
		//Get the username from the main.jsp
		String un = request.getParameter("username");
		//Get the password from the main.jsp
		String pw = request.getParameter("password");
		//Make a SELECT query from the users table with the username and password matches with the input
		String str = "SELECT * FROM userlist WHERE Username = \"" + un + "\" AND Password = \"" + pw + "\";";
		out.print("" + str + "<br>");
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);

		if(result.next()){
			response.sendRedirect("index.jsp");
		} else {
			response.sendRedirect("main.jsp");
		}
		
		con.close();
		
		}	catch (Exception ex) {
			out.print("failed");	
		}
%>

</body>
</html>