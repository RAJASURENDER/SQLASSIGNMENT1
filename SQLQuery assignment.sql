create database TechShop;

USE TechShop;

CREATE TABLE Customers (
  CustomerID INT NOT NULL ,
  FirstName VARCHAR(255) NOT NULL,
  LastName VARCHAR(255) NOT NULL,
  Email VARCHAR(255) NOT NULL,
  Phone VARCHAR(255) NOT NULL,
  Address VARCHAR(255) NOT NULL,
  PRIMARY KEY (CustomerID),
  
);

CREATE TABLE Products (
  ProductID INT NOT NULL ,
  ProductName VARCHAR(255) NOT NULL,
  Description TEXT NOT NULL,
  Price DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (ProductID)
);

CREATE TABLE Orders (
  OrderID INT NOT NULL ,
  CustomerID INT NOT NULL,
  OrderDate DATE NOT NULL,
  TotalAmount DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
  OrderDetailID INT NOT NULL ,
  OrderID INT NOT NULL,
  ProductID INT NOT NULL,
  Quantity INT NOT NULL,
  PRIMARY KEY (OrderDetailID),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Inventory 
(
  InventoryID INT NOT NULL ,
  ProductID INT NOT NULL,
  QuantityInStock INT NOT NULL,
  LastStockUpdate DATE NOT NULL,
  PRIMARY KEY (InventoryID),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

--INSERTING 10 SAMPLE RECORDS

INSERT INTO Customers 
VALUES(1,'sachin','tendulkar','sachin@gmail.com',9876543210,'hyderabad'),(2,'Rahul','dravid','rahul@gmail.com',9876543211,'chennai'),
(3,'kapil','dev','kapil@gmail.com',9876543212,'mumbai'),(4,'sam','curran','kings@gmail.com',9876543220,'punjab'),
(5,'hardik','pandhya','indians@gmail.com',9876533211,'mumbai'),
(6,'jasprit','bumrah','indiann@gmail.com',9873543212,'mumbai'),(7,'ms','dhoni','mahii@gmail.com',9973543212,'chennai'),
(8,'mitchell','stark','australian@gmail.com',9893543212,'chennai'),(9,'virat','khoili','kingofcricket@gmail.com',9973543212,'banglore'),
(10,'ashwin','ravi','spinner@gmail.com',9893443212,'chennai')

INSERT INTO Inventory 
VALUES(1,101,100,'01/02/2021'),(2,102,200,'2/20/2021'),(3,103,300,'01/03/2022'),
(4,104,400,'3/31/2021'),(5,105,500,'05/02/2021'),(6,106,600,'08/03/2022'),
(7,107,700,'2/16/2021'),(8,108,800,'3/11/2021'),(9,109,900,'9/19/2021'),(10,110,400,'2/21/2022')

select * from products
INSERT INTO Products
VALUES(101,'redmi','phone',50),(102,'realme','mobile',9),
(103,'vivo','phone',100),(104,'boat','headset',10),(105,'lenovo','laptop',98),(106,'hp','laptop',40),
(107,'dell','laptop',980),(108,'lg','mobile',98),(109,'thompson','tv',98),(110,'jbl','headset',10)

INSERT INTO Orders
VALUES(111,1,'01/02/2021',100),
(112,2,'1/20/2021',400),
(113,2,'01/03/2021',3500),(114,4,'1/31/2021',4000),(115,5,'01/02/2021',1234),
(116,6,'01/03/2021',4300),(117,7,'1/16/2021',10000),(118,8,'1/11/2021',4356),(119,9,'1/19/2021',2345),(120,10,'1/21/2022',9000)

INSERT INTO OrderDetails
VALUES(11,111,101,100),
(12,112,102,40),
(13,113,103,350),(14,114,104,400),(15,115,105,234),
(16,116,106,300),(17,117,107,10),(18,118,108,46),(19,119,109,25),(20,120,110,90)



SELECT * FROM CUSTOMERS
select * from Inventory
select * from Products
select * from Orders
select * from OrderDetails

--1. Write an SQL query to retrieve the names and emails of all customers.

select FirstName,LastName,email from Customers

--2. Write an SQL query to list all orders with their order dates and corresponding customer  names.

select o.OrderID, o.OrderDate, c.FirstName, c.LastName
From Orders o
INNER JOIN Customers c 
On o.CustomerID = c.CustomerID;

--3. Write an SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address.

INSERT INTO Customers
VALUES(11,'Suresh','raina','chinnathala@gmail.com',6789543267,'chennai')

--4. Write an SQL query to update the prices of all electronic gadgets in the "Products" table by 
--   increasing them by 10%.

UPDATE Products
SET Price = PRICE + PRICE *10/100

--5. Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.
declare @orderid int

set @orderid =6

DELETE FROM Orders
WHERE OrderID = @orderid;

DELETE FROM OrderDetails
WHERE OrderID = @orderid;

--6. Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, order date, and any other necessary information.

INSERT INTO Orders
VALUES(111,1,'2-01-2023',1000)

--7. Write an SQL query to update the contact information (e.g., email and address) of a specific 
--customer in the "Customers" table. Allow users to input the customer ID and new contact information.
declare @customerid int

set @customerid =9


UPDATE Customers
SET email= 'myemail@gmail.com',address='punjab' where CustomerID=@customerid;

--8. Write an SQL query to recalculate and update the total cost of each order in the "Orders" 
--    table based on the prices and quantities in the "OrderDetails" table.declare TotalCost

UPDATE Orders
Set TotalAmount = (select SUM(OrderDetails.Quantity * Products.price)
FROM OrderDetails
join Products on orderdetails.Productid=Products.Productid
WHERE OrderDetails.OrderID =orders.OrderID
GROUP BY OrderDetails.OrderID);

select * from orders




---9. Write an SQL query to delete all orders and their associated order details for a specific 
--customer from the Orders" "and "OrderDetails" tables. Allow users to input the customer ID as a parameter.
declare @customerrid int

set @customerrid =9

DELETE FROM Orders
WHERE customerid = @customerrid;

DELETE FROM OrderDetails
WHERE OrderID =@customerrid;

--- 10 Write an SQL query to insert a new electronic gadget product into the "Products" table, 
---    including product name, category, price, and any other relevant details.


INSERT INTO Products
VALUES(111,'mi','phone',150)

---11. Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from 
---"Pending" to "Shipped"). Allow users to input the order ID and the new status.
declare @orderno int=10,@statuss varchar(30)='shipped'

ALTER TABLE Orders
Add Status varchar(255) default 'pending'

UPDATE Orders
SET Status ='pending' where status is null;

UPDATE Orders
set Status= @statuss where OrderID= @orderno


---12. Write an SQL query to calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table. 
ALTER TABLE Customers
Add Totalorders int;

Update Customers
Set Totalorders = ( select COUNT(OrderID) from Orders
Where Orders.customerid = Customers.customerid
)
select * from customers
----------------------AGGREGATE  FUNCTIONS--------------------------

--1. Query to find out which customers have not placed any orders
select * from orders
select FirstName, LastName
from Customers
left join Orders on Customers.CustomerID = Orders.CustomerID
where Orders.CustomerID is null;

--2. Query to find the total number of products available for sale

select sum(QuantityInStock) as TotalProducts
from Inventory;

---3.Write an SQL query to calculate the total revenue generated by TechShop.

select SUM(TotalAmount) as TotalRevenue
from Orders;

---4.Write an SQL query to calculate the average quantity ordered for products in a specific category. 
---Allow users to input the category name as a parameter.

declare @CategoryName varchar(50);
set @CategoryName= 'phone'

SELECT ProductName, AVG(Quantity) as AverageQuantityOrdered
FROM OrderDetails
INNER JOIN Products on OrderDetails.ProductID = Products.ProductID
where Products.ProductName = '@CategoryName';

--5.Write an SQL query to calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter.

select SUM(TotalAmount) as TotalRevenue
from Orders
where CustomerID = {customer_id};

---6. Write an SQL query to find the customers who have placed the most orders. List their names and the number of orders they've placed.

Select customers.FirstName, COUNT(orders.orderID) as num_orders
from customers
inner join orders on customers.customerID = orders.customerID
group by customers.FirstName
order by num_orders DESC

---7.Write an SQL query to find the most popular product category, which is the one with the highest total quantity ordered across all orders.
 
 SELECT TOP 1 COUNT(*) AS HighestTotalQuantityOrdered,
 Description AS Category FROM Products
 GROUP BY Description ORDER BY HighestTotalQuantityOrdered DESC;

---8. Write an SQL query to find the customer who has spent the most money (highest total revenue) on electronic gadgets. List their name and total spending.

SELECT c.FirstName, c.LastName, SUM(o.TotalAmount) as TotalSpending
from Customers c
INNER JOIN Orders o on c.CustomerID = o.CustomerID
group by c.CustomerID,FirstName,LastName
order by TotalSpending DESC ;

select TOP 1 * from orders

---9. Write an SQL query to calculate the average order value (total revenue divided by the number of orders) for all customers.

SELECT AVG(TotalAmount) AS AverageOrderValue
FROM Orders;

--10. Write an SQL query to find the total number of orders placed by each customer and list their names along with the order count

select FirstName, LastName, COUNT(OrderID) AS OrderCount
from Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
group by FirstName, LastName
order by OrderCount DESC;



------------JOINS------------

--- 1. Write an SQL query to retrieve a list of all orders along with customer information (e.g., customer name) for each order.

SELECT o.orderid, o.orderdate, o.customerid, c.firstname
from orders o
JOIN customers c on o.customerid = c.customerid;

--- 2. Write an SQL query to find the total revenue generated by each electronic gadget product. Include the product name and the total revenue.

select productname, SUM(Price) as total_revenue
from orders
JOIN orderdetails on orders.orderid = orderdetails.orderid
JOIN products on orderdetails.productid = products.productid
group by productname
order by total_revenue DESC;



--3. Write an SQL query to list all customers who have made at least one purchase. Include their 
--names and contact information.

SELECT C.FirstName, C.LastName, C.Email, C.Phone, O.OrderID
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID;

--4. Write an SQL query to find the most popular electronic gadget, which is the one with the highest 
--total quantity ordered. Include the product name and the total quantity ordered.

SELECT TOP 1 P.ProductName, SUM(OD.Quantity) AS TotalQuantityOrdered FROM OrderDetails OD JOIN Products P ON OD.ProductID = P.ProductID
WHERE P.Description LIKE '%Electronic%' GROUP BY P.ProductName ORDER BY TotalQuantityOrdered DESC;

--5. Write an SQL query to retrieve a list of electronic gadgets along with their corresponding 
--categories.

SELECT ProductName, Description AS Category
FROM Products
WHERE Description LIKE '%Electronic%';

--6. Write an SQL query to calculate the average order value for each customer. Include the 
--customer's name and their average order value.

SELECT C.FirstName, C.LastName, AVG(OD.Quantity * P.Price) AS AverageOrderValue
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY C.FirstName, C.LastName;

--7. Write an SQL query to find the order with the highest total revenue. Include the order ID, 
--customer information, and the total revenue.

SELECT TOP 1 O.OrderID, C.FirstName, C.LastName, SUM(OD.Quantity * P.Price) AS TotalRevenue FROM Customers C 
JOIN Orders O ON O.CustomerID = C.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY O.OrderID, C.FirstName, C.LastName
ORDER BY TotalRevenue DESC;

--8. Write an SQL query to list electronic gadgets and the number of times each product has been 
--ordered.

SELECT P.ProductName, COUNT(*) AS OrderCount FROM OrderDetails OD JOIN Products P ON OD.ProductID = P.ProductID 
WHERE P.Description LIKE '%Electronic%' GROUP BY P.ProductName;

--9. Write an SQL query to find customers who have purchased a specific electronic gadget product. 
--Allow users to input the product name as a parameter.

DECLARE @ProductName VARCHAR(50) = '%Electronic%'
SELECT C.FirstName, C.LastName, P.ProductName FROM Customers C JOIN Orders O ON C.CustomerID = O.CustomerID 
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
WHERE P.Description LIKE @ProductName;

--10. Write an SQL query to calculate the total revenue generated by all orders placed within a 
--specific time period. Allow users to input the start and end dates as parameters.

SELECT SUM(OD.Quantity * P.Price) AS TotalRevenue
FROM OrderDetails OD JOIN Products P ON OD.ProductID = P.ProductID
JOIN Orders O ON O.OrderID = OD.OrderID 
WHERE O.OrderDate BETWEEN '2023-11-01' AND '2023-11-05';