import java.time.format.DateTimeFormatter;
import java.io.*;
import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Scanner;


public class Doulat_GhulamAli_Name_IP_Task5b {
		/*
		 * @author: Ghulam Ali Doulat
		 * @OUID: 113493774
		 * @CourseName: Database Management Systems
		 * 
		 * 
		 *
		 */
	
		final static String HOSTNAME = "doul0000.database.windows.net";
		final static String DBNAME = "cs-dsa-4513-sql-db";
		final static String USERNAME = "doul0000";
		final static String PASSWORD = "Sultanabad123";
		
		
		// Database Connecting string URL
		final static String URL = String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;"
				+ "trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;",
	            HOSTNAME, DBNAME, USERNAME, PASSWORD);
		
		
		
		// the below code briefly describes the format of the query procedures
		final static String queryFormat1 = "EXEC AddCustomer @CustomerName = ?, @Customer_Address = ?, @category = ?;";
		final static String queryFormat2 = "EXEC AddDepartment @DepartmentNum = ?, @department_data = ?;";
		final static String queryFormat3 = "EXEC AddProcessViaDepartment @ProcessID = ?, @DepartmentNum = ?, @process_type = ?, "
				+ "@fit_type=?, @machine_type=?, @cutting_type=?, @painting_method=?, @paint_type=?, @process_data=?;";
		final static String queryFormat4 = "EXEC AddAssembly @AssemblyID = ?, @date_ordered = ?, @CustomerName = ?, "
				+ "@assembly_details = ?, @ProcessID = ?;";
		final static String queryFormat5 = "EXEC CreateAccount @AccountNum = ?, @account_date_created = ?, "
				+ "@ProcessID=?, @cost_detail_3=?, @cost_detail_2=?, @cost_detail_1=?, @account_type=?, @DepartmentNum=?, @AssemblyID=?;";
		final static String queryFormat6 = "EXEC CreateJob @JobNum = ?, @AssemblyID = ?, @ProcessID=?, @commence_date=?, "
				+ "@job_type=?, @color=?, @volume=?, @machine_type=?, @material_used=?, @time_machine_used=?, "
				+ "@labor_time=?, @completed_date=?;";
		final static String queryFormat7 = "EXEC proc_update_job_completion @JobNum = ?, @completed_date=?, @labor_time=?, @color=?, "
				+ "@volume=?, @machine_type_used=?, @time_machine_used=?, @material_used=?;";
		final static String queryFormat8 = "EXEC Proced_8 @trans_no = ?, @supplementary_cost = ?, @AccountNum=?;";
		final static String queryFormat9 = "EXEC TotalCostAssemblyID @AssemblyID=?, @TotalCost=?;";
		final static String queryFormat10 = "EXEC proc_10 @dept_no=?, @date_completed=?, @total_labor_time_in_minutes=? ;";
		final static String queryFormat11 = "EXEC RetrieveProcess @AssemblyID=?";
		final static String queryFormat12 = "EXEC RetrieveCustomer @st_category=?, @ed_category=?;";
		final static String queryFormat13 = "EXEC DeleteCutJobs @st_i=?, @ed_i=?;";
		final static String queryFormat14 = "EXEC ChangePaintJobColor @JobNum=?, @user_color=?;";
//		final static String queryFormat15 = "SELECT * "
//				+ "FROM Performer;";
		final static String queryFormat16 = "SELECT * FROM Customer WHERE category between ? AND ?;";
//		final static String QUERY_TEMPLATE_17 = "SELECT * FROM Performer;";
		

		final static DateTimeFormatter dateTimeFormat = DateTimeFormatter.ofPattern("MM-dd-yyyy");
		
		

		// Printing out the questions to users
		// thus, we will populate our database
		final static String PROMPT =
				"\nPlease select one of the options below: \n" +
						"1. Enter a new customer \n" +
						"2. Enter a new department \n" +
						"3. Enter a new process-id and its department together with its type and information " +
						"relevant to the type\n" +
						"4. Enter a new assembly with its customer-name, assembly-details, assembly-id, \n" +
						"   and dateordered and associate it with one or more processes\n" +
						"5. Create a new account and associate it with the process, assembly, or department " +
						"to which it is applicable\n" +
						"6. Enter a new job, given its job-no, assembly-id, process-id, and date the job commenced\n" +
						"7. At the completion of a job, enter the date it completed and the information " +
						"relevant to the type of job \n" +
						"8. Enter a transaction-no and its sup-cost and update all the costs (details) of the \n" +
						"   affected accounts by adding sup-cost to their current values of details \n" +
						"9. Retrieve the total cost incurred on an assembly-id \n" +
						"10. Retrieve the total labor time within a department for jobs completed in the " +
						"department during a given date\n" +
						"11. Retrieve the processes through which a given assembly-id has passed so far \n" +
						"    (in datecommenced order) and the department responsible for each process\n"+
						"12. Retrieve the customers (in name order) whose category is in a given range\n" +
						"13. Delete all cut-jobs whose job-no is in a given range\n" +
						"14. Change the color of a given paint job\n" +
						"15. Import: enter new customers from a data file until the file is empty \n" +
						"16. Export: Retrieve the customers (in name order) whose category is in a given \n"
						+ "    range and output them to a data file instead of screen" +
						"\n17. Quit\n";

		public static void main(String[] args) throws SQLException, IOException {
			System.out.println("WELCOME TO THE JOB-SHOP ACCOUNTING DATABASE SYSTEM");
			final Scanner sc = new Scanner(System.in);

			String option = "";

			while (!option.equals("17")) {
				System.out.println(PROMPT);
				System.out.println("Enter your option : ");
				option = sc.next();

				switch (option) {
				case "1":
					System.out.println("What's the customer name?");
					final String user_cust_name = sc.next();

					System.out.println("what's the customer address?");
					final String user_cust_address = sc.next();

					System.out.println("what's the customer category (1-10?");
					final int user_cust_category = sc.nextInt();
					System.out.println("Done!");

					try (final Connection connection = DriverManager.getConnection(URL)) {
						try (final PreparedStatement statement = connection.prepareStatement(queryFormat1)) {
							statement.setString(1, user_cust_name);
							statement.setString(2, user_cust_address);
							statement.setInt(3, user_cust_category);
							statement.execute();
						}
					}
					break;

				case "2":
					System.out.println("What's the department number?");
					final int user_dept_num = sc.nextInt();

					System.out.println("What's the department data?");
					final String user_dept_data = sc.next();

					System.out.println("Done!");

					try (final Connection connection = DriverManager.getConnection(URL)) {
						try (final PreparedStatement statement = connection.prepareStatement(queryFormat2)) {
							statement.setInt(1, user_dept_num);
							statement.setString(2, user_dept_data);
							statement.execute();
						}
					}
					break;

				case "3":

					System.out.println("What's the process id?");
					final int user_processID = sc.nextInt();

					System.out.println("What's the department number?");
					final int user_deptNum = sc.nextInt();

					System.out.println("What's the process_type (Cut, Paint, Fit) case-sensitive (type in small cases?");
					final String user_ProcessType = sc.next();

					System.out.println("What's the fit type?");
					final String user_fitType = sc.next();

					System.out.println("What's the machine type?");
					final String user_machineType = sc.next();

					System.out.println("What's the cutting type?");
					final String user_cuttingType = sc.next();

					System.out.println("painting method:");
					final String user_paintingMethod = sc.next();

					System.out.println("paint type:");
					final String user_paintType = sc.next();

					System.out.println("process data:");
					final String user_processData = sc.next();

					System.out.println("Done!");

					try (final Connection connection = DriverManager.getConnection(URL)) {
						System.out.println("Dispatching the query...");
						try (final PreparedStatement statement = connection.prepareStatement(queryFormat3)) {
							statement.setInt(1, user_processID);
							statement.setInt(2, user_deptNum);
							statement.setString(3, user_ProcessType);
							statement.setString(4, user_fitType);
							statement.setString(5, user_machineType);
							statement.setString(6, user_cuttingType);
							statement.setString(7, user_paintingMethod);
							statement.setString(8, user_paintType);
							statement.setString(9, user_processData);
							statement.execute();
						}	
					}
						break;
					case "4":
						System.out.println("What's the assembly id?");
						final int user_assemblyID = sc.nextInt();

						System.out.println("What's the date ordered param (MM-dd-yyyy)?");
						final String user_dateOrdered = sc.next();

						System.out.println("What's the customer name?");
						final String user_customerName = sc.next();
						
						System.out.println("What's the assembly ordered?");
						final String user_assemblyDetails = sc.next();

						System.out.println("What's the process id?");
						final String user_ProcessIDs = sc.next();

						System.out.println("Done!");

						try (final Connection connection = DriverManager.getConnection(URL)) {
							try (final PreparedStatement statement = connection.prepareStatement(queryFormat4)) {
								statement.setInt(1, user_assemblyID);					        
								statement.setString(2, user_dateOrdered);
								statement.setString(3, user_customerName);
								statement.setString(4, user_assemblyDetails);
								statement.setString(5, user_ProcessIDs);
								statement.execute();
							}
						}
						break;

					case "5":
						
						System.out.println("What's the account number?");
						final int user_AccountNum = sc.nextInt();

						System.out.println("What's the date when account was created?");
						final String user_AccoutDateCreated = sc.next();
						
						System.out.println("What's the process id:");
						final int user_ProcessIDAccount = sc.nextInt();

						System.out.println("What's the cost detail 3?");
						final float user_cost_details_3 = sc.nextFloat();

						System.out.println("What's the cost detail 2?");
						final float user_cost_details_2 = sc.nextFloat();

						System.out.println("What's the cost detail 1:");
						final float user_cost_details_1 = sc.nextFloat();
						
						System.out.println("What's the account type (Process, Department, Assembly) -- case-sensitive: LOWER CASES --");
						final String user_accountType = sc.next();

						System.out.println("What's the department number?");
						final int user_deptNumAccount= sc.nextInt();

						System.out.println("What's the assembly id?");
						final int user_AssemblyIDAccount = sc.nextInt();
						
						System.out.println("Done!");

						try (final Connection connection = DriverManager.getConnection(URL)) {
							try (final PreparedStatement statement = connection.prepareStatement(queryFormat5)) {
								statement.setInt(1, user_AccountNum);
								statement.setString(2, user_AccoutDateCreated);
								statement.setInt(3, user_ProcessIDAccount);
								statement.setFloat(4, user_cost_details_3);
								statement.setFloat(5, user_cost_details_2);
								statement.setFloat(6, user_cost_details_1);
								statement.setString(7, user_accountType);
								statement.setInt(8, user_deptNumAccount);
								statement.setInt(9, user_AssemblyIDAccount);
								statement.execute();
							}
						}
						break;
					case "6":
						System.out.println("What's the job number?");
						final int user_jobNumQuery6 = sc.nextInt();

						System.out.println("What's the assembly id?");
						final int user_assemblyIDQuery6 = sc.nextInt();

						System.out.println("What's the process id?");
						final int user_processIDQuery6 = sc.nextInt();

						System.out.println("What's the commenced date for job?");
						final String user_jobCommenceDateQuery6 = sc.next();
						
						System.out.println("What's the job type (Paint, Fit, Cut) -- case-sensitive: LOWER CASES --?");
						final String user_jobTypeQuery6 = sc.next();
						
						System.out.println("What's the color for the job?");
						final String user_colorQuery6 = sc.next();

						System.out.println("What's the volume for the job?");
						final double user_volumeQuery6 = sc.nextDouble();
						
						System.out.println("What's the machine type used for the job?");
						final String user_machineTypeUsedQuery6 = sc.next();

						System.out.println("What's the material used for the job?");
						final String user_materialUsedQuery6 = sc.next();
						
						System.out.println("What's the time machine has used for the job?");
						final String user_timeMachineUsed = sc.next();
						
						System.out.println("What's the labor time for the job?");
						final double user_laborTimeQuery6 = sc.nextDouble();
						
						System.out.println("What's the completed date for the job?");
						final String user_completedDateQuery6 = sc.next();

						System.out.println("Done!");

						try (final Connection connection = DriverManager.getConnection(URL)) {
							try (final PreparedStatement statement = connection.prepareStatement(queryFormat6)) {
								statement.setInt(1, user_jobNumQuery6);
								statement.setInt(2, user_assemblyIDQuery6);
								statement.setInt(3, user_processIDQuery6);
								statement.setString(4, user_jobCommenceDateQuery6);
								statement.setString(5, user_jobTypeQuery6);
								statement.setString(6, user_colorQuery6);
								statement.setDouble(7, user_volumeQuery6);
								statement.setString(8, user_machineTypeUsedQuery6);
								statement.setString(9, user_materialUsedQuery6);
								statement.setString(10, user_timeMachineUsed);
								statement.setDouble(11, user_laborTimeQuery6);
								statement.setString(12, user_completedDateQuery6);
								statement.execute();
							}
						}
						break;
					case "7":

						System.out.println("What's the job number?");
						final int user_jobNumQuery7 = sc.nextInt();
						
						System.out.println("What's the job completed date?");
						final String user_completedDateQuery7 = sc.next();

						System.out.println("What's the labor time?");
						final double user_laborTimeQuery7 = sc.nextFloat();
						
						//color
						System.out.println("What's the color?");
						final String user_colorQuery7 = sc.next();
						
						//volume
						System.out.println("What's the volume?");
						final double user_volumeQuery7 = sc.nextDouble();
						
						//machine type used
						System.out.println("What's the machine type used?");
						final String user_machineTypeUsed = sc.next();
						
						// machine time used
						System.out.println("What's the machine time used?");
						final String user_machineTimeUsedQuery7 = sc.next();
						
						//material used
						System.out.println("What's the material used?");
						final String user_materialUsedQuery7 = sc.next();
						
						
						System.out.println("Done!");

						try (final Connection connection = DriverManager.getConnection(URL)) {
							try (final CallableStatement statement = connection.prepareCall(queryFormat7)) {
								statement.setInt(1, user_jobNumQuery7);
								statement.setString(2, user_completedDateQuery7);
								statement.setDouble(3, user_laborTimeQuery7);
								statement.setString(4, user_colorQuery7);
								statement.setDouble(5, user_volumeQuery7);
								statement.setString(6, user_machineTypeUsed);
								statement.setString(7, user_machineTimeUsedQuery7);
								statement.setString(8, user_materialUsedQuery7);
						        statement.execute();
							}
						}
						break;
					case "8":

						System.out.println("What's the transaction number?");
						final int user_transactionNumQuery8 = sc.nextInt();

						System.out.println("What's the sup cost?");
						final float user_supCostQuery8 = sc.nextFloat();
						
						System.out.println("What's the account number for transaction?");
						final int user_accountNumQuery8 = sc.nextInt();

						System.out.println("Done!");

						try (final Connection connection = DriverManager.getConnection(URL)) {
							try (final PreparedStatement statement = connection.prepareStatement(queryFormat8)) {
								statement.setInt(1, user_transactionNumQuery8);
								statement.setFloat(2, user_supCostQuery8);
								statement.setInt(3, user_accountNumQuery8);
								statement.execute();
							}
						}
						break;
					case "9":

						System.out.println("What's the assembly id?");
						final int user_assemblyIDQuery9 = sc.nextInt();

						System.out.println("Done!");

						try (final Connection connection = DriverManager.getConnection(URL)) {
							try (final CallableStatement statement = connection.prepareCall(queryFormat9)) {

								statement.setInt(1, user_assemblyIDQuery9);
								statement.registerOutParameter(2, Types.DECIMAL);
								// Execute the stored procedure
						        statement.execute();

						        // Retrieve the output parameter value
						        BigDecimal totalCost = statement.getBigDecimal(2);
						        System.out.println("Total cost: " + totalCost);
							}
						}
						break;
					case "10":

						System.out.println("What's the department number?");
						final int user_departmentNumQuery10 = sc.nextInt();
						
						System.out.println("What's the job completed date:");
						final String user_jobCompletedDateQuery10 = sc.next();

						System.out.println("Done!");

						try (final Connection connection = DriverManager.getConnection(URL)) {
							CallableStatement statement = connection.prepareCall(queryFormat10);
							// Set the assigned value(s) to the procedures input
							statement.setInt(1, user_departmentNumQuery10);
							statement.setString(2, user_jobCompletedDateQuery10);
							// Run the stored procedure and store values in resultSet
							statement.registerOutParameter(3, Types.DECIMAL);
							// Execute the stored procedure
					        statement.execute();

					        // Retrieve the output parameter value
					        BigDecimal totalCost = statement.getBigDecimal(3);
					        System.out.println("Total labor time within department " + user_departmentNumQuery10+ " is :" + totalCost);
						}
						break;
					case "11":

						System.out.println("What's the assembly id?");
						final int user_assemblyIDQuery11 = sc.nextInt();

						System.out.println("Connecting to the database...");

						try (final Connection connection = DriverManager.getConnection(URL)) {
							// Prepare a call to the stored procedure
							CallableStatement statement = connection.prepareCall(queryFormat11);
							// Set the assigned value(s) to the procedures input
							statement.setInt(1, user_assemblyIDQuery11);
							// Run the stored procedure and store values in resultSet
							System.out.println("outputing the query...");
							ResultSet resultSet = statement.executeQuery();
							System.out.println("Done.");
							System.out.println("\nProcess for assembly id: " + user_assemblyIDQuery11 +
									", and its departement number; sorted by date commenced.");
							System.out.println("ProcessID | DepartmentNum");
							// Unpack the tuples returned by the database and print them out to the user
							while (resultSet.next()) {
								System.out.println(String.format("%s | %s ",
//										resultSet.getString(1),
										resultSet.getString(1),
										resultSet.getString(2)));
							}
						}
						break;
					case "12":

						System.out.println("What's the starting category (1-10)");
						final int user_rangeStartQuery12 = sc.nextInt();

						System.out.println("What's the ending category (1-10)");
						final int user_rangeEndQuery12 = sc.nextInt();

						System.out.println("Done!");

						try (final Connection connection = DriverManager.getConnection(URL)) {
							try (final CallableStatement statement = connection.prepareCall(queryFormat12);) {
								// Set the assigned value(s) to the procedures input
								statement.setInt(1, user_rangeStartQuery12);
								statement.setInt(2, user_rangeEndQuery12);
								// Run the stored procedure and store values in resultSet
								System.out.println("Outputting the query...");
								ResultSet resultSet = statement.executeQuery();
								System.out.println("Done.");
								System.out.println("\nJobs from starting date " + user_rangeStartQuery12 +
										" completed on: " + user_rangeEndQuery12);
								System.out.println("The customer names are in the selected category range:");
								// Unpack the tuples returned by the database and print them out to the user
								while (resultSet.next()) {
									System.out.println(String.format("%s",
											resultSet.getString(1)));

								}
							}
						}
						break;
					case "13":
						
						System.out.println("What's the starting job number?");
						final int user_startingJobNumQuery13 = sc.nextInt();

						System.out.println("What's the ending job number?");
						final int user_endingJobNumQuery13 = sc.nextInt();

						System.out.println("Done!");

						try (final Connection connection = DriverManager.getConnection(URL)) {
							try (final PreparedStatement statement = connection.prepareStatement(queryFormat13)) {
								statement.setInt(1, user_startingJobNumQuery13);
								statement.setInt(2, user_endingJobNumQuery13);
								statement.executeUpdate();
							}
						}
						break;
					case "14":

						System.out.println("What's the job number?");
						final int user_jobNumQuery14 = sc.nextInt();

						System.out.println("What's the color?");
						final String user_colorQuery14 = sc.next();

						System.out.println("Done!");

						try (final Connection connection = DriverManager.getConnection(URL)) {
							try (final PreparedStatement statement = connection.prepareStatement(queryFormat14)) {
								statement.setInt(1, user_jobNumQuery14);
								statement.setString(2, user_colorQuery14);
								int rows = statement.executeUpdate();
//								System.out.println(rows);
							}
						}
						break;
					case "15":
						System.out.println("***** Copy the .csv file path you want to read *****");

						String filename = sc.next();
						
						String query = readCSV(filename);
						

						try (final Connection connection = DriverManager.getConnection(URL)) {
							// Prepare a call to the stored procedure
							PreparedStatement ps = connection.prepareCall(query);
							System.out.println("Dispatching the query...");
							// Actually execute the populated query
							final int rows_inserted = ps.executeUpdate();
							System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
						}
						break;

					case "16":
					    // Prompt for minimum and maximum category numbers
					    System.out.println("Please enter MIN category number (integer from 1 - 10, inclusive):");
					    int min = sc.nextInt();

					    System.out.println("Please enter MAX category number (integer from 1 - 10, inclusive):");
					    int max = sc.nextInt();

					    // Prompt for file location path
					    System.out.println("Please enter the file location path:");
					    sc.nextLine(); // consume the newline character
					    String filename12 = sc.nextLine();

					    // Database connection and statement preparation
					    try (Connection connection = DriverManager.getConnection(URL);
					         CallableStatement cs = connection.prepareCall(queryFormat16)) {

					        // Set values for the stored procedure
					        cs.setInt(1, min);
					        cs.setInt(2, max);

					        // Execute the stored procedure and process the result
					        System.out.println("Dispatching the query...");
					        try (ResultSet resultSet = cs.executeQuery();
					             FileWriter myWriter = new FileWriter(filename12 + ".csv")) {

					            // Write headers to the CSV file
					            myWriter.write("name,address,category\n");

					            // Write data from the resultSet to the CSV file
					            while (resultSet.next()) {
					                myWriter.write(String.format("%s,%s,%s\n",
					                        resultSet.getString(1),
					                        resultSet.getString(2),
					                        resultSet.getString(3)));
					            }
					        } catch (IOException e) {
					            System.out.println("Error with file name.");
					            e.printStackTrace();
					        }
					    } catch (SQLException e) {
					        System.out.println("SQL Error: " + e.getMessage());
					    }

					    System.out.println("Done. File Location: " + filename12 + ".csv");
					    break;

					case "17":
					    System.out.println("Exiting! Goodbye!");
					    break;

					default:
					    System.out.println("Unrecognized option: " + option + "\nPlease try again!");
					    break;
					}
				}

				sc.close();
			}


			// Method to read the csv file
		public static String readCSV(String filename) throws IOException, SQLException {
		    // StringBuilder to build the insert statement
		    StringBuilder insertStatement = new StringBuilder("INSERT INTO Customer VALUES ");

		    // Create input reader
		    try (BufferedReader input = new BufferedReader(new FileReader(filename))) {
		        String line;
		        boolean isFirstLine = true; // flag to check if it's the first line

		        // Iterate through each 'row' of the csv
		        while ((line = input.readLine()) != null) {
		            // Add a comma before each line except the first one
		            if (!isFirstLine) {
		                insertStatement.append(", ");
		            } else {
		                isFirstLine = false;
		            }

		            // Split the line into values based on comma
		            String[] values = line.split(",");

		            // Ensure there are enough values in the line
		            if (values.length < 3) {
		                throw new IllegalArgumentException("Not enough values in line: " + line);
		            }

		            // Append the values to the insert statement
		            insertStatement.append("('")
		                    .append(values[0].trim()) // assuming the first column is a string
		                    .append("', '")
		                    .append(values[1].trim()) // assuming the second column is a string
		                    .append("', ")
		                    .append(values[2].trim()) // assuming the third column is an integer
		                    .append(")");
		        }
		    }

		    // Return the insert statement
		    return insertStatement.toString();
		}
	

}




