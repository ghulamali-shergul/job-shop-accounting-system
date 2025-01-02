# Job-Shop Accounting System

## Overview

The **Job-Shop Accounting System** is a comprehensive solution tailored for manufacturing environments that produce special-purpose assemblies for customers. This system efficiently manages customers, assemblies, processes, jobs, and associated costs, ensuring streamlined operations and accurate cost accounting.

## Features

- **Customer Management**: Add, retrieve, and update customer records, including details such as name, address, and category.
- **Assembly Management**: Track orders and manage assemblies with unique assembly IDs, order dates, and detailed descriptions.
- **Process Management**: Maintain and oversee processes categorized into:
  - *Cut*: Managing cutting types and machine specifications.
  - *Paint*: Handling paint types and painting methods.
  - *Fit*: Supervising fit types and related details.
- **Job Tracking**: Record comprehensive job details, including:
  - Job commencement and completion dates.
  - Type-specific information such as labor time, materials used, machine time, and more.
- **Cost Accounting**: Maintain detailed accounts for:
  - Assemblies: Tracking costs associated with each assembly.
  - Departments: Monitoring departmental expenditures.
  - Processes: Recording costs related to specific processes.
- **Reports & Queries**:
  - Retrieve the sequence of processes an assembly has undergone.
  - Compute total costs incurred for assemblies.
  - Retrieve jobs completed on a specific date within a department.
  - Delete jobs or update details, such as modifying paint job information.
- **Web Application Integration**: Provides a user-friendly web interface for interacting with customer and job data, facilitating easy data entry and retrieval.

## Technology Stack

### Backend
- **Language**: Java
- **Framework**: JDBC (Java Database Connectivity)

### Database
- **Database**: Azure SQL Database
- **Language**: SQL

### Frontend
- **Language**: HTML, CSS, JavaScript
- **Framework**: JSP (Java Server Pages)

### Version Control
- **Tool**: Git
- **Repository**: GitHub

### Build and Deployment
- **Server**: Apache Tomcat

## Getting Started

To set up the Job-Shop Accounting System locally, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/ghulamali-shergul/job-shop-accounting-system.git
   ```

2. **Set Up the Database**:
   - Ensure you have access to an Azure SQL Database instance.
   - Execute the SQL scripts located in the `database` directory to create the necessary tables and stored procedures.

3. **Configure the Backend**:
   - Navigate to the `backend` directory.
   - Update the database connection settings in the configuration file to match your Azure SQL Database credentials.

4. **Deploy the Frontend**:
   - Navigate to the `frontend` directory.
   - Deploy the JSP files to your preferred web server (e.g., Apache Tomcat).

5. **Run the Application**:
   - Start your web server to host the frontend.
   - Access the application through your web browser to begin managing job-shop operations.

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature-branch-name`.
3. Make your changes and commit them: `git commit -m 'Add new feature'`.
4. Push to the branch: `git push origin feature-branch-name`.
5. Submit a pull request detailing your changes.

## License

This project is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for more details.

## Acknowledgements

This project was inspired by the need for efficient management of job-shop operations in manufacturing environments.
