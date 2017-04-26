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
		
		String offerun = request.getParameter("offerusername");
		
		String insert = "INSERT INTO SEND_EMAIL(Sender, Recipient, Date, Time, Subject, Content)"
						+ " VALUES (?, ?, ?, ?, ?, ?)";
		
		String insert2 = "INSERT INTO possibleMatches(offerID, requestID) VALUES (?, ?)";
		
		PreparedStatement ps = con.prepareStatement(insert);
		PreparedStatement ps2 = con.prepareStatement(insert2);
		
		LocalDate date = LocalDate.now(ZoneId.of("America/Montreal")); 
		DateTimeFormatter dateformatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		DateTimeFormatter timeformatter = DateTimeFormatter.ofPattern("HH:mm:ss");
		String formatteddate = date.format(dateformatter);
		LocalDate parsedDate = LocalDate.parse(formatteddate, dateformatter);
		String formattedtime = timeformatter.format(LocalTime.now());
		LocalTime parsedTime = LocalTime.parse(formattedtime, timeformatter);
		
		String message = "Your request has been accepted by\n" + "Username: " + 
						 request.getParameter("offerusername") + "\nDate: " + request.getParameter("offerdate") 
						 + "\nTime: " + request.getParameter("offertime") 
		                 + "\nOrigin: " + request.getParameter("offerorigin") + "\nDestination: " 
		                 + request.getParameter("offerdestination");
		
		ps.setString(1, offerun);
		ps.setDate(3, java.sql.Date.valueOf(parsedDate));
		ps.setTime(4, java.sql.Time.valueOf(parsedTime));
		ps.setString(5, "Ride request accepted!");
		ps.setString(6, message);
		
		ps2.setInt(1, Integer.parseInt(request.getParameter("offerid")));

		RequestDispatcher rd = request.getRequestDispatcher("availableMatches.jsp");
		
   		String[] inviteList = request.getParameterValues("invited");
   		if (inviteList != null){
     		 for (int i = 0; i < inviteList.length; i++){
     			String corrected = inviteList[i].substring(0,inviteList[i].length() - 1);
     			String str = "SELECT Username FROM riderequests WHERE requestID = " + Integer.parseInt(corrected);
     			ResultSet result = stmt.executeQuery(str);
     			if(result.next()){
         			ps.setString(2, result.getString("Username"));
     				ps.executeUpdate();
     			}
     			ps2.setInt(2, Integer.parseInt(corrected));
     			ps2.executeUpdate();
     		 }
   		} else { 
   			request.setAttribute("inviteStatus", "<h4 style=\"color:red;\">Error: invites not sent!</h4>");
   			rd.forward(request, response);
   		}
   		
   		request.setAttribute("inviteStatus", "<h4 style=\"color:green;\">Invites sent!</h4>");
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
