<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Share - Create Ride Offer</title>
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
		String name = request.getParameter("name");
		String phoneNum = request.getParameter("phoneNum");
		String address = request.getParameter("address");
		String password = request.getParameter("password");
		//Make an update statement for the userlist table:
		String update;
		String insert;
		PreparedStatement ps;
		boolean error = false;
		boolean nameDigit = false;
		boolean phoneDigit = true;
		String user = (String)session.getAttribute("currentuser");
		
		for (int i = 0; i < Math.max(name.length(), phoneNum.length()); i++) 
	    {
	        if (phoneNum.length() > i + 1) 
	        {
	        	if(!Character.isDigit(phoneNum.charAt(i)))
	        	{
	        		phoneDigit = false;
	        	}
	        }
	        if (name.length() > i + 1) 
	        {
	        	if(Character.isDigit(name.charAt(i)))
	        	{
	        		nameDigit = true;
	        	}
	        }
	    }
		if (name.length() != 0 && !nameDigit)
		{
			update = "UPDATE userlist SET Name =\"" + name + "\" WHERE Username =\"" + user+ "\"";
			ps = con.prepareStatement(update);
			ps.executeUpdate();
		}
		else if (nameDigit)
		{
			request.setAttribute("nameFailed", "Invalid name");
			error = true;
		}
		
		if (phoneNum.length() <= 15 && phoneDigit && phoneNum.length() >= 7)
		{
			update = "UPDATE userlist SET PhoneNumber =\"" + phoneNum + "\" WHERE Username =\"" + user+ "\"";
			ps = con.prepareStatement(update);
			ps.executeUpdate();
		}
		else if (!phoneDigit)
		{
			request.setAttribute("phoneNumFailed", "Invalid phone number");
			error = true;
		}
		if (address.length() != 0)
		{
			update = "UPDATE userlist SET Address =\"" + address + "\" WHERE Username =\"" + user+ "\"";
			ps = con.prepareStatement(update);
			ps.executeUpdate();
		}
		if (password.length() != 0)
		{
			update = "UPDATE userlist SET Password =\"" + password + "\" WHERE Username =\"" + user+ "\"";
			ps = con.prepareStatement(update);
			ps.executeUpdate();
		}
		String str = "SELECT * FROM visibleUsers v WHERE v.Username =\"" + user+ "\"";
		ResultSet result = stmt.executeQuery(str);
		String values;
		if (result.next())
		{
			String sup;
			if (request.getParameter("Vis") == null)
			{
				sup = " ";
			}
			else
			{
				values = (String)request.getParameter("Vis");
				sup = values.substring(0, values.length()-1);
			}
			update = "UPDATE visibleUsers SET Name1 =\"" + sup + "\" WHERE Username =\"" + user+ "\"";
			ps = con.prepareStatement(update);
			ps.executeUpdate();
			
			if (request.getParameter("Vis2") == null)
			{
				
				sup = " ";
			}
			else
			{
				values = (String)request.getParameter("Vis2");
				sup = values.substring(0, values.length()-1);
			}
			update = "UPDATE visibleUsers SET PhoneNumber =\"" + sup + "\" WHERE Username =\"" + user+ "\"";
			ps = con.prepareStatement(update);
			ps.executeUpdate();
			
			if (request.getParameter("Vis3") == null)
			{
				sup = " ";
			}
			else
			{
				values = (String)request.getParameter("Vis3");
				sup = values.substring(0, values.length()-1);
			}
			update = "UPDATE visibleUsers SET Address =\"" + sup + "\" WHERE Username =\"" + user+ "\"";
			ps = con.prepareStatement(update);
			ps.executeUpdate();
			
			if (request.getParameter("Vis4") == null)
			{
				sup = " ";
			}
			else
			{
				values = (String)request.getParameter("Vis4");
				sup = values.substring(0, values.length()-1);
			}
			update = "UPDATE visibleUsers SET Email =\"" + sup + "\" WHERE Username =\"" + user+ "\"";
			ps = con.prepareStatement(update);
			ps.executeUpdate();
			ps.close();
		}
		else
		{
			str = "INSERT INTO visibleUsers(Username, Name1, Email, Address, PhoneNumber)"
					+ " VALUES (?, ?, ?, ?, ?)";
			ps = con.prepareStatement(str);
			ps.setString(1, user);
			values = (String)request.getParameter("Vis");
			String sub;
			
			if (values != null)
			{
				ps.setString(2, values.substring(0, values.length()-1));
			}
			else
			{
				ps.setString(2, null);
			}
			
			values = request.getParameter("Vis2");
			if (values != null)
			{
				ps.setString(3, values.substring(0, values.length()-1));
			}
			else
			{
				ps.setString(3, null);
			}
			
			values = request.getParameter("Vis3");
			if (values != null)
			{
				ps.setString(4, values.substring(0, values.length()-1));
			}
			else
			{
				ps.setString(4, null);
			}
			
			values = request.getParameter("Vis4");
			if (values != null)
			{
				ps.setString(5, values.substring(0, values.length()-1));
			}
			else
			{
				ps.setString(5, null);
			}
			ps.executeUpdate();
			ps.close();
		}
		if(error)
		{
			out.print("failed");
			RequestDispatcher ed = request.getRequestDispatcher("userSettings.jsp");
        	ed.forward(request, response);
		}
		else
		{
			//Run the query against the DB
			out.print("Insert successful! <br>");
			out.print("Namee: " + name + "<br>" +
					  "Phone Number: " + phoneNum + "<br>" +
					  "Address: " + address + "<br>" +
					  "Password: " + password+ "<br>");	
		}
		con.close();
	}
	catch (Exception ex) {
		ex.printStackTrace();
		out.print("Insert failed!");
	}
	%>
	
[<a href="userSettings.jsp">Back</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/newUserSettings.jsp">GitHub Page</a>]
	
</body>
</html>
	