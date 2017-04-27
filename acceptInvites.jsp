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
		
		String insert = "INSERT INTO acceptedRides(offerID, requestID, Offerer, Requester, LicensePlate, Time, Date, NumPassengers, Origin, Destination)"
						+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		PreparedStatement ps = con.prepareStatement(insert);
		
		String offerid = request.getParameter("offerid");
		String oidcorrected = offerid.substring(0,offerid.length() - 1);
		int ofrid = Integer.parseInt(oidcorrected);
				
		int requestid = Integer.parseInt(request.getParameter("requestid"));
		
		String q1 = "SELECT * FROM rideoffers O WHERE O.offerID = " + ofrid;
		String q2 = "SELECT R.Username, R.NumPassengers FROM riderequests R WHERE R.requestID = " + requestid;
		
		ResultSet result = stmt.executeQuery(q1);
		
		RequestDispatcher rd = request.getRequestDispatcher("availableInvites.jsp");
		
   		if(result.next()){
			ps.setInt(1, ofrid);
			ps.setInt(2, requestid);
			ps.setString(3, result.getString("O.Username"));
			ps.setString(5, result.getString("O.LicensePlate"));
			ps.setString(6, result.getString("O.Time"));
			ps.setString(7, result.getString("O.Date"));
			ps.setString(9, result.getString("O.Origin"));
			ps.setString(10, result.getString("O.Destination"));
			result = stmt.executeQuery(q2);
			if(result.next()){
				ps.setString(4, result.getString("R.Username"));
				ps.setString(8, result.getString("R.NumPassengers"));
				result.close();
			}
			ps.executeUpdate();
   		} else { 
   			request.setAttribute("acceptStatus", "<h4 style=\"color:red;\">Error: invites not accepted!</h4>");
   			rd.forward(request, response);
   		}
   		
   		request.setAttribute("acceptStatus", "<h4 style=\"color:green;\">Invites accepted!</h4>");
   		rd.forward(request, response);
  
		stmt.close();
		con.close();
   		
} catch (Exception ex){
	ex.printStackTrace();
	out.println("System failure!");
}
%>

<br>
<br>

[<a href="availableMatchesIntermediate.jsp">Back</a>] [<a href="homepage.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/acceptInvites.jsp">GitHub Page</a>] [<a href="index.jsp">Logout</a>] 

</body>
</html>
