-- Question 1. Retrieve all customers who have placed at least one order. 

SELECT DISTINCT Customers.CustomerName
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- Question 2. Retrieve all customers and their orders, including customers who have not placed any orders.

SELECT *  
FROM Customers 
LEFT JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID;


-- Question 3. Retrieve all orders and their corresponding customers, including orders placed by unknown
-- customers.

SELECT *
FROM Customers 
RIGHT JOIN Orders  
ON Customers.CustomerID = Orders.CustomerID;


-- Question 4. Display all customers and orders, whether matched or not.

(SELECT *
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID)
UNION
(SELECT *
FROM Customers
RIGHT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID) ;


-- Question 5. Find customers who have not placed any orders.

SELECT Customers.CustomerID,
       Customers.CustomerName,
       Orders.OrderID
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderID IS NULL;


-- Question 6. Retrieve customers who made payments but did not place any orders.

SELECT Customers.CustomerID,
       Customers.CustomerName,
       Orders.OrderID,
       Payments.PaymentID,
       Payments.Amount
FROM Payments
LEFT JOIN Orders
ON Payments.CustomerID = Orders.CustomerID
JOIN Customers
ON Payments.CustomerID = Customers.CustomerID
WHERE Orders.OrderID IS NULL;



-- Question 7. Generate a list of all possible combinations between Customers and Orders.

SELECT *
FROM Customers
CROSS JOIN Orders;


-- Question 8. Show all customers along with order and payment amounts in one table.

SELECT Customers.CustomerID,
       Customers.CustomerName,
       Orders.OrderID,
       Orders.Amount AS OrderAmount,
       Payments.PaymentID,
       Payments.Amount AS PaymentAmount
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
LEFT JOIN Payments
ON Customers.CustomerID = Payments.CustomerID;


-- Question 9. Retrieve all customers who have both placed orders and made payments.

SELECT Customers.CustomerID,
       Customers.CustomerName,
       Orders.OrderID,
       Payments.PaymentID
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
INNER JOIN Payments
ON Customers.CustomerID = Payments.CustomerID;


