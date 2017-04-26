<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Send Invites</title>
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
		
		String insert = "INSERT INTO acceptedRides(offerID, requestID)"
						+ " VALUES (?, ?)";
		
		PreparedStatement ps = con.prepareStatement(insert);
		
		String offerid = request.getParameter("offerid");
		String requestid = request.getParameter("requestid");
		
		RequestDispatcher rd = request.getRequestDispatcher("availableInvites.jsp");
		
   		if (request.getParameter("offerid") != null && request.getParameter("requestid") != null){
   			String oidcorrected = offerid.substring(0,offerid.length() - 1);
			ps.setInt(1, Integer.parseInt(oidcorrected));
			ps.setInt(2, Integer.parseInt(requestid));
			ps.executeUpdate();
   		} else { 
   			request.setAttribute("acceptStatus", "<h4 style=\"color:red;\">Error: invites not accepted!</h4>");
   			rd.forward(request, response);
   		}
   		
   		request.setAttribute("acceptStatus", "<h4 style=\"color:green;\">Invites accepted!</h4>");
   		rd.forward(request, response);
   		
} catch (Exception ex){
	ex.printStackTrace();
	out.println("System failure!");
}
%>

<br>
<br>

[<a href="availableMatchesIntermediate.jsp">Back</a>] [<a href="homepage.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/sendInvites.jsp">GitHub Page</a>] [<a href="index.jsp">Logout</a>] 

</body>
</html>
