DROP TABLE IF EXISTS Maintains_Assemblies;
DROP TABLE IF EXISTS Maintains_Department;
DROP TABLE IF EXISTS Maintains_Process;
DROP TABLE IF EXISTS Proceeds;
DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Assigns;
DROP TABLE IF EXISTS supervised_by;
DROP TABLE IF EXISTS Fit_Job;
DROP TABLE IF EXISTS Paint_Job;
DROP TABLE IF EXISTS Cut_Job;
DROP TABLE IF EXISTS Fit_Process;
DROP TABLE IF EXISTS Cut_Process;
DROP TABLE IF EXISTS Paint_Process;
DROP TABLE IF EXISTS Assemblies;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Department_Account;
DROP TABLE IF EXISTS Process_Account;
DROP TABLE IF EXISTS Assembly_Account;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Process;
DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS Job;
DROP TABLE IF EXISTS Manufactures;



CREATE TABLE Customer (
    CustomerName VARCHAR(250),
    Customer_Address VARCHAR(250),
    category INT NOT NULL CHECK (category BETWEEN 1 AND 10)
    PRIMARY KEY (CustomerName)
);



create index Customer_Category_Indx on Customer(category)


CREATE TABLE Assemblies (
    AssemblyID INT,
    date_ordered DATE,
    Assemblies_details VARCHAR(250),
    PRIMARY KEY (AssemblyID),
);


CREATE TABLE Orders (
    AssemblyID INT,
    CustomerName VARCHAR(250),
    PRIMARY KEY (AssemblyID),
    FOREIGN KEY (AssemblyID) REFERENCES Assemblies(AssemblyID),
    FOREIGN KEY (CustomerName) REFERENCES Customer(CustomerName)
);


CREATE TABLE Department (
    DepartmentNum INT,
    department_data VARCHAR(250),
    PRIMARY KEY (DepartmentNum),
);  


CREATE TABLE Process (
    ProcessID INT,
    process_data VARCHAR(250),
    PRIMARY KEY (ProcessID),
);


CREATE TABLE Paint_Process (
    ProcessID INT,
    paint_type VARCHAR(250),
    painting_method VARCHAR(250),
    PRIMARY KEY (ProcessID),
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID)
);


CREATE TABLE Fit_Process (
    ProcessID INT,
    fit_type VARCHAR(250),
    PRIMARY KEY (ProcessID),
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID)
);


CREATE TABLE Cut_Process (
    ProcessID INT,
    cutting_type VARCHAR(250),
    machine_type VARCHAR(250),
    PRIMARY KEY (ProcessID),
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID)

);


CREATE TABLE supervised_by (
    ProcessID INT,
    DepartmentNum INT,
    PRIMARY KEY (ProcessID),
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID),
    FOREIGN KEY (DepartmentNum) REFERENCES Department(DepartmentNum)

)

create index sup_by_processID_Indx on supervised_by(ProcessID)

CREATE TABLE Job (
    JobNum INT,
    commence_date DATE,
    completed_date DATE,
    PRIMARY KEY (JobNum)
)

create index completed_date_indx on Job(completed_date)

CREATE TABLE Cut_Job (
    JobNum INT,   
    machine_type_used VARCHAR(250),
    time_machine_used DECIMAL(10,2),
    material_used VARCHAR(250),
    labor_time DECIMAL(10,2),
    PRIMARY KEY (JobNum),
    FOREIGN KEY (JobNum) REFERENCES Job(JobNum),

);

CREATE TABLE Paint_Job (
    JobNum INT,
    color VARCHAR(250),
    volume DECIMAL(10,2),
    labor_time DECIMAL(10,2),
    PRIMARY KEY (JobNum),
    FOREIGN KEY (JobNum) REFERENCES Job(JobNum)

);


create index paint_job_color on Paint_Job(color);


CREATE TABLE Fit_Job (
    JobNum INT,
    labor_time DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (JobNum),
    FOREIGN KEY (JobNum) REFERENCES Job(JobNum)
);


CREATE TABLE Assigns (
    AssemblyID INT,
    ProcessID INT,
    JobNum INT,
    PRIMARY KEY (AssemblyID, ProcessID),
    FOREIGN KEY (AssemblyID) REFERENCES Assemblies(AssemblyID),
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID),
    FOREIGN KEY (JobNum) REFERENCES Job(JobNum),
);

CREATE TABLE Manufactures (
    AssemblyID INT,
    ProcessID INT,
    PRIMARY KEY (AssemblyID, ProcessID),
    FOREIGN KEY (AssemblyID) REFERENCES Assemblies(AssemblyID),
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID),
);

create INDEX assemblyIndx on Manufactures(AssemblyID);


CREATE TABLE Account(
    AccountNum INT,
    account_date_created DATE,
    PRIMARY KEY (AccountNum),

)


CREATE TABLE Assembly_Account (
    AccountNum INT,
    cost_details_1 DECIMAL(10,2),
    PRIMARY KEY (AccountNum),
    FOREIGN KEY (AccountNum) REFERENCES Account(AccountNum)
);


CREATE TABLE Department_Account (
    AccountNum INT,
    cost_details_2 DECIMAL(10,2),
    PRIMARY KEY (AccountNum),
    FOREIGN KEY (AccountNum) REFERENCES Account(AccountNum)

);


CREATE TABLE Process_Account (
    AccountNum INT,
    cost_details_3 DECIMAL(10,2),
    PRIMARY KEY (AccountNum),
    FOREIGN KEY (AccountNum) REFERENCES Account(AccountNum)

);

CREATE TABLE Transactions (
    TransactionsNum INT,
    AccountNum INT,
    sup_cost DECIMAL(10,2),
    PRIMARY KEY (TransactionsNum),
    FOREIGN KEY (AccountNum) REFERENCES Account(AccountNum)
);

CREATE TABLE Proceeds (
    TransactionsNum INT,
    JobNum INT,
    PRIMARY KEY (TransactionsNum),
    FOREIGN KEY (TransactionsNum) REFERENCES Transactions(TransactionsNum),
    FOREIGN KEY (JobNum) REFERENCES Job(JobNum)
);

CREATE TABLE Maintains_Process (
    ProcessID INT,
    AccountNum INT,
    PRIMARY KEY (ProcessID),
    FOREIGN KEY (AccountNum) REFERENCES Account(AccountNum),
    FOREIGN KEY (ProcessID) REFERENCES Process(ProcessID)
);

CREATE TABLE Maintains_Assemblies (
    AssemblyID INT,
    AccountNum INT,
    PRIMARY KEY (AssemblyID),
    FOREIGN KEY (AssemblyID) REFERENCES Assemblies(AssemblyID),
    FOREIGN KEY (AccountNum) REFERENCES Account(AccountNum),

);

CREATE INDEX Main_Ass_ID_Idx on Maintains_Assemblies(AssemblyID);

CREATE TABLE Maintains_Department (
    DepartmentNum INT,
    AccountNum INT,
    PRIMARY KEY (DepartmentNum),
    FOREIGN KEY (DepartmentNum) REFERENCES Department(DepartmentNum),
    FOREIGN KEY (AccountNum) REFERENCES Account(AccountNum),

);