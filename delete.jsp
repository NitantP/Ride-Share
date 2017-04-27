<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
		String str = "";
		String[] deleteList = request.getParameterValues("deleteid");
		
		if (deleteList != null){
			if(request.getParameter("deletetype").equals("offer")){
	     		for (int i = 0; i < deleteList.length; i++){
	     			str = "DELETE FROM rideoffers WHERE offerID = " + Integer.parseInt(deleteList[i]);
	     			stmt.executeUpdate(str);
	     		}
			} else if(request.getParameter("deletetype").equals("request")){
				for (int i = 0; i < deleteList.length; i++){
	     			str = "DELETE FROM riderequests WHERE requestID = " + Integer.parseInt(deleteList[i]);
	     			stmt.executeUpdate(str);
	     		}
			} else {
				for (int i = 0; i < deleteList.length; i++){
					String[] deleteInfo = deleteList[i].split(",");
					str = "DELETE FROM SEND_EMAIL WHERE Sender = \"" + deleteInfo[0] + "\" AND Date = \"" + deleteInfo[1] + "\" AND Time = \"" + deleteInfo[2] + "\"";
	     			stmt.executeUpdate(str);
				}
			}
	   	} else {
	   		out.println("Nothing selected!");
	   	}
		
		stmt.close();
		con.close();
		
		out.println("<b>Selected items successfully deleted from tables<b>");
	   	
	} catch (Exception ex){
		ex.printStackTrace();
		out.println("Something went wrong!");
	}
%>	
<br>	
<br>
[<a href="createRideOffer.jsp">Offers</a>] [<a href="createRideRequest.jsp">Requests</a>] [<a href="messageIndex.jsp">Messages</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/delete.jsp">GitHub Page</a>]

</body>
</html>