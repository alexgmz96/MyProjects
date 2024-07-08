# British Airways Reviews Project

### Dashboard Link: https://public.tableau.com/app/profile/alejandro.gomez2790/viz/BritishAirwaysReview_17141802042030/Dashboard1?publish=yes

## Project Overview

This project involves creating an interactive Tableau dashboard to visualize and analyze British Airways reviews. The dashboard provides detailed insights into various metrics such as overall rating, cabin staff service, entertainment, food and beverages, ground service, seat comfort, and value for money. The dashboard allows users to filter and explore the data by different dimensions such as date, traveler type, seat type, aircraft, and continent.

### Steps Followed

- Step 1. Connecting to Data:

    The dataset consisted of two CSV files: ba_reviews and countries. The ba_reviews table contained reviews with columns such as author, date, place, rating, seat comfort, cabin staff service, food and beverages, ground service, value for money, and entertainment. The countries table was a mapping table containing country names and corresponding regions.

- Step 2. Creating Relationships:

    A relationship was established between the ba_reviews and countries tables using the place column from ba_reviews and the country column from countries. This relationship allowed the use of geographic filters like continent or region in the dashboard.
- Step 3. Map Visualization:

    The place column was converted to a geographic role (country/region) to create a map visualization. The map was customized by adding coastline, adjusting background layers, and setting a specific color scheme. Filters for metrics, date, traveler type, seat type, aircraft, and continent were added to enhance interactivity.
- Step 4. Parameter and Calculated Field:

    A parameter named "Pick a Metric" was created with options such as overall rating, cabin staff service, entertainment, food, ground service, seat comfort, and value. A calculated field named "Metric Selected" was created using a case statement to display the selected metric based on the parameter.
- Step 5. Filters:

    Filters for date (continuous month), seat type, traveler type, aircraft group, and continent were added. These filters were applied to all worksheets in the dashboard to ensure consistency.
- Step 6. Summary Metrics:

    Summary metrics were created for average ratings of overall, cabin staff service, entertainment, food, ground service, seat comfort, and value. These metrics were formatted and aligned neatly on the dashboard.
- Step 7. Line Chart:

    A line chart was created to display the average selected metric by month. The chart was formatted to remove unnecessary lines and titles for a cleaner look.
- Step 8. Dual Bar Chart:

    A dual bar chart was created to show the average selected metric by aircraft and the number of reviews for each aircraft. Colors were adjusted and tooltips were added for better readability.
- Step 9. Formatting and Final Touches:

    Tooltips for all visualizations were formatted to display relevant information such as the selected metric and number of reviews. Consistent formatting was ensured across all visualizations. The dashboard layout was set to floating, and the size and positioning of each element were adjusted for a cohesive look. A vertical separator line was added between filters and visualizations for better clarity.
- Step 10. Interactivity:

    Visualizations were enabled to be used as filters, allowing users to interact with the dashboard dynamically. All filters and interactions were tested to ensure smooth functionality.
- Step 11. Publishing:

    The dashboard was published to Tableau Public for easy access and sharing. The dashboard was set to the desired size, and all elements were correctly positioned before publishing.

### Insights

A three-page report was created on Power BI Desktop and published to Power BI Service. The dashboard provides the following insights:

#### [1] Overall Rating Trends:
*	The line chart indicates fluctuations in the overall rating over the years. Periods of decline could be investigated for specific events or changes in service that may have caused lower ratings.

#### [2] Geographical Insights:
*	The map visualization shows the average overall rating by country. Countries with higher ratings could indicate regions where British Airways excels in service, while lower ratings highlight areas needing improvement.
* For example, countries like the UK and USA show higher ratings, suggesting strong performance in these regions.

#### [3] Aircraft Performance:
*	The dual bar chart reveals that certain aircraft types, such as the Boeing 747-400 and Boeing 787, have higher average ratings. This information could be used to prioritize the use of these aircraft types for customer satisfaction.
* The volume of reviews also indicates the popularity or frequency of certain aircraft in the fleet.

#### [4] Traveler Type and Seat Type Analysis:
*	Filters for traveler type and seat type provide insights into how different customer segments rate their experience. Business travelers and first-class passengers may have different expectations and satisfaction levels compared to economy class or leisure travelers.
* Understanding these differences can help tailor services and marketing strategies to specific traveler segments.

#### [5] Service Metrics:
*	The summary metrics at the top provide a quick overview of various service aspects such as cabin staff service, entertainment, food, ground service, seat comfort, and value for money.
* Lower ratings in specific areas, such as entertainment or seat comfort, highlight opportunities for targeted improvements.


### Conclusions and Recommendations

**1. Service Improvement:** 

* Focus on areas with lower ratings such as entertainment and seat comfort. Consider upgrading in-flight entertainment systems and enhancing seat comfort to boost overall customer satisfaction.
* Review feedback from regions with lower ratings to identify specific issues and implement targeted improvements.

**2.	Fleet Management:** 

* Prioritize the use of aircraft types with higher ratings (e.g., Boeing 747-400, Boeing 787) on popular or long-haul routes to enhance customer experience.
* Conduct maintenance and service upgrades on aircraft types with lower ratings to bring them up to the desired standard.

**3.	Customer Segmentation:** 

* Use insights from traveler type and seat type analysis to tailor services and marketing campaigns. For instance, improve business class amenities to attract more business travelers.
* Offer personalized services based on traveler preferences to enhance the overall travel experience.

**4.	Geographical Strategy:**

* Leverage high ratings in certain countries to strengthen market presence and brand reputation. Consider promotional campaigns and loyalty programs in these regions.
* Address issues in countries with lower ratings through targeted service enhancements and customer engagement initiatives.

**5.	Continuous Monitoring:**

* Regularly update the dashboard with new review data to monitor trends and measure the impact of implemented improvements.
* Use the dashboard as a tool for ongoing performance evaluation and decision-making to ensure continuous improvement in customer satisfaction.

This Tableau project demonstrates the creation of an interactive and insightful dashboard to analyze British Airways reviews. The dashboard provides valuable insights into customer satisfaction across various metrics and dimensions, enabling data-driven decision-making. By focusing on identified areas for improvement and leveraging strengths, British Airways can enhance its overall service quality and customer experience.

## Dashboard

![WhatsApp Image 2024-07-07 at 11 13 19 PM](https://github.com/alexgmz96/MyProjects/assets/149654623/e327ba0a-ac99-4111-8036-05e3021d6440)


