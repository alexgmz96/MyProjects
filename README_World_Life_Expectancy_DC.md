# World Life Expectancy Data Cleaning Project


## Problem Overview

This project involves cleaning a dataset containing information on life expectancy around the world. The data cleaning process includes identifying and handling duplicates, dealing with missing values, and ensuring data consistency for accurate analysis. The cleaned data can then be used for further exploratory analysis and reporting.

### Dataset:
* The dataset used in this project is WorldLifeExpectancy.csv.

### Steps Followed

**-1. Loading Data.** Load the initial dataset to examine its structure and contents:

        SELECT *
        FROM World_Life_Expectancy.world_life_expectancy;


**-2. Taking a Glimpse of the Data.** Preview the data to understand its columns and initial data entries:

        SELECT *
        FROM world_life_expectancy;

**-3. Checking for Duplicates.** Identify duplicate entries based on a combination of Country and Year:

        SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
        FROM world_life_expectancy
        GROUP BY Country, Year, CONCAT(Country, Year)
        HAVING COUNT(CONCAT(Country, Year)) > 1;

**-4. Removing Duplicates Using Subqueries.** Use subqueries to identify rows that need to be removed:

        SELECT *
        FROM (
        SELECT Row_ID, CONCAT(Country, Year),
        ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
        FROM world_life_expectancy
        ) AS Row_Table
        WHERE Row_Num > 1;

* Remove the identified duplicate rows:

        SET SQL_SAFE_UPDATES = 0;

        DELETE FROM world_life_expectancy
        WHERE Row_ID IN (
        SELECT Row_ID
        FROM (
        SELECT Row_ID, CONCAT(Country, Year),
        ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
        FROM world_life_expectancy
        ) AS Row_Table
        WHERE Row_Num > 1
        );


**-5. Checking for Missing Values.** Identify rows with missing values in the Status column:

        SELECT DISTINCT(Status)
        FROM world_life_expectancy
        WHERE Status <> '';

* Check if there are any null values in the Status column:

        SELECT DISTINCT(Status)
        FROM world_life_expectancy
        WHERE Status IS NULL;



**-6. Analyzing and Populating Missing Values.** Analyze the feasibility of populating missing Status values based on available data:

        SELECT DISTINCT(Country)
        FROM world_life_expectancy
        WHERE Status = 'Developing';

* Populate missing Status values using data from other years:

        UPDATE world_life_expectancy
        SET Status = 'Developing'
        WHERE Country IN (SELECT DISTINCT(Country)
                  FROM world_life_expectancy
                  WHERE Status = 'Developing');

* Further refine by joining the table to itself to fill in the missing Status values:

        UPDATE world_life_expectancy t1
        JOIN world_life_expectancy t2
                ON t1.Country = t2.Country
        SET t1.Status = 'Developing'
        WHERE t1.Status = ''
        AND t2.Status <> ''
        AND t2.Status = 'Developing';

* The JOIN operation here is used to match each record in the table t1 (which has missing Status values) with records in the same table t2 (which have non-missing Status values for the same country). This allows us to fill in the missing Status values in t1 based on the information available in t2.

**-7. Handling Developed Countries.** Populate missing values for developed countries similarly using a JOIN:

        UPDATE world_life_expectancy t1
        JOIN world_life_expectancy t2
                ON t1.Country = t2.Country
        SET t1.Status = 'Developed'
        WHERE t1.Status = ''
        AND t2.Status <> ''
        AND t2.Status = 'Developed';

* Similar to the previous step, the JOIN operation matches records with missing Status values in t1 with records in t2 that have the Status as 'Developed'. This allows us to accurately fill in the missing Status values for developed countries.

**-8. Checking for Other Missing Values.** Identify rows with missing values in the Life expectancy column:

        SELECT *
        FROM world_life_expectancy
        WHERE `Life expectancy` = '';

**-9. Populating Missing Life Expectancy Values.** Calculate the average life expectancy for missing values based on adjacent years:

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
        WHERE t1.`Life expectancy` = '';

* Populate the missing values with the calculated averages using JOINs:

        UPDATE world_life_expectancy t1
        JOIN world_life_expectancy t2
                ON t1.Country = t2.Country
                AND t1.Year = t2.Year - 1
        JOIN world_life_expectancy t3
                ON t1.Country = t3.Country
                AND t1.Year = t3.Year + 1
        SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`) / 2, 1)
        WHERE t1.`Life expectancy` = '';

* Here, the JOIN operation is used to combine the table with itself twice: once to get the life expectancy from the previous year (t2) and once to get it from the following year (t3). This allows us to calculate the average life expectancy for the missing values based on the values from adjacent years.

**-10. Final Review.** Ensure that the entire dataset is now clean and ready for analysis:

        SELECT *
        FROM world_life_expectancy;

![WhatsApp Image 2024-07-04 at 1 40 35 PM](https://github.com/alexgmz96/MyProjects/assets/149654623/a174765f-013c-4aa6-bbb8-22f892103c18)

### Insights and Results

* The dataset is now cleaned, ensuring accuracy and consistency.
* Duplicate entries have been identified and removed.
* Missing values have been populated based on logical assumptions and existing data patterns, maintaining data integrity.
* The use of JOIN operations allowed for effective data imputation by leveraging related records within the dataset.

#### Conclusion

This data cleaning project ensures that the World Life Expectancy dataset is accurate, consistent, and ready for analytical purposes. The SQL script efficiently handles duplicates and missing values, improving the overall quality of the data. The JOIN operations played a crucial role in accurately filling missing values by utilizing related records within the dataset. The cleaned data can now be used for further exploratory analysis and reporting, providing valuable insights into global life expectancy trends and factors influencing them.
