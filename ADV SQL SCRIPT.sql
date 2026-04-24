CREATE DATABASE advanced_sql_assignment;
USE advanced_sql_assignment;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
(1, 'Laptop', 'Electronics', 50000),
(2, 'Mobile', 'Electronics', 20000),
(3, 'Headphones', 'Accessories', 2000),
(4, 'Keyboard', 'Accessories', 1500),
(5, 'Chair', 'Furniture', 3000);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate) VALUES
(1, 1, 2, '2023-01-01'),
(2, 2, 5, '2023-01-02'),
(3, 3, 10, '2023-01-03'),
(4, 4, 8, '2023-01-04'),
(5, 5, 3, '2023-01-05'),
(6, 1, 1, '2023-01-06'),
(7, 2, 2, '2023-01-07');

-- Q6. Write a CTE to calculate the total revenue for each product
-- (Revenues = Price × Quantity), and return only products where  revenue > 3000

WITH RevenueCTE AS (
    SELECT 
        p.ProductID,
        p.ProductName,
        SUM(p.Price * s.Quantity) AS Revenue
    FROM Products p
    JOIN Sales s 
        ON p.ProductID = s.ProductID
    GROUP BY p.ProductID, p.ProductName
)
SELECT *
FROM RevenueCTE
WHERE Revenue > 3000;

-- Q7. Create a view named  vw_CategorySummary that shows:
-- Category, TotalProducts, AveragePrice.
CREATE VIEW vw_CategorySummary AS
SELECT 
    Category,
    COUNT(*) AS TotalProducts,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;
-- to view data:
SELECT * FROM vw_CategorySummary;


-- Q8. Create an updatable view containing ProductID, ProductName, and Price.  
-- Then update the price of ProductID = 1 using the view.
CREATE VIEW vw_ProductDetails AS
SELECT 
    ProductID,
    ProductName,
    Price
FROM Products;

UPDATE vw_ProductDetails
SET Price = 55000
WHERE ProductID = 1;
-- verify
SELECT * FROM Products WHERE ProductID = 1;


-- Q9. Create a stored procedure that accepts a category name and returns all products belonging to that category
DELIMITER $$

CREATE PROCEDURE GetProductsByCategory(IN cat_name VARCHAR(50))
BEGIN
    SELECT 
        ProductID,
        ProductName,
        Category,
        Price
    FROM Products
    WHERE Category = cat_name;
END $$

DELIMITER ;
CALL GetProductsByCategory('Electronics');


-- Q10. Create an AFTER DELETE trigger on the Products table that archives deleted product rows into a new table ProductArchive. The archive should store ProductID, ProductName, Category, Price, and DeletedAt timestamp.

CREATE TABLE ProductArchive (
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    DeletedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DELIMITER $$

CREATE TRIGGER trg_after_delete
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO ProductArchive (ProductID, ProductName, Category, Price, DeletedAt)
    VALUES (OLD.ProductID, OLD.ProductName, OLD.Category, OLD.Price, NOW());
END $$

DELIMITER ;

-- TEST THE TRIGGER
DELETE FROM Products WHERE ProductID = 1;

-- VERIFY
SELECT * FROM ProductArchive;





