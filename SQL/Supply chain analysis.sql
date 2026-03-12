-- Viewing Tables
USE project_supply_chain_data;
SELECT * FROM supply_chain_data LIMIT 5;
SELECT COUNT(*) FROM supply_chain_data;
SELECT * FROM Supplier _Performance;

-- Checking null values
SELECT * FROM supply_chain_data
 WHERE Price IS NULL OR Manufacturing_costs IS NULL;
 
 -- Revenue calculation 
SELECT SKU, Price, Number_of_products_sold, Price * Number_of_products_sold AS revenue FROM supply_chain_data;
SELECT  SUM(Price * Number_of_products_sold) AS Total_revenue FROM supply_chain_data;

-- Total cost calculations 
SELECT SUM(Manufacturing_costs * Number_of_products_sold) AS Total_manufacturing_cost FROM supply_chain_data;
SELECT SUM(Shipping_costs * Number_of_products_sold)  AS Total_shipping_cost FROM supply_chai_data;
SELECT SUM(Costs) AS Total_transportation_cost FROM supply_chain_data;

-- Profit 
SELECT SUM(Price * Number_of_products_sold) -
SUM(Manufacturing_costs * Number_of_products_sold) -
SUM(Shipping_costs* number_of_products_sold) -
SUM(costs) AS Total_profit FROM supply_chain_data;

-- Top 10 sku by revenue 
SELECT SKU, SUM(Price * Number_of_products_sold) AS Revenue FROM supply_chain_data
GROUP BY SKU
ORDER BY Revenue DESC
LIMIT 10;

-- Avg defect rates by supplier 
SELECT Supplier_name, AVG(Defect_rates) AS avg_defect_rate FROM Supplier_Performance
GROUP BY Supplier_name; 

-- Avg lead time by supplier 
SELECT Supplier_name, AVG(Lead_time) AS Avg_lead_time FROM supplier_performance
GROUP BY Supplier_name;

-- Join
 SELECT sc.Product_type, sc.Supplier_name, SUM(sc.Price * sc.Number_of_products_sold) AS Revenue,
AVG(sp.Defect_rates) AS Avg_defect_rate
FROM supply_chain_data AS sc
JOIN Supplier_Performance AS sp
ON sc.Supplier_name = sp.Supplier_name
GROUP BY sc.product_type, sc.supplier_name;