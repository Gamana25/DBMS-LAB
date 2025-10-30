CREATE DATABASE IF NOT EXISTS Employee_Info;
USE Employee_Info;

CREATE TABLE Department (
    deptNo INT,
    dName VARCHAR(20),
    dLoc VARCHAR(20),
    PRIMARY KEY (deptNo)
);

CREATE TABLE Employee (
    empNo INT,
    eName VARCHAR(20),
    mgrNo INT,
    hireDate DATE,
    sal REAL,
    deptNo INT,
    PRIMARY KEY (empNo),
    FOREIGN KEY (deptNo) REFERENCES Department(deptNo)
);

CREATE TABLE Incentives (
    empNo INT,
    incentiveDate DATE,
    incentiveAmount REAL,
    PRIMARY KEY (incentiveDate), 
    FOREIGN KEY (empNo) REFERENCES Employee(empNo)
);


CREATE TABLE Project (
    pNo INT,
    pName VARCHAR(20),
    pLoc VARCHAR(20),
    PRIMARY KEY (pNo)
);

CREATE TABLE Assigned_to (
    empNo INT,
    pNo INT,
    jobRole VARCHAR(20),
    FOREIGN KEY (empNo) REFERENCES Employee(empNo),
    FOREIGN KEY (pNo) REFERENCES Project(pNo)
);

INSERT INTO Department (deptNo, dName, dLoc) VALUES
(100, 'Finance_dept', 'Bengaluru'),
(101, 'Accounts_dept', 'Hyderabad'),
(102, 'Design_dept', 'Mysore'),
(103, 'Backend_dept', 'Chennai'),
(104, 'Marketing_dept', 'Bengaluru'),
(105, 'Sales_dept', 'Hyderabad');

INSERT INTO Employee (empNo, eName, mgrNo, hireDate, sal, deptNo) VALUES
(1000, 'Divya', 1, '2018-08-19', 50000, 101),
(1001, 'Lokesh', 2, '2015-02-12', 40000, 100),
(1002, 'Raghav', 3, '2019-11-21', 75000, 103),
(1003, 'Sahasra', 4, '2017-03-18', 35000, 104),
(1004, 'Nikhil', 5, '2022-04-15', 60000, 102),
(1005, 'Nithya', 6, '2021-02-19', 30000, 105); 

INSERT INTO Incentives (empNo, incentiveDate, incentiveAmount) VALUES
(1000, '2019-11-19', 10000),
(1001, '2017-02-12', 8000),
(1002, '2020-11-21', 15000),
(1003, '2019-08-21', 20000),
(1004, '2023-08-17', 15000),
(1005, '2022-03-04', 12000);

INSERT INTO Project (pNo, pName, pLoc) VALUES
(1, 'cloudWeb', 'Bengaluru'),
(2, 'eCommerce', 'Chennai'),
(3, 'urbanCompany', 'Hyderabad'),
(4, 'Webdev', 'Mysore'),
(5, 'Promotions', 'Bengaluru'),
(6, 'database', 'Hyderabad');

INSERT INTO Assigned_to(empNo, pNo, jobRole) VALUES 
(1000,1,'Accounts Manager'),
(1001,2,'CA analyst'),
(1002,3,'Backend Devloper'),
(1003,4,'Designer'),
(1004,5,'UI/UX Designer'),
(1005,6,'Seller');

SELECT DISTINCT E.empNo, E.eName
FROM Employee E
JOIN Assigned_to A ON E.empNo = A.empNo
JOIN Project P ON A.pNo = P.pNo
WHERE P.pLoc IN ('Bengaluru', 'Hyderabad', 'Mysore');

SELECT empNo
FROM Employee
WHERE empNo NOT IN (SELECT empNo FROM Incentives);

SELECT E.eName, E.empNo, D.dName, A.jobRole, D.dLoc, P.pLoc
FROM Employee E
JOIN Department D ON E.deptNo = D.deptNo
JOIN Assigned_to A ON E.empNo = A.empNo
JOIN Project P ON A.pNo = P.pNo
WHERE D.dLoc = P.pLoc;
