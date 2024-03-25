#Data Cleaning

SELECT * FROM World_Life_Expectancy.world_life_expectancy;


#Taking a glimpse of the data
SELECT * 
FROM world_life_expectancy;

#Checking for duplicates
SELECT Coworld_life_expectancyworld_life_expectancyuntry, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1
;

#Removing duplicates using subqueries
SELECT *
FROM (
	SELECT Row_ID,
	CONCAT(Country, Year),
	ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
	FROM world_life_expectancy
	) AS Row_Table
WHERE Row_Num > 1
;


SET SQL_SAFE_UPDATES = 0;


DELETE FROM world_life_expectancy
WHERE 
	Row_ID IN (
    SELECT Row_ID
FROM (
	SELECT Row_ID,
	CONCAT(Country, Year),
	ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
	FROM world_life_expectancy
	) AS Row_Table
WHERE Row_Num > 1
)
;

#Checking for missing values
SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE Status <> ''
;

#Checking for missing values
SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE Status IS NULL
;
#There are no null values

#Analyzing whether it is viable to populate missing values according to their Status
SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing'
;

#Populating missing values according to their Status in other years
UPDATE world_life_expectancy
SET Status = 'Developing'
WHERE Country IN (SELECT DISTINCT(Country)
				FROM world_life_expectancy
				WHERE Status = 'Developing');
                
#Joining table to itself in order to be able to populate
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developing'
; 

#Checking if the previous query worked properly
SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = ''
;

#The previous query worked properly except for one country (United States of America) because we only took into account Developing Countries
SELECT *
FROM world_life_expectancy
WHERE Country = 'United States of America' 
;

#Populating missing values for Developed Countries as well
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed'
; 

#Checking for missing values in another column
SELECT *
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;
#There are only 2 missing values


SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy
;

#We will join the table to itself two times so we are able to populate the missing values with an average 'Life expectancy' from the previous and the following year
SELECT t1.Country, t1.Year, t1.`Life expectancy`, 
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`) / 2, 1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;

#Populating the missing values with the calculations from the previous query
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`) / 2, 1)
WHERE t1.`Life expectancy` = ''
;

#Reviewing the whole data is now clean
SELECT *
FROM world_life_expectancy
;
