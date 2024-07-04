# World Life Expectancy Exploratory Data Analysis


## Problem Overview

This project involves performing exploratory data analysis (EDA) on a dataset containing information on life expectancy around the world. The analysis aims to identify trends, correlations, and insights that can be drawn from the data regarding life expectancy, GDP, BMI, and other factors.

### Steps Followed

- Step 1. Taking a Glimpse of the Data:

        SELECT *
        FROM world_life_expectancy;

- Step 2. Identifying Countries with Significant Increase in Life Expectancy:

        SELECT Country,
        MIN(`Life expectancy`),
        MAX(`Life expectancy`),
        ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Increase_15_Years
        FROM world_life_expectancy
        GROUP BY Country
        HAVING MIN(`Life expectancy`) <> 0
        AND MAX(`Life expectancy`) <> 0
        ORDER BY Life_Increase_15_Years ASC;


- Step 3. Analyzing the Average Increase of Life Expectancy Globally:

        SELECT Year, ROUND(AVG(`Life expectancy`), 2)
        FROM world_life_expectancy
        WHERE `Life expectancy` <> 0
        GROUP BY Year
        ORDER BY Year;


- Step 4. Reviewing Correlation Between Life Expectancy and GDP:

        SELECT Country, ROUND(AVG(`Life expectancy`), 1) AS Life_Exp, ROUND(AVG(GDP), 1) AS GDP
        FROM world_life_expectancy
        GROUP BY Country
        HAVING Life_Exp > 0
        AND GDP > 0
        ORDER BY GDP DESC;


- Step 5. Comparing Life Expectancy Based on GDP Levels:

        SELECT
        SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
        AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
        SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
        AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
        FROM world_life_expectancy;


- Step 6. Correlation Between Life Expectancy and Country Status:

        SELECT Status, ROUND(AVG(`Life expectancy`), 1)
        FROM world_life_expectancy
        GROUP BY Status;

        SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`), 1)
        FROM world_life_expectancy
        GROUP BY Status;


- Step 7. Correlation Between Life Expectancy and BMI:

        SELECT Country, ROUND(AVG(`Life expectancy`), 1) AS Life_Exp, ROUND(AVG(BMI), 1) AS BMI
        FROM world_life_expectancy
        GROUP BY Country
        HAVING Life_Exp > 0
        AND BMI > 0
        ORDER BY BMI ASC;


- Step 8. Calculating Rolling Total of Adult Mortality:

        SELECT Country,
        Year,
        `Life expectancy`,
        `Adult Mortality`,
        SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
        FROM world_life_expectancy;


### Insights

This exploratory data analysis project provides valuable insights into the factors affecting life expectancy around the world. The SQL script with the help of visualization tools effectively identifies trends, correlations, and key metrics that can inform further analysis and decision-making, as we can observe in the following examples:

#### [1] Top 10 Countries with Significant Increase in Life Expectancy Over the Years

This bar plot shows the top 10 countries that have achieved the most significant increase in life expectancy over a given period. Countries at the top of this list have made substantial improvements in health, healthcare, and living conditions.

![output](https://github.com/alexgmz96/MyProjects/assets/149654623/b3461f69-2a8e-4735-81f3-e2731a6e0c63)


* These countries most likely have implemented effective health policies, improved healthcare infrastructure, or had socioeconomic improvements contributing to increased life expectancy.
* The differences between countries could highlight where policy and health system interventions have been particularly successful.

#### [2] Average Increase of Life Expectancy Globally

This line plot shows the trend of average life expectancy globally over the years.

![output(1)](https://github.com/alexgmz96/MyProjects/assets/149654623/f5612743-526b-4603-9d4c-f8f9569f1b4d)

* A consistent upward trend suggests global improvements in healthcare, nutrition, and overall living standards.
* Any dips or fluctuations in the trend could indicate periods of global health crises or other significant events impacting life expectancy.

#### [3] Correlation Between Life Expectancy and GDP

This scatter plot displays the correlation between average life expectancy and GDP for each country.

![output(2)](https://github.com/alexgmz96/MyProjects/assets/149654623/8ab52502-e14c-49c9-a208-bdf576da0db2)


* A positive correlation indicates that countries with higher GDP tend to have higher life expectancy.
* This suggests that economic prosperity often translates into better healthcare, nutrition, and living conditions, which contribute to longer life spans.
* Outliers (countries with high GDP but low life expectancy, or vice versa) can indicate unique situations, such as political instability, inequality, or other social factors.

#### [4] Comparison of Life Expectancy Based on GDP Levels

This bar plot compares the average life expectancy between countries with high GDP (≥ 1500) and low GDP (≤ 1500).

![output(3)](https://github.com/alexgmz96/MyProjects/assets/149654623/fe8ea1e8-f8f1-4d33-b2c5-e57a1da4dc51)

* Countries with high GDP have significantly higher average life expectancy compared to those with low GDP.
* This highlights the role of economic resources in ensuring access to healthcare, nutrition, and safe living conditions.
* It underscores the importance of economic development in improving public health outcomes.

#### [5] Correlation Between Life Expectancy and Country Status

This bar plot shows the average life expectancy for developed and developing countries.

![output(4)](https://github.com/alexgmz96/MyProjects/assets/149654623/39033588-1e94-479e-89ad-3e9b2960cea7)

* Developed countries have a higher average life expectancy compared to developing countries.
* This reflects the better healthcare systems, higher standards of living, and greater access to health services in developed countries.
* It emphasizes the need for targeted interventions and support to improve health outcomes in developing countries.


#### [6] Correlation Between Life Expectancy and BMI

This scatter plot illustrates the relationship between average life expectancy and BMI for each country.

![output(5)](https://github.com/alexgmz96/MyProjects/assets/149654623/7f9f4fad-b832-421c-80b1-f77e0d733572)

* Countries clustering at healthy BMI levels with high life expectancy highlight the importance of balanced nutrition.
* Extremely low or high BMI values could be associated with lower life expectancy, indicating undernutrition or obesity-related health issues.


#### [7] Rolling Total of Adult Mortality Over the Years

This line plot shows the rolling total of adult mortality for selected countries over the years.

![output(6)](https://github.com/alexgmz96/MyProjects/assets/149654623/8a9ff172-fb4b-4cfa-9451-7820eee3ec97)

* The trends for each country can reveal the impact of healthcare interventions, epidemics, conflicts, or other significant events on adult mortality.
* A declining trend indicates improvements in healthcare and living conditions, whereas an increasing trend may point to worsening health conditions or crises.
* Comparing countries can highlight the differences in how various nations have managed health and mortality over time.


### Conclusions

**1. Economic Prosperity and Health:** The strong correlation between GDP and life expectancy emphasizes the role of economic growth in enhancing health outcomes.

**2.	Healthcare and Development:** Developed countries and those with higher GDP show better life expectancy, reflecting the importance of healthcare infrastructure and services.

**3.	Policy and Interventions:** Significant improvements in life expectancy in certain countries underscore the effectiveness of targeted health policies and interventions.

**4.	Global Trends:** The overall upward trend in global life expectancy indicates worldwide improvements in health, although disparities still exist between developed and developing nations.

**5.	Nutrition and Lifestyle:** The correlation with BMI suggests that both undernutrition and overnutrition are critical factors affecting life expectancy.

These general insights can guide policymakers, health professionals, and researchers in understanding the factors influencing life expectancy and developing strategies to address health disparities and improve global health outcomes.

