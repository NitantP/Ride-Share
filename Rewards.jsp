<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rewards</title>
</head>
<body>
Rewards
		<%
		try 
		{
			//Create a connection string
			String url = "jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "cs336project", "csteam14");
					
			Statement stmt = con.createStatement();
			String str = "SELECT * FROM userlist WHERE Username = \"" + (String)session.getAttribute("currentuser") + "\"";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			<FORM method = "POST" >
			<table border="1">
			<tr>
			<td>Username</td>
			<td>Rewards</td>
			<td>RidesGiven</td>
			<td>RidesTaken</td>
			</tr>
		  <%
			if(result.next())
			{
					%>
					<tr>
					<td><%=result.getString("Username")%></td>
					<td>$<%=result.getString("Rewards")%></td>
					<td><%=result.getString("RidesGiven")%></td>
					<td><%=result.getString("RidesTaken")%></td>
					</tr>
					<%
			}
			%>
			</table>
			<br>

			</FORM>
			
	<% 
	String[] ridesgiven = new String[12];
	for(int i = 1; i <= 12; i++){
		str = "SELECT COUNT(*) AS total FROM acceptedRides WHERE Offerer = \"" + (String)session.getAttribute("currentuser") + "\" AND MONTH(Date) = " + i;
		result = stmt.executeQuery(str);
		if(result.next()){
			ridesgiven[i-1] = result.getString("total");
		} else {
			ridesgiven[i-1] = "0";
		}
	}
	
	String[] ridestaken = new String[12];
	for(int i = 1; i <= 12; i++){
		str = "SELECT COUNT(*) AS total FROM acceptedRides WHERE Requester = \"" + (String)session.getAttribute("currentuser") + "\" AND MONTH(Date) = " + i;
		result = stmt.executeQuery(str);
		if(result.next()){
			ridestaken[i-1] = result.getString("total");
		} else {
			ridestaken[i-1] = "0";
		}
	}
	%>
			<br>
			<b>Rides by Month</b>
			<table border="1">
			<tr>
			<td>Month</td>
			<td>January</td>
			<td>February</td>
			<td>March</td>
			<td>April</td>
			<td>May</td>
			<td>June</td>
			<td>July</td>
			<td>August</td>
			<td>September</td>
			<td>October</td>
			<td>November</td>
			<td>December</td>
			</tr>
			<tr>
			<td>Rides Given</td>
			<td align="center"><%=ridesgiven[0]%></td>
			<td align="center"><%=ridesgiven[1]%></td>
			<td align="center"><%=ridesgiven[2]%></td>
			<td align="center"><%=ridesgiven[3]%></td>
			<td align="center"><%=ridesgiven[4]%></td>
			<td align="center"><%=ridesgiven[5]%></td>
			<td align="center"><%=ridesgiven[6]%></td>
			<td align="center"><%=ridesgiven[7]%></td>
			<td align="center"><%=ridesgiven[8]%></td>
			<td align="center"><%=ridesgiven[9]%></td>
			<td align="center"><%=ridesgiven[10]%></td>
			<td align="center"><%=ridesgiven[11]%></td>
			</tr>
			<tr>
			<td>Rides Taken</td>
			<td align="center"><%=ridestaken[0]%></td>
			<td align="center"><%=ridestaken[1]%></td>
			<td align="center"><%=ridestaken[2]%></td>
			<td align="center"><%=ridestaken[3]%></td>
			<td align="center"><%=ridestaken[4]%></td>
			<td align="center"><%=ridestaken[5]%></td>
			<td align="center"><%=ridestaken[6]%></td>
			<td align="center"><%=ridestaken[7]%></td>
			<td align="center"><%=ridestaken[8]%></td>
			<td align="center"><%=ridestaken[9]%></td>
			<td align="center"><%=ridestaken[10]%></td>
			<td align="center"><%=ridestaken[11]%></td>
			</tr>

			</table>
			
	<%
		}
		catch (Exception ex) 
		{
			out.print("System failure");	
		}
	%>
	
<br>
<br>
[<a href="homepage.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/Rewards.jsp">GitHub Page</a>] 
</body>
</html>