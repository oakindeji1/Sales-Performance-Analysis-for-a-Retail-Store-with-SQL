create database Captone_project; use [Captone_project]  --Tables were Imported  --reading the tables select * from [dbo].[Sales] select * from [dbo].[Customer]  -- Analysing each tables -- Sales select count(distinct(Customer_Id)) from Sales select count(*) As Numbers_of_Sales from Sales  --Customer select count(distinct(CustomerId)) As Total_Number_of_Customer from Customer  --Adding Balance row Alter table [dbo].[Sales] add Total_Sales decimal(18,2)   select Total_Sales from [dbo].[Sales] select (UnitPrice * Quantity) as Total_Sales from [dbo].[Sales]  update [dbo].[Sales] set Total_Sales = (UnitPrice * Quantity)  select sum(Total_Sales) from [dbo].[Sales]  --Getting the max, Min and the Average Balance select max(Total_Sales) from [dbo].[Sales] select min(Total_Sales) from [dbo].[Sales] select Avg(Total_Sales) from [dbo].[Sales]  --retrieving the total sales for each product category.  SELECT      Sum(Total_Sales) As TotalSales,      COUNT(Product) AS TotalProducts, 	Region FROM Sales GROUP BY Region ORDER BY TotalSales desc;  --Number of sales transactions in each region select * from Sales SELECT      Sum(Quantity) As TotalQuantity, 	Sum(UnitPrice) As TotalPrice,     Region FROM Sales GROUP BY Region ORDER BY TotalPrice desc;  --finding the highest-selling product by total sales value.  /* SELECT Product, TotalSales
FROM (
    SELECT Product, SUM(Quantity * UnitPrice) AS TotalSales
    FROM Sales
    GROUP BY Product
) AS ProductSales
WHERE TotalSales = (SELECT MAX(SUM(Quantity * UnitPrice))
                    FROM Sales
                    GROUP BY Product); */  SELECT top 1(Product), 
       SUM(Quantity * UnitPrice) AS TotalSales
FROM Sales
GROUP BY Product
ORDER BY TotalSales DESC
 --calculate total revenue per product.  SELECT Product, SUM(Quantity * UnitPrice) AS TotalSales
    FROM Sales
    GROUP BY Product  --calculate monthly sales totals for the current year. Alter table [dbo].[Sales] add Monthname nvarchar(50)  ALTER TABLE Sales
DROP COLUMN Monthname;  update [dbo].[Sales] set Monthname = DATENAME(MONTH, OrderDate)

select * from Sales
/*SELECT 
    OrderDate,
    DATENAME(MONTH, OrderDate)
FROM Sales;  select DATENAME(MONTH, OrderDate) As Monthname, SUM(Quantity * UnitPrice)  FROM Sales
    GROUP BY Monthname 	order by Monthname Desc*/   select  Monthname, SUM(Quantity * UnitPrice) As Total_Sales  FROM Sales
    GROUP BY Monthname 	order by Total_Sales Desc  --find the top 5 customers by total purchase amount.   Select top 5(Customer_Id), SUM(Quantity * UnitPrice) As Total_Sales FROM Sales
    GROUP BY Customer_Id 	order by Total_Sales Desc  -- calculate the percentage of total sales contributed by each region. Select Region,  Sum(Total_Sales) As Total_Sales, (Sum(Total_Sales)*100/(select Sum(Total_Sales) from Sales)) As percentage_of_total_sales from Sales GROUP BY Region  --identify products with no sales in the last quarter.  SELECT DISTINCT Product
FROM Sales
WHERE Product NOT IN (
    SELECT DISTINCT Product
    FROM Sales
    WHERE OrderDate >= DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)
      AND OrderDate < DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()), 0)
);                       