CREATE DATABASE creditcard_db;
use creditcard_db;

-- Total number of transactions
SELECT COUNT(*) AS Total_Transactions
FROM credit_card_master;

-- Total amount spent by all customers
SELECT SUM(Amount) AS Total_Spend
FROM credit_card_master;

-- Average value of a transaction
SELECT ROUND(AVG(Amount),2) AS Avg_Transaction_Value
FROM credit_card_master;

-- Which city contributes the most spending?
SELECT City,
       SUM(Amount) AS Total_Spend
FROM credit_card_master
GROUP BY City
ORDER BY Total_Spend DESC
LIMIT 1;

-- Which expense category contributes the most spending?
SELECT `Exp Type`, SUM(Amount) AS Total_Spend
FROM credit_card_master
GROUP BY `Exp Type`
ORDER BY Total_Spend DESC
LIMIT 1;

-- Compare spending by gender
SELECT Gender, SUM(Amount) AS Total_Spend,
       ROUND( SUM(Amount) * 100 /
           (SELECT SUM(Amount) FROM credit_card_master),2) AS Spend_Percentage
FROM credit_card_master
GROUP BY Gender;

-- Total spending across quarters
SELECT Quarter, SUM(Amount) AS Total_Spend
FROM credit_card_master
GROUP BY Quarter
ORDER BY Quarter;

-- Quarterly growth compared to previous quarter
WITH quarterly AS (
    SELECT Quarter, SUM(Amount) AS Total_Spend
    FROM credit_card_master
    GROUP BY Quarter
)
SELECT Quarter,
       Total_Spend,
       LAG(Total_Spend) OVER(ORDER BY Quarter) AS Previous_Quarter,
       ROUND(((Total_Spend - LAG(Total_Spend) OVER(ORDER BY Quarter)) /
         LAG(Total_Spend) OVER(ORDER BY Quarter)  ) * 100, 2)
       AS Growth_Percentage
FROM quarterly;

-- Monthly growth compared to previous month
WITH monthly AS ( SELECT Year, Month, Month_Number,
           SUM(Amount) AS Total_Spend
    FROM credit_card_master
    GROUP BY Year, Month, Month_Number
)
SELECT Year, Month, Total_Spend,
LAG(Total_Spend) OVER(ORDER BY Year, Month_Number) AS Previous_Month,
       ROUND(  ((Total_Spend -
      LAG(Total_Spend) OVER(ORDER BY Year, Month_Number))  /
        LAG(Total_Spend) OVER(ORDER BY Year, Month_Number)
       ) * 100, 2) AS MoM_Growth_Percentage
FROM monthly;

-- Top five cities by total spending
SELECT City,SUM(Amount) AS Total_Spend,
       RANK() OVER(ORDER BY SUM(Amount) DESC) AS City_Rank
FROM credit_card_master
GROUP BY City
ORDER BY City_Rank
LIMIT 5;

-- Which cities contribute the highest total credit card spending?
SELECT City, SUM(Amount) AS Total_Spend
FROM credit_card_master
GROUP BY City
ORDER BY Total_Spend DESC;

-- Which expense categories account for the most spending?
SELECT `Exp Type`,
    SUM(Amount) AS Total_Spend
FROM credit_card_master
GROUP BY `Exp Type`
ORDER BY Total_Spend DESC;

-- Compare total spending across card types.
SELECT `Card Type`,
    SUM(Amount) AS Total_Spend,
    AVG(Amount) AS Avg_Transaction
FROM credit_card_master
GROUP BY `Card Type`
ORDER BY Total_Spend DESC;

-- Compare spending by gender.
SELECT Gender,
    SUM(Amount) AS Total_Spend,
    AVG(Amount) AS Avg_Spend
FROM credit_card_master
GROUP BY Gender;

-- Track monthly spending trend.
SELECT Year,  Month,
    SUM(Amount) AS Monthly_Spend
FROM credit_card_master
GROUP BY Year, Month, Month_Number
ORDER BY Year, Month_Number;

-- Classify transactions into Low, Medium, and High value.
SELECT Amount,
       CASE
           WHEN Amount < 1000 THEN 'Low'
           WHEN Amount BETWEEN 1000 AND 5000 THEN 'Medium'
           ELSE 'High'
       END AS Transaction_Size
FROM credit_card_master;

-- Rank cities by spending.
SELECT City, SUM(Amount) AS Total_Spend,
       RANK() OVER (ORDER BY SUM(Amount) DESC) AS City_Rank
FROM credit_card_master
GROUP BY City
ORDER BY City_Rank
LIMIT 5;

-- Find the top spending category within every city.
WITH city_category AS (
    SELECT City, `Exp Type`,
           SUM(Amount) AS Total_Spend,
           RANK() OVER (PARTITION BY City ORDER BY SUM(Amount) DESC) AS Rank_No
    FROM credit_card_master
    GROUP BY City, `Exp Type`
)
SELECT City, `Exp Type`, Total_Spend
FROM city_category
WHERE Rank_No = 1;

-- Which cities spend above the average city spend
SELECT City, SUM(Amount) AS Total_Spend
FROM credit_card_master
GROUP BY City
HAVING SUM(Amount) > (SELECT AVG(city_total) FROM (SELECT SUM(Amount) AS city_total FROM credit_card_master GROUP BY City) x)
ORDER BY Total_Spend DESC;

-- Compare spending across quarters.
SELECT Quarter, SUM(Amount) AS Total_Spend
FROM credit_card_master
GROUP BY Quarter
ORDER BY Quarter;

-- Which cities have the highest average transaction amount?
SELECT City, AVG(Amount) AS Avg_Spend
FROM credit_card_master
GROUP BY City
ORDER BY Avg_Spend DESC;

-- Which cities have the highest number of transactions?
SELECT City, COUNT(*) AS Transactions
FROM credit_card_master
GROUP BY City
ORDER BY Transactions DESC;

-- Compare total spending by year.
SELECT Year, SUM(Amount) AS Total_Spend
FROM credit_card_master
GROUP BY Year
ORDER BY Year;

-- Which gender contributes the highest spending in each city?
WITH gender_rank AS (
    SELECT City, Gender,
           SUM(Amount) AS Total_Spend,
           RANK() OVER ( PARTITION BY City ORDER BY SUM(Amount) DESC  ) AS Rank_No
	FROM credit_card_master
    GROUP BY City, Gender
)
SELECT * FROM gender_rank WHERE Rank_No = 1;

-- Which months generated the highest total spending?
SELECT Year, Month,
       SUM(Amount) AS Total_Spend
FROM credit_card_master
GROUP BY Year, Month, Month_Number
ORDER BY Total_Spend DESC;



