DROP PROCEDURE IF EXISTS AddCustomer
DROP PROCEDURE IF EXISTS AddDepartment
DROP PROCEDURE IF EXISTS AddProcessViaDepartment
DROP PROCEDURE IF EXISTS AddAssembly
DROP PROCEDURE IF EXISTS CreateAccount
DROP PROCEDURE IF EXISTS CreateJob
DROP PROCEDURE IF EXISTS proc_update_job_completion
DROP PROCEDURE IF EXISTS Proced_8
DROP PROCEDURE IF EXISTS TotalCostAssemblyID
DROP PROCEDURE IF EXISTS proc_10
DROP PROCEDURE IF EXISTS RetrieveProcess 
DROP PROCEDURE IF EXISTS RetrieveCustomer
DROP PROCEDURE IF EXISTS DeleteCutJobs
DROP PROCEDURE IF EXISTS ChangePaintJobColor


-- 1. Enter a new customer
GO

CREATE PROCEDURE AddCustomer
    @CustomerName VARCHAR(20),
    @Customer_Address VARCHAR(100),
    @category INT
AS
BEGIN

INSERT INTO Customer
( 
 [CustomerName], [Customer_Address], [category]
)
VALUES (@CustomerName, @Customer_Address, @category)
END


-- 2. Enter a new Department
GO

CREATE PROCEDURE AddDepartment
    @DepartmentNum INT,
    @department_data VARCHAR(100)
AS
BEGIN
    INSERT INTO Department
    ( 
    [DepartmentNum], [department_data]
    )
    VALUES (@DepartmentNum, @department_data)
END

-- 3. Enter a new process-id and its department together with its type and information relevant to the type

GO

CREATE PROCEDURE AddProcessViaDepartment
    @ProcessID INT,
    @DepartmentNum INT,
    @process_type VARCHAR(10),
    @process_data VARCHAR(100),
    @fit_type VARCHAR(100),
    @paint_type VARCHAR (100),
    @painting_method VARCHAR(100),
    @cutting_type VARCHAR (100),
    @machine_type VARCHAR (100)

AS
BEGIN
    -- Insert into Process table
    INSERT INTO Process
    ([ProcessID], [process_data])
    VALUES (@ProcessID, @process_data)

    INSERT INTO supervised_by
    ([ProcessID], [DepartmentNum])
    VALUES (@ProcessID, @DepartmentNum)

    -- Conditional inserts based on process type
    IF @process_type = 'fit'
    BEGIN
        INSERT INTO Fit_Process
        ([ProcessID], [fit_type])
        VALUES (@ProcessID, @fit_type)
    END
    ELSE IF @process_type = 'paint'
    BEGIN
        INSERT INTO Paint_Process
        ([ProcessID], [paint_type], [painting_method])
        VALUES (@ProcessID, @paint_type, @painting_method)
    END
    ELSE IF @process_type = 'cut'
    BEGIN
        INSERT INTO Cut_Process
        ([ProcessID], [cutting_type], [machine_type])
        VALUES (@ProcessID, @cutting_type, @machine_type)
    END
END

-- 4. Enter a new assembly with its customer-name, assembly-details, assembly-id, and date- ordered and associate it with one or more processes

GO

CREATE PROCEDURE AddAssembly
    @AssemblyID INT,
    @date_ordered VARCHAR(10),
    @assembly_details VARCHAR(100),
    @CustomerName VARCHAR(20),
    @ProcessID INT
AS
BEGIN
    INSERT INTO Assemblies
    ( -- Columns to insert data into
    [AssemblyID], [date_ordered], [Assemblies_details]
    )
    VALUES (@AssemblyID, CAST (@date_ordered as DATE), @assembly_details)

    INSERT INTO Orders
    ( -- Columns to insert data into
    [AssemblyID], [CustomerName]
    )
    VALUES (@AssemblyID, @CustomerName)

    INSERT INTO Manufactures
    ( -- Columns to insert data into
    [AssemblyID], [ProcessID]
    )
    VALUES (@AssemblyID, @ProcessID)
END

-- 5. Create a new account and associate it with the process, assembly, or department to which it is applicable (10/day).
GO

CREATE PROCEDURE CreateAccount
    @AccountNum INT,
    @AssemblyID INT,
    @account_date_created VARCHAR (10),
    @cost_detail_1 VARCHAR (255),
    @cost_detail_2 VARCHAR (255),
    @cost_detail_3 VARCHAR (255),
    @DepartmentNum INT,
    @ProcessID INT,
    @account_type VARCHAR(10)
AS
BEGIN
    -- First, insert the job into the job entity (assuming the table is named 'Job')
    INSERT INTO Account ([AccountNum], [account_date_created])
    VALUES (@AccountNum, CAST(@account_date_created as DATE))

    -- Conditional logic for account type selection and insertion into respective tables
    IF @account_type = 'assembly'
    BEGIN
        INSERT INTO Assembly_Account ([AccountNum], [cost_details_1])
        VALUES (@AccountNum, @cost_detail_1)

        
        INSERT INTO Maintains_Assemblies ([AssemblyID], [AccountNum])
        VALUES (@AssemblyID, @AccountNum)
    END

    ELSE IF @account_type = 'department'
    BEGIN
        INSERT INTO Department_Account ([AccountNum], [cost_details_2])
        VALUES (@AccountNum, @cost_detail_2)

        INSERT INTO Maintains_Department ([DepartmentNum], [AccountNum])
        VALUES (@DepartmentNum, @AccountNum)
    END
    ELSE IF @account_type = 'process'
    BEGIN
        INSERT INTO Process_Account ([AccountNum], [cost_details_3])
        VALUES (@AccountNum, @cost_detail_3)

        INSERT INTO Maintains_Process ([ProcessID], [AccountNum])
        VALUES (@ProcessID, @AccountNum)
    END
END

-- 6. Enter a new job, given its job-no, assembly-id, process-id, and date the job commenced (50/day).

GO

CREATE PROCEDURE CreateJob
    @JobNum INT,
    @commence_date VARCHAR (255),
    @completed_date VARCHAR (255),
    @machine_type VARCHAR (255),
    @time_machine_used VARCHAR (255),
    @material_used VARCHAR (255),
    @labor_time VARCHAR (255),
    @color VARCHAR (255),
    @volume DECIMAL(10,2),
    @job_type VARCHAR (255),
    @AssemblyID INT,
    @ProcessID INT
AS
BEGIN
    -- First, insert the job into the job entity (assuming the table is named 'Job')
    INSERT INTO Job ([JobNum], [commence_date], [completed_date])
    VALUES (@JobNum, CAST(@commence_date as DATE), CAST(@completed_date as DATE))

    INSERT INTO Assigns ([AssemblyID],[ProcessID],[JobNum])
    VALUES(@AssemblyID,@ProcessID,@JobNum)

    -- Conditional logic for account type selection and insertion into respective tables
    IF @job_type = 'cut'
    BEGIN
        INSERT INTO Cut_Job ([JobNum], [machine_type_used], [time_machine_used], [material_used], [labor_time])
        VALUES (@JobNum, @machine_type, @time_machine_used, @material_used, @labor_time)
    END

    ELSE IF @job_type = 'fit'
    BEGIN
        INSERT INTO Fit_Job ([JobNum], [labor_time])
        VALUES (@JobNum, @labor_time)
    END

    ELSE IF @job_type = 'paint'
    BEGIN
        INSERT INTO Paint_Job ([JobNum], [color], [volume], [labor_time])
        VALUES (@JobNum, @color, @volume, @labor_time)
    END

END

-- 7. At the completion of a job, enter the date it completed and the information relevant to the type of job (50/day).

GO

CREATE PROCEDURE proc_update_job_completion
    @JobNum INT,
    @completed_date VARCHAR (255),
    @labor_time VARCHAR(255),
    @color VARCHAR(255),
    @volume DECIMAL(10,2),
    @machine_type_used VARCHAR (255),
    @time_machine_used VARCHAR (255),
    @material_used VARCHAR (255)
AS
BEGIN
    -- Update the job completion date in the Job table
    UPDATE Job
    SET completed_date = CAST(@completed_date as DATE)
    WHERE JobNum = @JobNum

    -- Check and update Paint_Job if the job_no exists there
    IF EXISTS (SELECT 1 FROM Paint_Job WHERE JobNum = @JobNum)
    BEGIN
        -- Assuming we update some attribute in Paint_Job, for example, labor_time
        UPDATE Paint_Job SET labor_time = @labor_time, color = @color, volume = @volume
        WHERE JobNum = @JobNum
    END

    -- Check and update Fit_Job if the job_no exists there
    IF EXISTS (SELECT 1 FROM Fit_Job WHERE JobNum = @JobNum)
    BEGIN
        -- Assuming we update some attribute in Fit_Job, for example, labor_time
        UPDATE Fit_Job SET labor_time = @labor_time
        WHERE JobNum = @JobNum
    END

    -- Check and update Cut_Job if the job_no exists there
    IF EXISTS (SELECT 1 FROM Cut_Job WHERE JobNum = @JobNum)
    BEGIN
        -- Assuming we update some attribute in Cut_Job, for example, cut_labor_time
        UPDATE Cut_Job SET labor_time = @labor_time, machine_type_used = @machine_type_used, time_machine_used = @time_machine_used, material_used = @material_used 
        WHERE JobNum = @JobNum
    END
END

-- 8. Enter a transaction-no and its sup-cost and update all the costs (details) of the affected accounts by adding sup-cost to their current values of details (50/day)

GO

CREATE PROCEDURE Proced_8
    @trans_no INT,
    @supplementary_cost DECIMAL (10,2),
    @AccountNum INT
AS
BEGIN
    -- Insert into Transactions table
    INSERT INTO Transactions
    ([TransactionsNum], [sup_cost], [AccountNum])
    VALUES (@trans_no, @supplementary_cost, @AccountNum);

    -- Update the corresponding account details based on AccountNum
    -- Assuming AccountNum uniquely identifies an account across Dept_acc, Assembly_acc, and Process_acc

    IF EXISTS (SELECT 1 FROM Department_Account WHERE AccountNum = @AccountNum)
    BEGIN
        UPDATE Department_Account
        SET cost_details_2 = cost_details_2 + @supplementary_cost
        WHERE AccountNum = @AccountNum;
    END

    IF EXISTS (SELECT 1 FROM Assembly_Account WHERE AccountNum = @AccountNum)
    BEGIN
        UPDATE Assembly_Account
        SET cost_details_1 = cost_details_1 + @supplementary_cost
        WHERE AccountNum = @AccountNum;
    END

    IF EXISTS (SELECT 1 FROM Process_Account WHERE AccountNum = @AccountNum)
    BEGIN
        UPDATE Process_Account
        SET cost_details_3 = cost_details_3 + @supplementary_cost
        WHERE AccountNum = @AccountNum;
    END

    INSERT INTO Proceeds ([TransactionsNum])
    VALUES (@trans_no)
END

-- 9 Retrieve the total cost incurred on an assembly-id (200/day).

GO

CREATE PROCEDURE TotalCostAssemblyID
    @AssemblyID INT,
    @TotalCost DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @TotalCost = sum(a.cost_details_1)
    FROM Assembly_Account a JOIN Maintains_Assemblies ma ON a.AccountNum = ma.AccountNum
    WHERE ma.AssemblyID = @AssemblyID
END

-- 10 Retrieve the total labor time within a department for jobs completed in the department during a given date (20/day).

GO

CREATE PROCEDURE proc_10
    @dept_no INT,
    @date_completed DATE,
    @total_labor_time_in_minutes DECIMAL(10,2) OUTPUT

AS
BEGIN

    -- Calculate total labor time from Paint_Job, Fit_Job, and Cut_Job for the jobs completed on @date_completed in the specified department
    SELECT @total_labor_time_in_minutes = ISNULL(SUM(labor_time_in_minutes), 0)
    FROM (
        SELECT Job.JobNum
        FROM Job
        INNER JOIN Assigns ON Job.JobNum = Assigns.JobNum
        INNER JOIN Supervised_by ON Assigns.ProcessID = Supervised_by.ProcessID
        WHERE Job.completed_date = @date_completed
        AND Supervised_by.DepartmentNum = @dept_no
    ) AS CompletedJobs
    LEFT JOIN (
        -- SELECT JobNum, (DATEPART(HOUR, labor_time) * 60) + DATEPART(MINUTE, labor_time) AS labor_time_in_minutes
        -- FROM Paint_Job
        -- UNION ALL
        -- SELECT JobNum, (DATEPART(HOUR, labor_time) * 60) + DATEPART(MINUTE, labor_time)
        -- FROM Fit_Job
        -- UNION ALL
        -- SELECT JobNum, (DATEPART(HOUR, labor_time) * 60) + DATEPART(MINUTE, labor_time)
        -- FROM Cut_Job
        SELECT JobNum, CAST(FLOOR(labor_time) * 60 + (labor_time - FLOOR(labor_time)) * 100 AS INT) AS labor_time_in_minutes
        FROM Paint_Job
        UNION ALL
        SELECT JobNum, CAST(FLOOR(labor_time) * 60 + (labor_time - FLOOR(labor_time)) * 100 AS INT)
        FROM Fit_Job
        UNION ALL
        SELECT JobNum, CAST(FLOOR(labor_time) * 60 + (labor_time - FLOOR(labor_time)) * 100 AS INT)
        FROM Cut_Job
    ) AS JobTimes ON CompletedJobs.JobNum = JobTimes.JobNum;

    -- Return the total labor time in minutes
    SELECT @total_labor_time_in_minutes AS TotalLaborTimeMinutes;
END


-- 11. Retrieve the processes through which a given assembly-id has passed so far (in date- commenced order) and the department responsible for each process (100/day).
GO

CREATE PROCEDURE RetrieveProcess
    @AssemblyID INT
    -- @ProcessID INT OUTPUT,
    -- @DepartmentNum INT OUTPUT
AS
BEGIN
    SELECT asg.ProcessID, sb.DepartmentNum
    FROM supervised_by sb join Assigns asg on sb.ProcessID = asg.ProcessID JOIN Job j on asg.JobNum = j.JobNum
    WHERE asg.AssemblyID = @AssemblyID AND sb.ProcessID = sb.ProcessID 
    ORDER BY j.commence_date

END

-- 12. Retrieve the customers (in name order) whose category is in a given range (100/day).
GO

CREATE PROCEDURE RetrieveCustomer
    @st_category INT,
    @ed_category INT
AS
BEGIN
    SELECT CustomerName
    FROM Customer
    WHERE category BETWEEN @st_category AND @ed_category
    ORDER BY CustomerName

END

-- 13. Delete all cut-jobs whose job-no is in a given range (1/month).

GO

CREATE PROCEDURE DeleteCutJobs
    @st_i INT,
    @ed_i INT
AS
BEGIN
    DELETE 
    FROM Cut_Job
    WHERE JobNum >= @st_i AND JobNum <= @ed_i

     DELETE 
    FROM Job
    WHERE JobNum >= @st_i AND JobNum <= @ed_i

END

-- 14. Change the color of a given paint job (1/week).
GO

CREATE PROCEDURE ChangePaintJobColor
    @JobNum INT,
    @user_color VARCHAR(255)
AS
BEGIN
    UPDATE Paint_Job
    SET color = @user_color
    WHERE JobNum = @JobNum

END

