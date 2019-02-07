-- -----------------------------------------------------------------------------

-- What is the name of the customer who has the most orders?

SELECT
  Customers.CustomerName,
  COUNT(*) AS num_orders
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID
ORDER BY num_orders DESC

LIMIT 1;

-- -----------------------------------------------------------------------------

-- Which supplier has the highest average product price?

SELECT
  Suppliers.SupplierName,
  AVG(Products.Price) AS avg_price
FROM Suppliers
INNER JOIN Products ON Products.SupplierID = Suppliers.SupplierID
GROUP BY Suppliers.SupplierID
ORDER BY avg_price DESC

LIMIT 1;

-- -----------------------------------------------------------------------------

-- How many different countries are the customers from?

SELECT
  COUNT(DISTINCT(Country)) as num_countries
FROM Customers;

-- -----------------------------------------------------------------------------

-- What category appears in the most orders?

SELECT
  Categories.CategoryName,
  COUNT(*) AS num_orders
FROM Categories
INNER JOIN Products ON Products.CategoryID = Categories.CategoryID
INNER JOIN OrderDetails ON OrderDetails.ProductID = Products.ProductID
GROUP BY Categories.CategoryID
ORDER BY num_orders DESC

LIMIT 1;

-- -----------------------------------------------------------------------------

-- What was the total cost for each order?

SELECT
  OrderDetails.OrderID,
  ROUND(SUM(Products.Price * OrderDetails.Quantity), 2) as total_order_cost
FROM OrderDetails
INNER JOIN Products ON Products.ProductID = OrderDetails.ProductID
GROUP BY OrderDetails.OrderID
ORDER BY total_order_cost DESC;

-- -----------------------------------------------------------------------------

-- Which employee made the most sales (by total cost)?

SELECT
  Employees.FirstName,
  Employees.LastName,
  ROUND(SUM(Products.Price * OrderDetails.Quantity), 2) AS total_employee_sales
FROM Employees
INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
INNER JOIN OrderDetails ON OrderDetails.OrderID = Orders.OrderID
INNER JOIN Products ON Products.ProductID = OrderDetails.ProductID
GROUP BY Employees.EmployeeID
ORDER BY total_employee_sales DESC

LIMIT 1;

-- -----------------------------------------------------------------------------

-- Which employees have BS degrees?

SELECT
  Employees.LastName,
  Employees.FirstName,
  Employees.Notes
FROM Employees
WHERE Employees.Notes LIKE '%BS%';

-- -----------------------------------------------------------------------------

-- Which supplier of 3 or more products has the highest average product price?

SELECT
  Suppliers.SupplierName,
  COUNT(*) AS num_products,
  ROUND(AVG(Products.Price), 2) AS avg_product_price
FROM Suppliers
INNER JOIN Products ON Products.SupplierID = Suppliers.SupplierID
GROUP BY Suppliers.SupplierID
HAVING num_products >= 3
ORDER BY avg_product_price DESC

LIMIT 1;
