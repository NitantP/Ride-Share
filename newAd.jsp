<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Add ad</title>
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
		//Get parameters from the HTML form at the createRideOffer.jsp		
		String company = request.getParameter("company");
		String advert = request.getParameter("advert");
		String price = request.getParameter("price");
		
		//Make an insert statement for the Ride Offers table:
		String insert = "INSERT INTO adlist(Company, Advert, TimesShown, Price)"
		 				+ " VALUES (?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, company);
		ps.setString(2, advert);
		ps.setInt(3, 0);
		ps.setString(4, price);
		
		RequestDispatcher rd = request.getRequestDispatcher("createAd.jsp");
		
		if(company == null || company.equals("")){
			request.setAttribute("adStatus", "<h4 style=\"color:red;\">Error: need company name!</h4>");
		} else if(advert.length() > 100){
			request.setAttribute("adStatus", "<h4 style=\"color:red;\">Error: advertisement too long! (> 100)</h4>");
		} else {
			ps.executeUpdate();
			request.setAttribute("adStatus", "<h4 style=\"color:green;\">Ad inserted!</h4>");
		}
		

		con.close();
		
        rd.forward(request, response);
		
	} catch (Exception ex) {
		ex.printStackTrace();
		out.print("Insert failed!");
	}	
%>

</body>
</html>