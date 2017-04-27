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

<%
      if(request.getAttribute("inviteStatus") != null){
   		 out.print(request.getAttribute("inviteStatus")); 
      } else {
		try {
		//Create a connection string
		String url = "jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "cs336project", "csteam14");
				
		Statement stmt = con.createStatement();
		
		String currentun = (String)session.getAttribute("currentuser");
		
		int offerid = Integer.parseInt(request.getParameter("offer"));
		
		//Make a SELECT query from the users table with the username and password matches with the input
		String str = "SELECT * FROM rideoffers O, riderequests R WHERE O.offerId = " + offerid + " AND O.Origin = R.Origin AND O.Destination = R.Destination AND O.Time = R.Time AND O.Date = R.Date AND R.NumPassengers <= O.MaxPassengers ORDER BY R.requestID ASC";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		
		String offerdate = "";
		String offertime = "";
		String offerorigin = "";
		String offerdestination = "";
%>

<FORM method = "POST" ACTION ="sendInvites.jsp">
		<table border="1">
		<tr>
		<td>Invite</td>
		<td>Username</td>
		<td>Date</td>
		<td>Time</td>
		<td>Number of Passengers</td>
		<td>Origin</td>
		<td>Destination</td>
		</tr>

<%      
		while(result.next())
		{
			  if(result.isLast()){
			  	offerdate = result.getString("O.Date");
			  	offertime = result.getString("O.Time");
			  	offerorigin = result.getString("O.Origin");
			  	offerdestination = result.getString("O.Destination");
			  }
		%>
		<tr>
		<td><input type=checkbox name=invited value = <%=result.getInt("R.requestID")%>/></td>
		<td><%=result.getString("R.Username") %></td>
		<td><%=result.getString("R.Date") %></td>
		<td><%=result.getString("R.Time") %></td>
		<td align="center"><%=result.getString("R.NumPassengers") %></td>
		<td><%=result.getString("R.Origin") %></td>
		<td><%=result.getString("R.Destination") %></td>
		</tr>
		
		<%

		}
		%>
		</table>
		<br>
		<input type=submit name=submit value="Send Invites">

		<input type='hidden' name='offerid' value=<%=offerid%>>
		<input type='hidden' name='offerusername' value=<%=currentun%>>
		<input type='hidden' name='offerdate' value=<%=offerdate%>>
		<input type='hidden' name='offertime' value=<%=offertime%>>
		<input type='hidden' name='offerorigin' value=<%=offerorigin%>>
		<input type='hidden' name='offerdestination' value=<%=offerdestination%>>

</FORM>
		
	<%
		
		result.close();
		stmt.close();
		con.close();
		
		}	catch (Exception ex) {
			out.print("System failure");	
		}
      }
%>

<br>
<br>
[<a href="availableMatchesIntermediate.jsp">Back</a>] [<a href="homepage.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/availableMatches.jsp">GitHub Page</a>] [<a href="index.jsp">Logout</a>] 

</body>
</html>