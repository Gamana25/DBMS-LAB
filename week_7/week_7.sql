create database if not exists  product_info;
use product_info;

CREATE TABLE Supplier(
	sid int,
    sname varchar(20),
    city varchar(20),
    PRIMARY KEY (sid)
);

CREATE TABLE Parts (
	pid int,
    pname varchar(20),
    color varchar(20),
    PRIMARY KEY (pid)
);

CREATE TABLE Catalog(
	sid int,
	pid int,
    cost int,
    FOREIGN KEY(sid) REFERENCES Supplier(sid),
    FOREIGN KEY(pid) REFERENCES Parts(pid)
);

INSERT INTO Supplier(sid,sname,city) VALUES
(10001,"Acme Widget","Banglore"),
(10002,"Johns","Kolkata"),
(10003,"Vimal","Mumbai"),
(10004,"Reliance","Delhi");

INSERT INTO Parts(pid,pname,color) VALUES
(20001, "Book","Red"),
(20002,"Pen","Red"),
(20003,"Pencil","Green"),
(20004,"Mobile","Green"),
(20005,"Charger","Black");

INSERT INTO Catalog(sid,pid,cost) VALUES 
(10001,20001,10),
(10001,20002,10),
(10001,20003,30),
(10001,20004,10),
(10001,20005,10),
(10002,20001,10),
(10002,20002,20),
(10003,20003,30),
(10004,20003,40);

SELECT DISTINCT p.pname
FROM Parts p
JOIN Catalog c ON p.pid = c.pid;

SELECT s.sname
FROM Supplier s
WHERE NOT EXISTS (
    SELECT p.pid
    FROM Parts p
    WHERE p.pid NOT IN (
        SELECT c.pid
        FROM Catalog c
        WHERE c.sid = s.sid
    )
);

SELECT s.sname
FROM Supplier s
WHERE NOT EXISTS (
    SELECT p.pid
    FROM Parts p
    WHERE p.color = 'Red'
      AND p.pid NOT IN (
          SELECT c.pid
          FROM Catalog c
          WHERE c.sid = s.sid
      )
);

SELECT p.pname
FROM Parts p
JOIN Catalog c ON p.pid = c.pid
JOIN Supplier s ON s.sid = c.sid
WHERE s.sname = 'Acme Widget'
AND p.pid NOT IN (
    SELECT c2.pid
    FROM Catalog c2
    JOIN Supplier s2 ON s2.sid = c2.sid
    WHERE s2.sname <> 'Acme Widget'
);

SELECT DISTINCT c.sid
FROM Catalog c
JOIN (
    SELECT pid, AVG(cost) AS avg_cost
    FROM Catalog
    GROUP BY pid
) avg_table ON c.pid = avg_table.pid
WHERE c.cost > avg_table.avg_cost;

SELECT p.pname, s.sname
FROM Catalog c
JOIN Parts p ON c.pid = p.pid
JOIN Supplier s ON c.sid = s.sid
WHERE c.cost = (
    SELECT MAX(c2.cost)
    FROM Catalog c2
    WHERE c2.pid = c.pid
);




