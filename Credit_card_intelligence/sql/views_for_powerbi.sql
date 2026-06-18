-- Total spend and transaction count by city
CREATE OR REPLACE VIEW vw_city_spend AS
SELECT City,
       COUNT(*) AS Total_Transactions,
       SUM(Amount) AS Total_Spend,
       AVG(Amount) AS Avg_Transaction_Value
FROM credit_card_master
GROUP BY City;
SELECT * FROM vw_city_spend;

-- Spend by expense category
CREATE OR REPLACE VIEW vw_category_spend AS
SELECT `Exp Type` AS Expense_Category,
       COUNT(*) AS Transactions,
       SUM(Amount) AS Total_Spend,
       AVG(Amount) AS Avg_Spend
FROM credit_card_master
GROUP BY `Exp Type`;
SELECT * FROM vw_category_spend;

-- Monthly spending trend
CREATE OR REPLACE VIEW vw_monthly_trend AS
SELECT Year, Month,  Month_Number,
	   SUM(Amount) AS Total_Spend,
       COUNT(*) AS Total_Transactions
FROM credit_card_master
GROUP BY Year, Month, Month_Number
ORDER BY Year, Month_Number;
SELECT * FROM vw_monthly_trend;

-- Consumer spending profile by city, gender and card type
CREATE OR REPLACE VIEW vw_consumer_profile AS
SELECT City,  Gender, `Card Type`,
      COUNT(*) AS Transactions,
       SUM(Amount) AS Total_Spend,
       AVG(Amount) AS Avg_Spend
FROM credit_card_master
GROUP BY City, Gender, `Card Type`;
SELECT * FROM vw_consumer_profile;






