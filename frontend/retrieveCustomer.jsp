<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fetch the Customers</title>
</head>
<body>
	<h2>Enter Range</h2>
	<!--
Form for collecting user input for the new movie_night record.
Upon form submission, add_customer.jsp file will be invoked.
-->
	<form action="gcustomers.jsp">
		<!-- The form organized in an HTML table for better clarity. -->
		<table border=1>
			<tr>
				<th colspan="2">Enter Range </th>
			</tr>
			<tr>
				<td>Category From:</td>
				<td><div style="text-align: center;">
						<input type=text name=lower>
					</div></td>
			</tr>
			<tr>
				<td>Category To:</td>
				<td><div style="text-align: center;">
						<input type=text name=limit>
					</div></td>
			</tr>

			<tr>
				<td><div style="text-align: center;">
						<input type=reset value=Clear>
					</div></td>
				<td><div style="text-align: center;">
						<input type=submit value=search>
					</div></td>
			</tr>
		</table>
	</form>
</body>
</html>