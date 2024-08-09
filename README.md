# Data Cleaning & EDA: Companies Layoffs

This project involves cleaning a dataset containing information about layoffs from companies around the world. The cleaning process includes removing duplicates, standardizing data, handling null or blank values, and removing unnecessary columns. After cleaning the data, an exploratory data analysis (EDA) is performed to gain insights into the dataset.

Table of Contents:-

1) Data Description
2) Data Cleaning Steps
      Step 1: Remove Duplicates
      Step 2: Standardize Data
      Step 3: Handle NULL or Blank Values
      Step 4: Remove Unnecessary Columns
3) Exploratory Data Analysis (EDA)
  a.Summary Statistics
  b.Distribution Analysis
  c.Trend Analysis
  d.Date Range and Missing Values
  e.Company Analysis

Data Description:-
The dataset contains information about layoffs from various companies, including details such as the company name, location, industry, total number of layoffs, percentage of layoffs, date, stage, country, and funds raised in millions.

Data Cleaning Steps:-
Step 1: Remove Duplicates
We identify and remove duplicate records based on multiple columns (company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) by using a row_number() window function.

Step 2: Standardize Data
Standardizing data involves converting date formats to a consistent format and ensuring all text fields are in the same case (e.g., all lowercase or all uppercase).

Step 3: Handle NULL or Blank Values
Handling NULL or blank values involves filling them with appropriate default values or removing records where necessary.

Step 4: Remove Unnecessary Columns
Remove columns that are not relevant to the analysis and do not affect other processes. Care should be taken to ensure these columns are not used elsewhere in the project.

Exploratory Data Analysis (EDA):-
After cleaning the data, exploratory data analysis (EDA) is performed to gain insights into the dataset. The EDA phase includes various steps to understand the distribution, trends, and key statistics of the data.

a.Summary Statistics:-
Calculated summary statistics for the total_laid_off column, including the mean, maximum, and minimum values. This provides an overview of the scale of layoffs across companies and helps identify outliers or extreme values.

b.Distribution Analysis:-
Analyzed the distribution of layoffs across different companies. Identified companies with the highest number of layoff events to understand which sectors or businesses are most affected. This analysis helps in recognizing patterns and pinpointing industries that are more vulnerable to layoffs.

c.Trend Analysis:-
Examined trends in layoffs over time, particularly monthly trends. Aggregated layoff data by month and year to identify patterns and seasonal effects on layoffs. This analysis reveals if there are any specific periods with higher layoff activities, such as during economic downturns or post-holiday seasons.

d.Date Range and Missing Values:-
Checked the range of dates in the dataset to understand the time span covered. Ensured no missing dates that could affect trend analysis, providing a comprehensive view of the layoffs over the observed period. This step ensures the data is complete and accurate for time-series analysis.

e.Company Analysis:-
Identified the top companies with the most layoffs and analyzed layoff trends within these top companies. This helps in pinpointing key players and understanding their layoff patterns over time. Analyzing the top companies also provides insights into the potential reasons behind mass layoffs, such as company performance, industry downturns, or restructuring efforts.

Conclusion:-
The data cleaning process ensured that the dataset was free of inconsistencies and ready for analysis. The EDA provided valuable insights into the distribution and trends of layoffs, helping to identify patterns, outliers, and key factors contributing to layoffs. These insights lay the groundwork for further analysis or predictive modeling, offering a deeper understanding of the layoff landscape.
