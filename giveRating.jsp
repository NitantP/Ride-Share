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
		try 
		{
			//Create a connection string
			String url = "jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "cs336project", "csteam14");
					
			Statement stmt = con.createStatement();
			
			String currentun = (String)session.getAttribute("currentuser");
			
			//Make a SELECT query from the users table with the username and password matches with the input
			String str = "SELECT * FROM acceptedRides WHERE Requester = \"" + currentun + "\"AND RatingGiven = 0";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			%>
			
			<FORM method = "POST" ACTION ="giveRatingController.jsp">
			<table border="1">
			<tr>
			<td>Username</td>
			<td>Time</td>
			<td>Date</td>
			<td>Origin</td>
			<td>Destination</td>
			</tr>
		
			<%      
			if(result.next())
			{
				//result.getString("Offerer")
					%>
					<tr>
					<td><%=result.getString("Offerer")%></td>
					<td><%=result.getString("Time")%></td>
					<td><%=result.getString("Date")%></td>
					<td><%=result.getString("Origin")%></td>
					<td><%=result.getString("Destination")%></td>
					</tr>
					
					<%
			}
			%>
			</table>
			<br>
			<table>
			<td>Rating:</td><td><input type="text" name="rating"></td>
			<%
				if(request.getAttribute("notNum") != null){
					out.print(request.getAttribute("notNum"));  
				}
			%>
			<td><input type=submit name=submit value="Give Rating"></td>
			</table>
			<%String ad = "SELECT * FROM adlist a WHERE a.TimesShown = (SELECT min(a1.TimesShown) FROM adlist a1)";
				result = stmt.executeQuery(ad);
				if (result.next())
				{
					%>
					<%=result.getString("Advert")%>
					<%
				}
				str = "UPDATE adlist SET TimesShown = TimesShown + 1 WHERE adID =\"" + result.getString("adID") + "\"";
				PreparedStatement ps = con.prepareStatement(str);
				ps.executeUpdate();
			%>

			</FORM>
		
	<%

			result.close();
			stmt.close();
			con.close();
		}
		catch (Exception ex) 
		{
			out.print("System failure");	
		}

%>
<br>
<br>
[<a href="homepage.jsp">Skip rating</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/giveRating.jsp">GitHub Page</a>] 
</body>
</html>