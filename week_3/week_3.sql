create database IF NOT exists Bank;
use Bank;

create table Branch(
	branch_name varchar(20),
    branch_city varchar(20),
    assets real,
    PRIMARY KEY(branch_name)
    );

create table BankAccount(
	accno int,
    branch_name varchar(20),
    balance real,
    PRIMARY KEY(accno),
    foreign key(branch_name) references Branch(branch_name)
    );
    
create table BankCustomer(
	customer_name varchar(20),
    customer_street varchar(20),
    customer_city varchar(20),
    PRIMARY KEY (customer_name)
    
	);
    
create table Depositer(
	customer_name varchar(20),
    accno int,
    PRIMARY KEY(customer_name, accno),
    foreign key(accno) references BankAccount(accno),
    foreign key(customer_name) references BankCustomer(customer_name)
);

create table Loan(
	loan_number int,
    branch_name varchar(20),
    amount real,
    PRIMARY KEY(loan_number),
    foreign key(branch_name) references Branch(branch_name)
);

insert into Branch values("SBI_Chamrajpet","Bangalore",50000);
insert into Branch values("SBI_ResidencyRoad","Bangalore",10000);
insert into Branch values("SBI_ShivajiRoad","Bombay",20000);
insert into Branch values("SBI_ParlimentRoad","Delhi",10000);
insert into Branch values("SBI_Jantarmantar","Delhi",20000);

insert into BankAccount values(1,"SBI_Chamrajpet",2000);
insert into BankAccount values(2,"SBI_ResidencyRoad",5000);
insert into BankAccount values(3,"SBI_ShivajiRoad",6000);
insert into BankAccount values(4,"SBI_ParlimentRoad",9000);
insert into BankAccount values(5,"SBI_Jantarmantar",8000);
insert into BankAccount values(6,"SBI_ShivajiRoad",4000);
insert into BankAccount values(7,"SBI_ResidencyRoad",4000);
insert into BankAccount values(8,"SBI_ParlimentRoad",3000);
insert into BankAccount values(9,"SBI_ResidencyRoad",5000);
insert into BankAccount values(10,"SBI_Jantarmantar",2000);

insert into BankCustomer values("Avinash","Bull_Temple_Road","Banglore");
insert into BankCustomer values("Dinesh","Bannergatta_Road","Banglore");
insert into BankCustomer values("Mohan","NationalCollege_Road","Banglore");
insert into BankCustomer values("Nikil","Akbar_Road","Delhi");
insert into BankCustomer values("Ravi","Prithviraj_Road","Delhi");

insert into Depositer values("Avinash", 1);
insert into Depositer values("Dinesh", 2);
insert into Depositer values("Nikil", 4);
insert into Depositer values("Ravi", 5);
insert into Depositer values("Avinash", 7);
insert into Depositer values("Nikil", 8);
insert into Depositer values("Dinesh", 9);
insert into Depositer values("Nikil", 10);

insert into Loan values(1,"SBI_Chamrajpet",1000);
insert into Loan values (2,"SBI_ResidencyRoad",2000);
insert into Loan values(3,"SBI_ShivajiRoad",3000);
insert into Loan values(4,"SBI_ParlimentRoad",3000);
insert into Loan values(5,"SBI_Jantarmantar",3000);

SELECT branch_name, (assets / 100000) AS 'assets in lakhs'
FROM Branch;

SELECT d.customer_name, ba.branch_name, COUNT(*) AS accno
FROM Depositer d
JOIN BankAccount ba ON d.accno = ba.accno
GROUP BY d.customer_name, ba.branch_name
HAVING COUNT(*) >= 2;

CREATE VIEW LoanSum AS
SELECT branch_name, SUM(amount) AS total_loan_amount
FROM Loan
GROUP BY branch_name;
SELECT * FROM LoanSum;

SELECT customer_name
FROM Depositer d
JOIN bankAccount a ON d.accno = a.accno
WHERE a.branch_name IN (
    SELECT branch_name
    FROM branch
    WHERE branch_city = 'Delhi'
)
GROUP BY customer_name
HAVING COUNT(DISTINCT a.branch_name) = (
    SELECT COUNT(*)
    FROM branch
    WHERE branch_city = 'Delhi'
);

SELECT DISTINCT customer_name
FROM bankCustomer c
WHERE customer_name IN (
    SELECT d.customer_name
    FROM Depositer d
    JOIN bankAccount a ON d.accno = a.accno
    JOIN Loan l ON a.branch_name = l.branch_name
)
AND customer_name NOT IN (
    SELECT d.customer_name FROM Depositer d
);

SELECT DISTINCT c.customer_name
FROM bankCustomer c
WHERE c.customer_name NOT IN (
    SELECT customer_name FROM Depositer
)
AND EXISTS (
    SELECT 1 FROM Loan
);

SELECT DISTINCT d.customer_name
FROM Depositer d
JOIN bankAccount a ON d.accno = a.accno
JOIN Loan l ON a.branch_name = l.branch_name
WHERE a.branch_name IN (
    SELECT branch_name FROM branch WHERE branch_city = 'Bangalore'
);

SELECT branch_name
FROM branch
WHERE 'assets in lakhs' > ALL (
    SELECT  'assets in lakhs' FROM branch WHERE branch_city = 'Bangalore'
);

DELETE FROM bankAccount
WHERE branch_name IN (
    SELECT branch_name FROM branch WHERE branch_city = 'Bombay'
);


UPDATE bankAccount
SET balance = balance * 1.05;

	
		












 