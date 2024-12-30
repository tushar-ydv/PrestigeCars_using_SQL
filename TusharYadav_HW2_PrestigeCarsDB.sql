/*Tushar Yadav - Data Mananagement Homework 2*/
/*Prestige Cars Database*/

#Q1. Display the country name and the sales region for the countries in the database.
SELECT
	CountryName,SalesRegion 
FROM
	country;

#Q2. Create a complete list of every vehicle purchased and the amount paid (cost) to pur- chase it.
SELECT
	s.*, m.* 
FROM
	stock s
	JOIN model m ON s.ModelID = m.ModelID 
WHERE
	s.DateBought IS NOT NULL 
ORDER BY
	s.DateBought;

#Q3. The CEO of Prestige Cars needs to obtain a list of the countries where the company’s customers can be found. 
#Write a query to display such a list of country names (not ISO codes.)
SELECT DISTINCT
	c.CountryName 
FROM
	country c
	JOIN customer cr ON c.CountryISO2 = cr.Country 
ORDER BY
	c.CountryName;

#Q4. The CEO firmly believes that effective cost control is vital for the company’s survival. 
#She wants a list of all the cars that have ever been bought since Prestige Cars started trading. 
#Write a query to display a list of the purchase cost for every make and model ever held in stock.
SELECT
	s.Cost,s.DateBought,m.ModelName,make.MakeName 
FROM
	stock s
	LEFT JOIN model m ON s.ModelID = m.ModelID
	LEFT JOIN make ON m.MakeID = make.MakeID;
WHERE 
	s.DateBought IS NOT NULL;

#Q5. The CEO has requested a list of all vehicles sold along with the selling price and any discounts that have been applied. 
#Write a query to generate such a list.
SELECT
	s.StockCode,
	mk.MakeName,
	md.ModelName,
	sd.SalePrice,
	sd.LineItemDiscount 
FROM
	salesdetails sd
	JOIN stock s ON sd.StockID = s.StockCode
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID 
ORDER BY
	mk.MakeName,md.ModelName,s.StockCode;

#Q6. The IT director is convinced that the database needs some cleanup. 
#He is certain that there are makes of vehicles stored in the Make table for which there are no corresponding models. 
#Write a query to generate a list of such makes of vehicles with no corresponding models.
SELECT
	make.MakeID,
	make.MakeName 
FROM
	make
	LEFT JOIN model ON make.MakeID = model.MakeID 
WHERE
	model.ModelID IS NULL;

#Q7. The CEO has requested a quick list of staff so that she can produce an org chart for the next board meeting. 
#There is a table named Staff in the database. 
#Use this table to create a report of all staff members, their department, and their manager’s name.
SELECT
	s1.StaffID,
	s1.StaffName,
	s1.Department,
	s2.StaffName AS manager_name 
FROM
	staff s1
	LEFT JOIN staff s2 ON s1.ManagerID = s2.StaffID;

#Q8. The SalesCategory table in the database is a small table that contains the reference information that allows the sales manager to 
#categorize each car sold according to the sale price. 
#The sales manager wants to use the data in this table to display the specific sales category of each vehicle sold. 
#Your result set should include the make, model, sale price, and the category description of each vehiccle sold. 
#Write a query to generate such a list.
SELECT
	mk.MakeName,
	md.ModelName,
	sd.SalePrice,
	sc.CategoryDescription AS sale_category 
FROM
	salesdetails sd
	JOIN stock s ON sd.StockID = s.StockCode
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID
	JOIN salescategory sc ON sd.SalePrice BETWEEN sc.LowerThreshold 
	AND sc.UpperThreshold;

#Q9. The CEO wants a list of all countries that Prestige Cars sells to, with a list of all makes that the company has ever stocked. 
#When you ask for more details, she says that she also wants to see every make appear for every country because this allows her to 
#galvanize the sales teams to sell every make in every country. Write a query to generate such a list.
SELECT
	c.CountryName,
	mk.MakeName 
FROM
	country c
	CROSS JOIN make mk 
ORDER BY
	c.CountryName,
	mk.MakeName;

#Q10. The finance director needs to know the makes and models the company has bought and stocked. Write a query to generate a list.
SELECT
	ma.MakeName, mo.ModelName
FROM
	prestigecars.stock st
JOIN
	prestigecars.model mo ON st.ModelID = mo.ModelID
JOIN
	prestigecars.make ma ON mo.MakeID = ma.MakeID
GROUP BY 
	ma.MakeName, mo.ModelName
ORDER BY
	ma.MakeName, mo.ModelName;
	
#Q11. The CEO wants a list of all models that Prestige Cars has ever sold and when they were sold. Write a query to create such a list.
SELECT
	mk.MakeName,
	md.ModelName,
	s.StockCode,
	sa.SaleDate 
FROM
	salesdetails sd
	JOIN stock s ON sd.StockID = s.StockCode
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID
	JOIN sales sa ON sd.SalesID = sa.SalesID;

#Q12. A new marketing director has just arrived at Prestige Cars. 
#The first thing that she wants to know is how the color of cars varies by model purchased. 
#She wants a report displaying all the models Prestige Cars has had in stock in red, green, or blue. Write a query to generate this list.
SELECT
	mk.MakeName,
	md.ModelName,
	s.Color 
FROM
	stock s
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID 
WHERE
	s.Color IN ( 'Red', 'Green', 'Blue' )
ORDER BY s.Color;

#Q13. The marketing director wants a list of all makes that were ever sold except Ferrari. Write a query to create this list.
SELECT DISTINCT
	mk.MakeName 
FROM
	salesdetails sd
	JOIN stock s ON sd.StockID = s.StockCode
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID 
WHERE
	mk.MakeName <> 'Ferrari';

#Q14. The marketing director wants a list of all makes that were ever sold except Porsche, Aston Martin, and Bentley. Write a query to create this list.
SELECT DISTINCT
	mk.MakeName 
FROM
	salesdetails sd
	JOIN stock s ON sd.StockID = s.StockCode
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID 
WHERE
	mk.MakeName NOT IN ('Porsche','Aston Martin','Bentley');

#Q15. The finance director would like to get an idea of the higher-value cars that are in stock or have been sold; 
#more specifically, he wants to see a list of all cars where the purchase price was over £50,000.00. Write a query to generate this list.
SELECT
	mk.MakeName,
	md.ModelName,
	s.StockCode,
	s.Cost AS PurchasePrice,
	s.DateBought 
FROM
	stock s
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID 
WHERE
	s.Cost > 50000.00;
    
#Q16. The CEO asked for a list of all makes of car that Prestige Cars has stocked where the parts cost is between £1,000 and £2,000. 
#Write a query to generate this list.
SELECT
	mk.MakeName,
	s.StockCode,
	s.PartsCost 
FROM
	stock s
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID 
WHERE
	s.PartsCost BETWEEN 1000 
	AND 2000 
ORDER BY
	mk.MakeName;

#Q17. Write a query to display the names of all make and models of the right-hand drive (RHD) models that Prestige Cars has sold.
SELECT
	mk.MakeName,
	md.ModelName,
	s.StockCode 
FROM
	salesdetails sd
	JOIN stock s ON sd.StockID = s.StockCode
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID 
WHERE
	s.IsRHD = 1;

#Q18. Write a query to list all makes except Bentleys where the cars are red, green, or blue.
SELECT 
	mk.MakeName,
	s.StockCode
FROM
	stock s
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID 
WHERE
	mk.MakeName <> 'Bentley' 
	AND s.Color IN ( 'Red', 'Green', 'Blue' ) 
ORDER BY
	mk.MakeName;

#Q19. The finance director has requested a list of all red cars ever bought where their repair cost or the cost of spare parts exceeds £1,000.00. Write a query to create this list.
SELECT
	mk.MakeName,
	md.ModelName,
	s.StockCode,
	s.Color,
	s.RepairsCost,
	s.PartsCost,
	s.DateBought 
FROM
	stock s
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID 
WHERE
	s.Color = 'Red' 
	AND s.DateBought IS NOT NULL 
	AND ( s.RepairsCost > 1000 OR s.PartsCost > 1000 );

#Q20. The finance director says: “I want to see all red, green, and blue Rolls-Royce Phantoms - 
#or failing that any vehicle where both the parts cost and the repair cost are over £5,500.00.” Write a query to create this list.
SELECT
	mk.MakeName,
	md.ModelName,
	s.StockCode,
	s.Color,
	s.PartsCost,
	s.RepairsCost,
	s.DateBought 
FROM
	stock s
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID 
WHERE
	(
		mk.MakeName = 'Rolls Royce' 
		AND md.ModelName = 'Phantom' 
	AND s.Color IN ( 'Red', 'Green', 'Blue' )) 
	OR ( s.PartsCost > 5500 AND s.RepairsCost > 5500 );

#Q21. Write a query to return the row containing the “Dark purple” vehicle. Note the case for the color. 
#The correct query should return only one row. Hint: You can use the keyword BINARY (not the data type.)
SELECT
	* 
FROM
	stock 
WHERE
	BINARY Color = 'Dark purple';

#Q22. You have developed an excellent reputation as a data analyst at Prestige Cars. The receptionist comes to you with a request for help. 
#She knows that Prestige Cars has a customer with Peter (or was that Pete?) somewhere in the name, and you need to find this person in the database. 
#Create a list of all such names by using an SQL query.
SELECT
	* 
FROM
	customer 
WHERE
	CustomerName LIKE '%Pete%';

#Q23. Write a query to return all makes of the cars with capital ”L” in the name of the marque. 
#The correct query should not return models with lowercase ”l” anywhere in the name. 
#For example, Alfa Romeo or Bentley should not be returned. The correct query should return three rows only.
SELECT
	* 
FROM
	make 
WHERE
	BINARY MakeName LIKE '%L%';

#Q24. The finance director informs you that the invoice number field is structured in such a way 
#that you can identify the country of sale from certain characters at a specific point in the field. 
#He wants you to use this to isolate all sales made to French customers showing the model and the invoice number for each sale made. 
#The correct query should return 68 rows.
#Here is an example of the breakdown of the InvoiceNumber field. GBPGB001#Left three characters indicate the currency of sale, in this case GBP.
#Characters 4 and 5 indicate the destination country, in this case Great Britain.
#The last three characters provide a sequential invoice number.
#So, the invoice number GBPGB001 tells you that this sale was made in pounds sterling to a client in the United Kingdom — and is invoice No 001.
#method one 
SELECT DISTINCT
	md.ModelName,
	s.InvoiceNumber 
FROM
	sales s
	JOIN salesdetails sd ON s.SalesID = sd.SalesID
	JOIN stock sk ON sd.StockID = sk.StockCode
	JOIN model md ON sk.ModelID = md.ModelID
	JOIN customer c ON c.CustomerID = s.CustomerID
	JOIN country ct ON ct.CountryISO2 = c.Country 
WHERE
	c.Country = 'FR';

#Q25. The marketing director has noticed that the corporate database is missing postalcodes (ZIP codes) for some clients. 
#She has asked for a list of all customers without this vital piece of information. Write a query and create the list for the marketing director.
SELECT
	* 
FROM
	customer 
WHERE
	PostCode IS NULL;

#Q26. The finance director cannot find a spreadsheet that tells him what the exact cost of every car sold is, 
#including the purchase cost along with any repairs, parts, and transport costs. This is called the cost of sales. 
#Using an SQL query display the make name, model name, and the total cost of every car sold.
SELECT
	mk.MakeName,
	md.ModelName,
	s.StockCode,
	( s.Cost + s.RepairsCost + s.PartsCost + s.TransportInCost ) AS TotalCostOfSales 
FROM
	stock s
	JOIN salesdetails sd ON s.StockCode = sd.StockID
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID
	JOIN sales sl ON sl.SalesID = sd.SalesID 
WHERE
	sl.SaleDate IS NOT NULL;

#Q27. The finance director is pleased with your cost analysis from question 26 above. 
#He now wants you to calculate the net margin. Write a query to display the make name, model name, and the net margin.
SELECT
	mk.MakeName,
	md.ModelName,
	s.StockCode,
	sd.SalePrice,
	( s.Cost + s.RepairsCost + s.PartsCost + s.TransportInCost ) AS TotalCostOfSales,
	(
	sd.SalePrice - ( s.Cost + s.RepairsCost + s.PartsCost + s.TransportInCost )) AS NetMargin 
FROM
	stock s
	JOIN salesdetails sd ON s.StockCode = sd.StockID
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID;

#Q28. The finance director is getting more and more excited at the thought that SQL can address every question he needs for his analysis. 
#He now wants you to give him a list containing the ratio of cost to sales. Write an SQL query to provide this information to the finance director.
SELECT
	mk.MakeName,
	md.ModelName,
	s.StockCode,
	( s.Cost + s.RepairsCost + s.PartsCost + s.TransportInCost ) AS TotalCostOfSales,
	sd.SalePrice,
	( s.Cost + s.RepairsCost + s.PartsCost + s.TransportInCost ) / sd.SalePrice AS CostToSalesRatio 
FROM
	stock s
	JOIN salesdetails sd ON s.StockCode = sd.StockID
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID;

#Q29. Imagine that the sales director wants to test the improvement in margins if you in- creased the sale prices by 5 percent but kept costs the same. 
#Using SQL, display the make name, the model name, and the improved sales margins.
SELECT
	mk.MakeName,
	md.ModelName,
	s.StockCode,
	( sd.SalePrice * 1.05 ) - ( s.Cost + s.RepairsCost + s.PartsCost + s.TransportInCost ) AS ImprovedSalesMargin 
FROM
	stock s
	JOIN salesdetails sd ON s.StockCode = sd.StockID
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID;

#Q30. Write a SQL query to display the make names of the models which represent 50 most profitable sales in percentage terms. Arrange your list in descending order.
SELECT
	mk.MakeName,
	md.ModelName,
	s.StockCode,
	(( sd.SalePrice - ( s.Cost + s.RepairsCost + s.PartsCost + s.TransportInCost )) / sd.SalePrice ) * 100 AS ProfitMarginPercentage 
FROM
	stock s
	JOIN salesdetails sd ON s.StockCode = sd.StockID
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID 
ORDER BY
	ProfitMarginPercentage DESC 
	LIMIT 50;

#Q31. The CEO of Prestige Cars Ltd. wants to know what the net profit is on sales. 
#She particularly wants to see a list of sales for all vehicles making a profit of more than £5,000.00. 
#Write a query to display this list. The correct query will return 178 rows.
SELECT DISTINCT ma.MakeName, mo.ModelName, sd.SalePrice
FROM prestigecars.stock st
JOIN prestigecars.model mo ON st.ModelID = mo.ModelID
JOIN prestigecars.make ma ON mo.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON sd.StockID = st.StockCode
JOIN prestigecars.sales s ON sd.SalesID = s.SalesID
WHERE sd.SalePrice - (st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0) + st.TransportInCost) > 5000
ORDER BY ma.MakeName, mo.ModelName, sd.SalePrice desc;

#Q32. It is late in the day, and you are thinking of heading home. Just as your eyes drift toward your lunch bag, 
#in rushes the sales director with a request to list all car makes and models sold where the profit exceeds £5,000.00 
#and the car is red and the discount greater than or equal to £1,000.00 — or both the parts cost and the repairs cost are greater than £500.00. 
#Write a query to generate this list. The correct query will return 63 rows.
SELECT DISTINCT ma.MakeName, mo.ModelName
FROM prestigecars.stock st
JOIN prestigecars.model mo ON st.ModelID = mo.ModelID
JOIN prestigecars.make ma ON mo.MakeID = ma.MakeID
JOIN prestigecars.salesdetails sd ON sd.StockID = st.StockCode
WHERE ((sd.SalePrice - (st.Cost + st.RepairsCost + IFNULL(st.PartsCost, 0) + st.TransportInCost) > 5000)
AND (st.Color = 'red' AND sd.LineItemDiscount >= 1000))
OR (st.PartsCost > 500 AND st.RepairsCost > 500)
ORDER BY ma.MakeName, mo.ModelName DESC;

#Q33. The finance director has tasked you to calculate the aggregate sales, cost, and gross profit for all vehicles sold. Write an SQL query to provide this summary.
SELECT
	SUM( sd.SalePrice ) AS TotalSales,
	SUM( s.Cost + s.RepairsCost + s.PartsCost + s.TransportInCost ) AS TotalCost,
	SUM(
	sd.SalePrice - ( s.Cost + s.RepairsCost + s.PartsCost + s.TransportInCost )) AS GrossProfit 
FROM
	stock s
	JOIN salesdetails sd ON s.StockCode = sd.StockID;

#Q34. The sales manager has emailed you with a request to calculate the aggregate cost for each model of car. Write an SQL query to provide this list to the sales manager.
SELECT
	md.ModelName,
	SUM( s.Cost + s.RepairsCost + s.PartsCost + s.TransportInCost ) AS TotalCost 
FROM
	stock s
	JOIN model md ON s.ModelID = md.ModelID 
GROUP BY
	md.ModelName 
ORDER BY
	TotalCost DESC;

#Q35. The finance director wants you to dig deeper into the data and calculate the total purchase cost for every make and model of vehicle bought. 
#Write an SQL query for generating this result.
SELECT
	mk.MakeName,
	md.ModelName,
	SUM( s.Cost ) AS TotalPurchaseCost 
FROM
	stock s
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID 
GROUP BY
	mk.MakeName,
	md.ModelName 
ORDER BY
	TotalPurchaseCost DESC;

#Q36. An essential business metric is the average cost of goods bought. 
#The finance director would want to see the average purchase price of every make and model of car ever bought. Write an SQL query to generate this list.
SELECT DISTINCT
	mk.MakeName,
	md.ModelName,
	AVG( s.Cost ) AS AveragePurchasePrice 
FROM
	stock s
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID 
GROUP BY
	mk.MakeName,
	md.ModelName 
ORDER BY
	AveragePurchasePrice DESC;

#Q37. The CEO has stated categorically that any business must be able to see at a glance how many items have been sold per product category. 
#In the case of Prestige Cars Ltd., visualizing (not using Tableau) the number of cars sold by make and model. Write an SQL query to generate this list.
SELECT
	mk.MakeName,
	md.ModelName,
	COUNT( sd.StockID ) AS NumberOfCarsSold 
FROM
	salesdetails sd
	JOIN stock s ON sd.StockID = s.StockCode
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID 
GROUP BY
	mk.MakeName,
	md.ModelName 
ORDER BY
	NumberOfCarsSold DESC;

#Q38. The sales director asked for the number of different countries that Prestige Cars has ever sold vehicles to. Write an SQL query to answer this question.
SELECT
	COUNT( DISTINCT c.Country ) AS NumberOfCountriesSoldTo 
FROM
	salesdetails sd
	JOIN sales s ON sd.SalesID = s.SalesID
	JOIN customer c ON s.CustomerID = c.CustomerID;

#Q39. The sales manager wants you to identify the largest and smallest sale prices for each model of car sold. Write an SQL query to generate this list. 
#The list should contain the model name, the top sale price, and the bottom sale price for each model.
SELECT
	md.ModelName,
	MAX( sd.SalePrice ) AS HighestSalePrice,
	MIN( sd.SalePrice ) AS LowestSalePrice 
FROM
	salesdetails sd
	JOIN stock s ON sd.StockID = s.StockCode
	JOIN model md ON s.ModelID = md.ModelID 
GROUP BY
	md.ModelName 
ORDER BY
	md.ModelName;

#Q40. The sales director asks you ”How many red cars have been sold for each make of the car?” 
#Write an SQL query to create a list in response to the question. The correct query should return 13 rows.
SELECT
	mk.MakeName,
	COUNT( sd.StockID ) AS RedCarsSold 
FROM
	salesdetails sd
	JOIN stock s ON sd.StockID = s.StockCode
	JOIN model md ON s.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID 
WHERE
	s.Color = 'Red' 
GROUP BY
	mk.MakeName 
ORDER BY
	RedCarsSold DESC;

#Q41. As part of the company’s worldwide sales drive, the sales director wants to focus Prestige Cars’ marketing energies on the countries 
#where you are making the most sales. Show the data for countries where more than 50 cars have been sold. The correct query should return only 2 rows.
SELECT
	c.Country,
	COUNT( sd.StockID ) AS CarsSold 
FROM
	salesdetails sd
	JOIN sales s ON sd.SalesID = s.SalesID
	JOIN customer c ON s.CustomerID = c.CustomerID 
GROUP BY
	c.Country 
HAVING
	COUNT( sd.StockID ) > 50 
ORDER BY
	CarsSold DESC;
	
#Q42. The sales director wants to know who are the clients who have not only bought at least three cars 
#but where each of the three vehicles generated a profit of at least £5,000.00. Write an SQL query to 
#generate a list of such customers and the number of cars sold to such customers. The correct query should return 27 rows.
SELECT
	c.CustomerID,
	c.CustomerName,
	COUNT( sd.StockID ) AS CarsSold 
FROM
	salesdetails sd
	JOIN sales s ON sd.SalesID = s.SalesID
	JOIN stock st ON sd.StockID = st.StockCode
	JOIN customer c ON s.CustomerID = c.CustomerID 
WHERE
	(
	sd.SalePrice - ( st.Cost + st.RepairsCost + st.PartsCost + st.TransportInCost )) >= 5000 
GROUP BY
	c.CustomerID,
	c.CustomerName 
HAVING
	COUNT( sd.StockID ) >= 3 
ORDER BY
	CarsSold DESC;

#Q43. The CEO wants to see what drives the company’s bottom line. 
#To this end, she wants to isolate the three most lucrative makes sold so that she can focus sales efforts around those brands. 
#Write an SQL query to identify these three most lucrative makes.
SELECT
	mk.MakeName,
	SUM(
	sd.SalePrice - ( st.Cost + st.RepairsCost + st.PartsCost + st.TransportInCost )) AS TotalProfit 
FROM
	salesdetails sd
	JOIN stock st ON sd.StockID = st.StockCode
	JOIN model md ON st.ModelID = md.ModelID
	JOIN make mk ON md.MakeID = mk.MakeID 
GROUP BY
	mk.MakeName 
ORDER BY
	TotalProfit DESC 
	LIMIT 3;