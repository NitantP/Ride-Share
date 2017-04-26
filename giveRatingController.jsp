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
<% 
		
		try {
		//Create a connection string
		String url = "jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "cs336project", "csteam14");
		Statement stmt = con.createStatement();
		double ratingDub = 0;
		int ridesGiven = 0;
		PreparedStatement ps;
		String rating = request.getParameter("rating");
		String cun = (String)session.getAttribute("currentuser");
		String str = "SELECT * FROM acceptedRides WHERE Requester= \"" + cun + "\" AND RatingGiven = 0";
		ResultSet result = stmt.executeQuery(str);
		if (!Character.isDigit(rating.charAt(0)) || rating.length() != 1)
		{
			out.println("test1");
			request.setAttribute("notNum", "Enter a number 1 - 5");
			RequestDispatcher ed = request.getRequestDispatcher("giveRating.jsp");
        	ed.forward(request, response);
		}
		else
		{
			if(result.next())
			{
				String dest = result.getString("Destination");
				String origin = result.getString("Origin");
				String date = result.getString("Date");
				String otherUser = result.getString("Offerer");
				str = "SELECT * FROM userlist WHERE Username= \"" + otherUser + "\"";
				result = stmt.executeQuery(str);
				if (result.next())
				{
					out.println("test2");
					ridesGiven = Integer.parseInt((String)result.getString("RidesGiven"));
					if (ridesGiven == 1)
					{
						ratingDub = Integer.parseInt(rating);
					}
					else
					{
						ratingDub = Double.parseDouble((String)result.getString("Rating"));
						ratingDub *= ridesGiven;
						ridesGiven += 1;
						ratingDub += Integer.parseInt(rating);
						ratingDub /= ridesGiven;
					}
					str = "UPDATE userlist SET Rating =\"" + ratingDub + "\" WHERE Username =\"" + otherUser+ "\"";
					ps = con.prepareStatement(str);
					ps.executeUpdate();
					str = "UPDATE userlist SET HasRating = HasRating - 1 WHERE Username =\"" + cun+ "\"";
					ps = con.prepareStatement(str);
					ps.executeUpdate();
					str = "UPDATE acceptedRides SET RatingGiven = 1 WHERE Requester =\"" + cun+ "\" AND RatingGiven = 0 AND Origin =\"" + origin +
							"\" AND Destination =\"" + dest + "\" AND Date =\"" + date + "\" AND Offerer =\"" + otherUser + "\"";
					ps = con.prepareStatement(str);
					ps.executeUpdate();
					RequestDispatcher rd = request.getRequestDispatcher("homepage.jsp");
		            rd.forward(request, response);
				}
			}
		}

		con.close();
		
		}	catch (Exception ex) {
			ex.printStackTrace();
			out.print("System failure");	
		}
%>

<br>
[<a href="https://github.com/NitantP/Ride-Share/blob/master/giveRatingController.jsp">GitHub Page</a>] 

</body>
</html>