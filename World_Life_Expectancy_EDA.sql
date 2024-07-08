#Exploratory Data Analysis 

#Taking a glimpse of the data
SELECT *
FROM world_life_expectancy
;

#Checking which Countries have been doing really good increasing their life expectancy over the years
SELECT Country,
MIN(`Life expectancy`),
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years ASC
;

#Analyzing the average increase of life expectancy of the entire world
SELECT Year, ROUND(AVG(`Life expectancy`), 2)
FROM world_life_expectancy
WHERE `Life expectancy`<> 0
GROUP BY Year
ORDER BY Year;

#Reviewing if there is a correlation between life expectancy and the overall
#economy level of a contry (GDP) and compare them to the world average
SELECT Country, ROUND(AVG(`Life expectancy`), 1) AS Life_Exp, ROUND(AVG(GDP), 1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP >0
ORDER BY GDP DESC
;

SELECT *
FROM world_life_expectancy;

#If we consider 1500 to be the halfway point of our table, we can divide the countries 
#into the top and bottom half in terms of their GDP level. Then we will compare the outcome vs the average
SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM world_life_expectancy;
#It turns out there is a high correlation between this variable, and we could repeat the same process with all of the other variables
#but we will use a Business Intelligence tool in order to do so

#We will look at the correlation between life expectancy and the Status of the country but taking into consideation the number of countries
#within each status
SELECT Status, ROUND(AVG(`Life expectancy`), 1)
FROM world_life_expectancy
GROUP BY Status
;

#Since we have 32 Developed countries against 161 Developing countries, there is a big difference to take into account
SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`), 1)
FROM world_life_expectancy
GROUP BY Status
;

#We will compare the countries against BMI to see if there is also a correlation
SELECT Country, ROUND(AVG(`Life expectancy`), 1) AS Life_Exp, ROUND(AVG(BMI), 1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI >0
ORDER BY BMI ASC
;

#Let's apply a window function to determine Rolling Total or the total amount of deaths over the last 15 years as established in the
#data 
SELECT Country,
Year,
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
;
