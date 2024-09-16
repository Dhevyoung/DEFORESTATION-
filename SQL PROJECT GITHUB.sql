CREATE DATABASE MOTHER_NATURE;
SELECT * FROM forest_area;

SELECT * FROM Land_Area
ORDER BY country_name ASC;

SELECT * FROM region
WHERE country_name LIKE 'A%A' OR country_name LIKE 'C%'


SELECT DISTINCT Country_code, Country_name FROM Forest_Area
ORDER BY Country_name ASC;

SELECT DISTINCT Country_code, Country_name FROM region
ORDER BY Country_name ASC;

/*an error found in the REGION table. For data 219, 'World' is not a country, making that row invalid.*/
DELETE FROM region WHERE country_name = 'world';

/*QUESTION 1: What are the total number of countries involved in deforestation?
ANSWER: 176*/ 
SELECT COUNT (DISTINCT country_name) FROM (SELECT  country_name, year, forest_area_sqkm,
RANK() OVER(PARTITION BY country_name ORDER BY forest_area_sqkm DESC) AS COL_RANK FROM Forest_Area) Table0
WHERE COL_RANK > 1



/*QUESTION 2: Show the income groups of countries having total area ranging from 75,000 to 150,000 square meter?*/

SELECT R.country_name, income_group, total_area_sq_mi FROM Region AS R 
JOIN Land_area AS LA
ON R.country_code = LA.country_code
WHERE LA.total_area_sq_mi BETWEEN 75000 AND 150000;


/*QUESTION 3: Calculate average area in square miles for countries in the 'upper middle income region'. 
Compare the result with the rest of the income categories.*/ 

--Table of just countries and their total area square miles in the Upper middke income

SELECT Land.country_name, Land.country_code, year, total_area_sq_mi, R.region, R.income_group FROM Land_Area AS Land
JOIN Region AS R
ON Land.country_code=R.country_code
WHERE income_group = 'Upper middle income'
ORDER BY country_name ASC;

--Average of 'Area of Square Miles' for countries in the 'Upper middle income'
-- A table comparing the average of each income group

SELECT AVG (total_area_sq_mi) AS AVG_UMI
FROM (SELECT Land.country_name, Land.country_code, year, total_area_sq_mi, R.region, R.income_group FROM Land_Area AS Land
JOIN Region AS R
ON Land.country_code=R.country_code
WHERE income_group = 'Upper middle income') UMI;

SELECT income_group, AVG(total_area_sq_mi) AS AVG_sqm
FROM (SELECT R.country_name, R.country_code, income_group, total_area_sq_mi FROM Region AS R
JOIN Land_Area AS Land
ON R.country_name = Land.country_name) R_Land
GROUP BY income_group

/* Question 4: Determine the total forest area in square km for countries in the 'high income' group. Compare result with the rest of the income categories.
--Table of just countries and their total area square miles in the Upper middke income*/

SELECT Land.country_name, Land.country_code, year, total_area_sq_mi, R.region, R.income_group FROM Land_Area AS Land
JOIN Region AS R
ON Land.country_code=R.country_code
WHERE income_group = 'Upper middle income'
ORDER BY country_name ASC;

--Total forest area in square km for countries in the 'Upper middle income' 
-- A table comparing the total forest area in square km of each income group

SELECT SUM (forest_area_sqkm) AS SUM_UMI
FROM (SELECT Forest.country_name, Forest.country_code, year, forest_area_sqkm, R.region, R.income_group FROM Forest_Area AS Forest
JOIN Region AS R
ON Forest.country_code=R.country_code
WHERE income_group = 'Upper middle income') UMI;

SELECT income_group, SUM(forest_area_sqkm) AS SUM_fas
FROM (SELECT R.country_name, R.country_code, income_group, forest_area_sqkm FROM Region AS R
JOIN Forest_Area AS Forest
ON R.country_name = Forest.country_name) R_Land
GROUP BY income_group


/*Question 5: Show countries from each region(continent) having the highest total forest areas. */
SELECT * FROM region;
SELECT * FROM forest_area;

SELECT DISTINCT region FROM region;

SELECT DISTINCT country_name, region
FROM (SELECT R.country_name, R.country_code, region, forest_area_sqkm FROM Region AS R
JOIN Forest_Area AS F
ON R.country_code=F.country_code)RF
WHERE region = 'Europe & Central Asia'
ORDER BY country_name ASC
-- 58 countries are under the 'Europe & Central Asia' region.
