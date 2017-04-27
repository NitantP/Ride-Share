<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>newUser</title>
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
		//Get parameters from the HTML form at the main.jsp		
		String newRUID = request.getParameter("ruid");
		String newEmail = request.getParameter("email");
		String newUsername = request.getParameter("username");
		String newPassword = request.getParameter("password");
		String newName = request.getParameter("name");
		String newAddress = request.getParameter("address");
		String newPhoneNum = request.getParameter("phoneNum");
		
		String checkRUID = "SELECT b.RUID FROM banlist b WHERE RUID = \"" + newRUID + "\"";
		String checkEmail = "SELECT b.Email FROM banlist b WHERE Email = \"" + newEmail + "\"";
		ResultSet result = stmt.executeQuery(checkRUID);
		boolean ruid = result.next();
		result = stmt.executeQuery(checkEmail);
		boolean email = result.next();
		
		System.out.println(ruid + " " + email);
		if (email || ruid)
		{
			request.setAttribute("Banned", "You're banned");
			RequestDispatcher ed = request.getRequestDispatcher("register.jsp");
        	ed.forward(request, response);
		}
		//Make an insert statement for the Users table:
		String insert = "INSERT INTO userlist(RUID, Email, Username, Password, AccountType, Name1, Address, PhoneNumber)"
				+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert);
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, newRUID);
		ps.setString(2, newEmail);
		ps.setString(3, newUsername);
		ps.setString(4, newPassword);
		ps.setString(5, "User");
		ps.setString(6, newName);
		ps.setString(7, newAddress);
		ps.setString(8, newPhoneNum);
		
		String userDup = "SELECT * FROM userlist c WHERE c.Username = \"" + newUsername + "\"";
		String emailDup = "SELECT * FROM userlist c WHERE c.Email = \"" + newEmail + "\"";
		String RUIDDup = "SELECT * FROM userlist c WHERE c.RUID = \"" + newRUID + "\"";
		String update;
		boolean nameDigit = false;
		boolean phoneDigit = true;
		boolean isDigit = true;
		boolean error = false;
		
		int max = Math.max(newName.length(), newPhoneNum.length());
	    
	    for (int i = 0; i < Math.max(newRUID.length(), max); i++) 
	    {
	    	if (newRUID.length() > i + 1)
	    	{
		        if (!Character.isDigit(newRUID.charAt(i))) 
		        {
		        	isDigit = false;
		        }
	    	}
	        if (newPhoneNum.length() > i + 1) 
	        {
	        	if(!Character.isDigit(newPhoneNum.charAt(i)))
	        	{
	        		phoneDigit = false;
	        	}
	        }
	        if (newName.length() > i + 1) 
	        {
	        	if(Character.isDigit(newName.charAt(i)))
	        	{
	        		nameDigit = true;
	        	}
	        }
	    }
	
	    result = stmt.executeQuery(RUIDDup);
	    //ruid follows the format
		if(newRUID.length() != 9 || !isDigit)
		{
				request.setAttribute("RUIDFailed", "Invalid RUID (must be 9 digits!)");
				error = true;
		}//there is a duplicate
		else if (result.next())
		{
			request.setAttribute("RUIDFailed", "Duplicate RUID");
			error = true;
		}
		
		result = stmt.executeQuery(emailDup);
		//email from rutgers
		if (!newEmail.toLowerCase().contains("@rutgers.edu") || newEmail.substring(newEmail.indexOf("@")).equals("rutgers.edu"))
		{
			request.setAttribute("emailFailed", "Invalid email (must be an @rutgers.edu address!)");
			error = true;
		}//there is a duplicate
		else if (result.next())
		{
			request.setAttribute("emailFailed", "Duplicate Email");
			error = true;
		}
		
		result = stmt.executeQuery(userDup);
		//username is empty
		if(newUsername.isEmpty())
		{
			request.setAttribute("userFailed", "Invalid username (cannot be blank!)");
			error = true;
		}//there is a duplicate
		else if (result.next())
		{
			request.setAttribute("userFailed", "Duplicate Username");
			error = true;
		}
		
		//password is empty
		if(newPassword.isEmpty())
		{
			request.setAttribute("passFailed", "Invalid password (cannot be blank!)");
			error = true;
		}

		//digit in the name
		if (nameDigit)
		{
			request.setAttribute("nameFailed", "Invalid name");
			error = true;
		}
		
		//phone is not a digit
		if (!phoneDigit || (newPhoneNum.length() != 0 && (newPhoneNum.length() < 7 || newPhoneNum.length() > 15)))
		{
			request.setAttribute("phoneNumFailed", "Invalid phone number");
			error = true;
		}


		if (error)
		{
			RequestDispatcher ed = request.getRequestDispatcher("register.jsp");
        	ed.forward(request, response);
		}
		else
		{
			//Run the query against the DB
			ps.executeUpdate();
			
			out.print("Insert successful! <br>");
			out.print("RUID: " + newRUID + "<br>" +
					  "Username: " + newUsername + "<br>" +
					  "Password: " + newPassword + "<br>" +
					  "Email: " + newEmail + "<br>");	
			session.setAttribute("currentuser", newUsername);
			RequestDispatcher ed = request.getRequestDispatcher("carSettings.jsp");
        	ed.forward(request, response);
			//setTimeOut(ed.forward(request, response), 1000);
		}
		con.close();

	}
	catch (Exception ex) {
		ex.printStackTrace();
		out.print("Insert failed!");
	}
	%>
<br>
<br>
[<a href="index.jsp">Login</a>] [<a href="https://github.com/NitantP/Ride-Share/blob/master/newUser.jsp">GitHub Page</a>] 
	
</body>
</html>