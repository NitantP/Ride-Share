<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Statistics</title>
</head>
<body>

<!-- Runs queries to generate a statistics report -->
<!-- Takes from Stats.jsp -->

<%
	try {
		//Create a connection string
		String url = "jdbc:mysql://cs336finalproject.cl75kudzatsx.us-east-1.rds.amazonaws.com:3306/users";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "cs336project", "csteam14");
				
		Statement stmt = con.createStatement();
		ResultSet result = null;
		
		String str = "";
		
		//Query type 1
		if(request.getParameter("submit1") != null){
			String input = request.getParameter("input");
			String querytype1 = request.getParameter("querytype1");
			if(querytype1.equals("username")){
				str = "SELECT * FROM acceptedRides WHERE Offerer = \"" + input + "\" OR Requester = \"" + input + "\"";
			} else if(querytype1.equals("date")){
				str = "SELECT * FROM acceptedRides WHERE Date = \"" + input + "\"";
			} else if(querytype1.equals("time")){
				str = "SELECT * FROM acceptedRides WHERE Time = \"" + input + "\"";
			} else if(querytype1.equals("origin")){
				str = "SELECT * FROM acceptedRides WHERE Origin = \"" + input + "\"";
			} else if(querytype1.equals("destination")){
				str = "SELECT * FROM acceptedRides WHERE Destination = \"" + input + "\"";
			} else {
				out.println("No valid query type!");
				return;
			}
			result = stmt.executeQuery(str);
	
%>	
			<b>Results for query (<%=input%>,<%=querytype1%>);</b>	
			<br>
			<table border="1">
			<tr>
			<td>Offer ID</td>
			<td>Request ID</td>
			<td>Offerer</td>
			<td>Requester</td>
			<td>Time</td>
			<td>Date</td>
			<td>Origin</td>
			<td>Destination</td>
			</tr>

		<%  //Display results of query type 1
			while(result.next())
			{
		%>	
			<tr>
			<td align="center"><%=result.getInt("offerID") %></td>
			<td align="center"><%=result.getInt("requestID") %></td>
			<td><%=result.getString("Offerer") %></td>
			<td><%=result.getString("Requester") %></td>
			<td><%=result.getString("Time") %></td>
			<td><%=result.getString("Date") %></td>
			<td><%=result.getString("Origin") %></td>
			<td><%=result.getString("Destination") %></td>
			</tr>
			<%
			}
			%>
			</table>
		<%
		//Query type 2
		} else if(request.getParameter("submit2") != null) {
			String input1 = request.getParameter("input1");
			String input2 = request.getParameter("input2");
			String querytype2 = request.getParameter("querytype2");
			if(querytype2.equals("date")){
				str = "SELECT * FROM acceptedRides WHERE Date >= \"" + input1 + "\" AND Date <= \"" + input2 + "\"";
			} else if(querytype2.equals("time")){
				str = "SELECT * FROM acceptedRides WHERE Time >= \"" + input1 + "\" AND Time <= \"" + input2 + "\"";
			} else {
				out.println("No valid query type!");
				return;
			}
			result = stmt.executeQuery(str);
%>	
			<b>Results for query (<%=input1%>,<%=input2%>,<%=querytype2%>);</b>
			<br>
			<table border="1">
			<tr>
			<td>Offer ID</td>
			<td>Request ID</td>
			<td>Offerer</td>
			<td>Requester</td>
			<td>Time</td>
			<td>Date</td>
			<td>Origin</td>
			<td>Destination</td>
			</tr>

		<%  //Display results of query type 2 
			while(result.next())
			{
		%>	
			<tr>
			<td align="center"><%=result.getInt("offerID") %></td>
			<td align="center"><%=result.getInt("requestID") %></td>
			<td><%=result.getString("Offerer") %></td>
			<td><%=result.getString("Requester") %></td>
			<td><%=result.getString("Time") %></td>
			<td><%=result.getString("Date") %></td>
			<td><%=result.getString("Origin") %></td>
			<td><%=result.getString("Destination") %></td>
			</tr>
			<%
			}
			%>
			</table>
		<%	
		//Query type 3
		} else {
			String input3 = request.getParameter("input3");
			String querytype3 = request.getParameter("querytype3");
			if(querytype3.equals("month")){
				str = "SELECT * FROM acceptedRides WHERE MONTH(Date) = " + input3;
			} else if(querytype3.equals("year")){
				str = "SELECT * FROM acceptedRides WHERE YEAR(Date) = " + input3;
			} else {
				out.println("No valid query type!");
				return;
			}
			result = stmt.executeQuery(str);
		%>	
			<b>Results for query (<%=input3%><%=querytype3%>);</b>
			<br>
			<table border="1">
			<tr>
			<td>Offer ID</td>
			<td>Request ID</td>
			<td>Offerer</td>
			<td>Requester</td>
			<td>Time</td>
			<td>Date</td>
			<td>Origin</td>
			<td>Destination</td>
			</tr>

		<%  //Display results of query type 3 
			while(result.next())
			{
		%>	
			<tr>
			<td align="center"><%=result.getInt("offerID") %></td>
			<td align="center"><%=result.getInt("requestID") %></td>
			<td><%=result.getString("Offerer") %></td>
			<td><%=result.getString("Requester") %></td>
			<td><%=result.getString("Time") %></td>
			<td><%=result.getString("Date") %></td>
			<td><%=result.getString("Origin") %></td>
			<td><%=result.getString("Destination") %></td>
			</tr>
			<%
			}
			%>
			</table>
		<%	
		}
			result.close();
			stmt.close();
			con.close();
		} catch (Exception ex){
			ex.printStackTrace();
			out.println("Query failed!");
		}
		
%>
<br>
<br>
[<a href="Stats.jsp">Another query</a>] [<a href="adminIndex.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/StatsDisplay.jsp">GitHub Page</a>] 
</body>
</html>