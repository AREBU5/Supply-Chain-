

-- What is the average number of days for shipping (real) and days for shipment (scheduled)?
SELECT ROUND(Avg(days_for_shipping),0) AS 'Average Number Days of Shippping', 
	   ROUND(AVG(Days_for_shipment_scheduled),0) AS 'Average Number for Shipment (Scheduled)'  
FROM datacosupplychaindataset;

-- What is the average benefit per order and sales per customer? 
SELECT CONCAT( '$ ', ROUND(AVG(Benefit_per_order),2)) AS 'Average Benefit per Order', 
	   CONCAT( '$ ', ROUND(AVG(Sales_per_customer),2)) AS 'Average sales per customer'
FROM datacosupplychaindataset;

-- How many orders experienced late delivery risk? What percentage of total orders does this represent?
SELECT Late_delivery_risk, Order_Item_Total
FROM datacosupplychaindataset
WHERE Late_delivery_risk = 1;

-- What are the different categories of products in the supply chain data, and what are their sales figures?
SELECT Categor_Name, ROUND(sum(Sales),2) 
FROM datacosupplychaindataset
GROUP BY Categor_Name
ORDER BY Sales DESC;

-- Which customer city has the highest sales? What about the lowest sales?
SELECT Customer_City, sales AS 'Highest Sales' 
FROM datacosupplychaindataset
ORDER BY sales DESC
LIMIT 1;
SELECT Customer_City, sales AS 'Lowest Sales' 
FROM datacosupplychaindataset
ORDER BY sales ASC
LIMIT 1;

-- How many orders are from each customer country?
SELECT order_country, count(Order_Country) AS "Country's Order"
FROM datacosupplychaindataset
GROUP BY Order_country;

-- How many orders were placed in each department?
SELECT Department_Name, sum(Order_Item_Quantity) AS 'Number of Items Placed'
FROM datacosupplychaindataset
GROUP BY Department_Name
ORDER BY Order_Item_Quantity DESC; 

-- What are the most common shipping modes used in the orders?
SELECT Shipping_Mode, COUNT(Shipping_Mode) AS 'Number of Shippping Mode'
FROM datacosupplychaindataset 
GROUP BY Shipping_Mode
ORDER BY COUNT(Shipping_Mode) DESC;

-- Which market (region) has the highest sales and profit per order?
SELECT Market, 
	ROUND(SUM(Sales),2) AS 'Total Sales',
	ROUND(SUM(Order_Profit_Per_Order),2)  AS 'Profit per order'
FROM datacosupplychaindataset
GROUP BY Market
LIMIT 1;

-- Give a list of orders that are pending orders
SELECT Categor_Name, 
	   concat(Customer_Fname," ", Customer_Lname) AS "Customer's Name", 
       Order_Country, 
       order_date, 
       Order_Status
FROM datacosupplychaindataset
WHERE Order_Status = 'PENDING'
ORDER BY order_date;



