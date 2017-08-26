<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Available Matches</title>
</head>
<body>

<!-- Page to display all available ride invites based on matched ride offers -->

<%
      if(request.getAttribute("acceptStatus") != null){
   		 out.print(request.getAttribute("acceptStatus")); 
      } else {
		try {
		//Create a connection string
		String url = "jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "cs336project", "csteam14");
		//Create an SQL statement
		Statement stmt = con.createStatement();
		
		String currentun = (String)session.getAttribute("currentuser");
		
		int requestid = Integer.parseInt(request.getParameter("invited"));
		
		String str = "SELECT * FROM userlist U, rideoffers O, possibleMatches P, carlist C WHERE O.LicensePlate = C.LicensePlate AND O.Username = U.Username AND O.offerID = P.offerID AND P.requestID = " + requestid + " AND U.Username IN (SELECT O.Username FROM rideoffers O WHERE O.offerId IN (SELECT offerID FROM possibleMatches WHERE requestID = " + requestid + "))";

		ResultSet result = stmt.executeQuery(str);
%>

		<FORM method = "POST" ACTION ="acceptInvites.jsp">
		<table border="1">
		<tr>
		<td>Accept</td>
		<td>Username</td>
		<td>Rides Given</td>
		<td>Rides Taken</td>
		<td>Rating</td>
		<td>Times Reported</td>
		<td>License Plate</td>
		<td>Make</td>
		<td>Model</td>
		<td>Year</td>
		</tr>

<%      //Display all available ride invites (based on matches)
		while(result.next()) {
		%>
		<tr>
		<td><input type=radio name=offerid value = <%=result.getInt("O.offerID")%>/></td>
		<td><%=result.getString("U.Username") %></td>
		<td align="center"><%=result.getInt("U.RidesGiven") %></td>
		<td align="center"><%=result.getInt("U.RidesTaken") %></td>
		<td align="center"><%=result.getDouble("U.Rating") %></td>
		<td align="center"><%=result.getInt("U.Reported") %></td>
		<td><%=result.getString("O.LicensePlate") %>
		<td><%=result.getString("C.Make") %>
		<td><%=result.getString("C.Model") %>
		<td><%=result.getString("C.Year") %>
		</tr>
		
		<%

		}
		%>
		</table>
		<br>
		<input type=submit name=submit value="Accept Invite">

		<input type='hidden' name='requestid' value=<%=requestid%>>

</FORM>
		
	<%
		
		result.close();
		stmt.close();
		con.close();
		
		} catch (Exception ex) {
			out.print("System failure");	
		}
      }
%>

<br>
<br>
[<a href="availableMatchesIntermediate.jsp">Back</a>] [<a href="homepage.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/availableInvites.jsp">GitHub Page</a>] [<a href="index.jsp">Logout</a>] 

</body>
</html>