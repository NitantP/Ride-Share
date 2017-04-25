<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Send Message</title>
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
		
		String sender = (String)session.getAttribute("currentuser");
		String recipient = request.getParameter("recipient");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
		LocalDate date = LocalDate.now(ZoneId.of("America/Montreal")); 
		DateTimeFormatter dateformatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		DateTimeFormatter timeformatter = DateTimeFormatter.ofPattern("HH:mm:ss");
		String formatteddate = date.format(dateformatter);
		LocalDate parsedDate = LocalDate.parse(formatteddate, dateformatter);
		String formattedtime = timeformatter.format(LocalTime.now());
		LocalTime parsedTime = LocalTime.parse(formattedtime, timeformatter);
		
		//Make an insert statement for the Ride Offers table:
		String insert = "INSERT INTO SEND_EMAIL(Sender, Recipient, Date, Time, Subject, Content)"
						+ " VALUES (?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, sender);
		ps.setString(2, recipient);
		ps.setDate(3, java.sql.Date.valueOf(parsedDate));
		ps.setTime(4, java.sql.Time.valueOf(parsedTime));
		ps.setString(5, subject);
		ps.setString(6, content);
		
		//INSERT INPUT CHECKS HERE
		
		RequestDispatcher rd = request.getRequestDispatcher("createMessage.jsp");
		
		if(sender.equals(recipient)){
			request.setAttribute("messageStatus", "<h4 style=\"color:red;\">Error: cannot send message to self!</h4>");
		} else if(content.length() > 200){
			request.setAttribute("messageStatus", "<h4 style=\"color:red;\">Error: message too long! (> 100)</h4>");
		} else {
			ps.executeUpdate();
			request.setAttribute("messageStatus", "<h4 style=\"color:green;\">Message sent!</h4>");
		}
		
		con.close();
		
        rd.forward(request, response);
            
	}
	catch (Exception ex) {
		ex.printStackTrace();
		out.print("Insert failed!");
	}
%>

</body>
</html>