<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - System Support</title>
</head>
<body>

<b>Advertisements page</b>
<br>
<br>
	<%
      if(request.getAttribute("adStatus") != null){
   		 out.print(request.getAttribute("adStatus"));  
      }
    %> 
    
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
%>
		<b>Ads List</b>
		<form method="post" action="delete.jsp">
		<table border="1">
		<tr>
		<td>Delete?</td>
		<td>adID</td>
		<td>Company</td>
		<td>Advertisement</td>
		<td>Times Shown</td>
		<td>Price per view</td>
		</tr>

		<%   
		while(result.next())
		{
		%>	
		<tr>
		<td><input type="checkbox" name="deleteid" value=<%=result.getInt("adID")%>></td>
		<td><%=result.getInt("adID") %></td>
		<td><%=result.getString("Company") %></td>
		<td><%=result.getString("Advert") %></td>
		<td align="center"><%=result.getInt("TimesShown") %></td>
		<td><%=result.getString("Price")%></td>
		</tr>
		<%
		}
		%>
		</table>
		<br>
		<input type="submit" name="submit4" value="Delete ads">
		<input type="hidden" name="deletetype" value="ad">
		</form>
	<%
		result.close();
		stmt.close();
		con.close();
	} catch (Exception ex){
		ex.printStackTrace();
		out.println("Failure!");
	}
		%>
<br>
<br>
	<form method="post" action="newAd.jsp">
	<table>
	<tr>    
	<td>Company: </td><td><input type="text" name="company"></td>
	</tr>
	<tr>
	<td>Advertisement: </td><td><textarea rows="4" cols="25" name="advert"></textarea></td>
	</tr>
	<tr>
	<td>Price: </td><td><input type="text" name="price"></td>
	</tr>
	</table>
	<br>
	<input type="submit" value="Add new advertisement">
	</form>
<br>

<br>

[<a href="systemIndex.jsp">Main page</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/createAd.jsp">GitHub Page</a>] [<a href="index.jsp">Logout</a>] 

</body>
</html>