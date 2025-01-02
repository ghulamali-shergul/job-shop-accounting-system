# Job-Shop Accounting System

## Overview
The **Job-Shop Accounting System** is designed to manage various aspects of a manufacturing environment, including customers, assemblies, processes, jobs, and associated costs. It integrates relational database management, Java-based back-end logic, and a web front-end interface to provide a comprehensive solution for job-shop operations.

## Features
- **Customer Management**: Add, retrieve, and update customer records.
- **Assembly Management**: Track orders and manage assemblies.
- **Process Management**: Maintain processes (`Cut`, `Paint`, `Fit`) with their associated departments.
- **Job Tracking**: Record job details, including type-specific information such as labor time and materials used.
- **Cost Accounting**: Maintain accounts for assemblies, departments, and processes.
- **Reports & Queries**:
  - Retrieve processes through which an assembly has passed.
  - Compute total costs for assemblies.
  - Retrieve jobs completed on a specific date in a department.
  - Delete jobs or update paint job details.
- **Web Application Integration**: A user-friendly front-end for interacting with customer and job data.

## Technology Stack
- **Backend**: Java, JDBC
- **Database**: Azure SQL Database
- **Frontend**: JSP (Java Server Pages)
- **Version Control**: Git, GitHub
