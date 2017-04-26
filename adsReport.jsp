<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.DecimalFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Ads Report</title>
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
		
		//Make a SELECT query from the users table with the username and password matches with the input
		String str = "SELECT * FROM adlist";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		
		DecimalFormat format = new DecimalFormat("0.##");
		double totalBill = 0;
%>
		<b>Ads Report</b>
		<table border="1">
		<tr>
		<td>adID</td>
		<td>Company</td>
		<td>Advertisement</td>
		<td>Times Shown</td>
		<td>Price per view</td>
		<td><b>Total to Bill</b></td>
		</tr>

		<%   
		while(result.next())
		{
		%>	
		<tr>
		<td><%=result.getInt("adID") %></td>
		<td><%=result.getString("Company") %></td>
		<td><%=result.getString("Advert") %></td>
		<td align="center"><%=result.getInt("TimesShown") %></td>
		<td><%=result.getString("Price") %></td>
		<td><%=format.format(result.getInt("TimesShown") * Double.parseDouble(result.getString("Price"))) %>
		</tr>
		<%
		totalBill += result.getInt("TimesShown") * Double.parseDouble(result.getString("Price"));
		}
		%>
		<tr>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td>TOTAL: </td>
		<td><%=format.format(totalBill) %>
		</table>
	<%	
		result.close();
		stmt.close();
		con.close();
		
		}	catch (Exception ex) {
			out.print("System failure");	
		}
	%>
<br>
<br>
[<a href="systemIndex.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/adsReport.jsp">GitHub Page</a>] 
</body>
</html>