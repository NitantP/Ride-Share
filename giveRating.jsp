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
			String giver = "";
			PreparedStatement ps;
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
				String offerer = result.getString("Offerer");
				giver = result.getString("Offerer");
				String time = result.getString("Time");
				String date = result.getString("Date");
				String origin = result.getString("Origin");
				String destination = result.getString("Destination");
				session.setAttribute("time", time);
				session.setAttribute("date", date);
				session.setAttribute("origin", origin);
				session.setAttribute("destination", destination);
				session.setAttribute("offerer", offerer);
				str = "UPDATE userlist SET HasRating = HasRating - 1 WHERE Username =\"" + (String)session.getAttribute("currentuser") + "\"";
				ps = con.prepareStatement(str);
				ps.executeUpdate();
				str = "UPDATE acceptedRides SET RatingGiven = 1 WHERE Requester =\"" + (String)session.getAttribute("currentuser") + 
						"\" AND RatingGiven = 0 AND Origin =\"" + origin +
						"\" AND Destination =\"" + destination + "\" AND Date =\"" + date + "\" AND Offerer =\"" + offerer + "\"";
				ps = con.prepareStatement(str);
				ps.executeUpdate();
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
			<p></p>
			<tr>
			<td>Comments</td>
			<td><textarea rows="4" cols="25" name="comments"></textarea>
			</tr>
			</p>
			<tr>
			<td>Report<input type=checkbox name=check value = hello/></td>
			</tr>
			<td><input type=submit name=submit value="Give Feedback"></td>
			</table>
			<p></p>
			
			
			<%String ad = "SELECT * FROM adlist a WHERE a.TimesShown = (SELECT min(a1.TimesShown) FROM adlist a1)";
				result = stmt.executeQuery(ad);
				if (result.next())
				{
					String amount = result.getString("Price");
					String updateReward = "UPDATE userlist SET Rewards = Rewards + \"" + Double.parseDouble(amount) + "\" WHERE Username = \"" + giver + "\"";
					ps = con.prepareStatement(updateReward);
					ps.executeUpdate();
					%>
					<p></p>
					<%result.getString("Advert");
				}
				str = "UPDATE adlist SET TimesShown = TimesShown + 1 WHERE adID =\"" + result.getString("adID") + "\"";
				ps = con.prepareStatement(str);
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
[<a href="homepage.jsp">Skip to main page</a>]
<br>
<br>
[<a href="https://github.com/NitantP/Ride-Share/blob/master/giveRating.jsp">GitHub Page</a>] [<a href="index.jsp">Logout</a>]
</body>
</html>