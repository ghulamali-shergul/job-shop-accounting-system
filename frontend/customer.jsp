<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Query Result</title>
</head>
<body>
	<%@page import="jspazuretest.DataHandle"%>
	<%@page import="java.sql.ResultSet"%>
	<%@page import="java.sql.Array"%>
	<%
	// The handler is the one in charge of establishing the connection.
	DataHandle handle = new DataHandle();
	// Get the attribute values passed from the input form.
	String lower = request.getParameter("lower");
	String limit = request.getParameter("limit");

	if (lower.equals("") || limit.equals("")) {
		response.sendRedirect("Rcustomers.jsp");
	} else {
		int lower1 = Integer.parseInt(lower);
		int upper = Integer.parseInt(limit);
		final ResultSet Customer = handle.fetchCustomers(lower1, upper);
	%>
	<!-- The table for displaying all the movie records -->
	<table cellspacing="2" cellpadding="2" border="1">
		<tr>
			<!-- The table headers row -->
			<td align="center">
				<h4>Name</h4>
			</td>
			<td align="center">
				<h4>Address</h4>
			</td>
			<td align="center">
				<h4>Category</h4>
			</td>
		</tr>
		<%
		while (Customer.next()) {
			String name = Customer.getString("customer_name");
			String address = Customer.getString("customer_address");
			String category = Customer.getString("category");
			out.println("<tr>"); 
			out.println(
			"<td align=\"center\">" + name + "<td align=\"center\">" + address + "<td align=\"center\">" + category
					+ "</td>");
			out.println("</tr>");
		}

		}
		%>
	
</body>
</html>