           -- Exploratory Data Analysis --

SELECT * 
FROM layoffs_staging2;

				-- EASIER QUERIES

SELECT MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoffs_staging2;

-- Looking at Percentage to see how big these layoffs were

SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM layoffs_staging2
WHERE  percentage_laid_off IS NOT NULL;

-- Which companies had 1 which is basically 100 percent of they company laid off

SELECT *
FROM layoffs_staging2
WHERE  percentage_laid_off = 1;

SELECT *
FROM layoffs_staging2
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Companies with the biggest single Layoff

SELECT company, total_laid_off
FROM layoffs_staging
ORDER BY 2 DESC
LIMIT 5;

-- Companies with the most Total Layoffs

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;

SELECT location, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 ASC;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT company, SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

									-- TOUGHER QUERIES--

-- Earlier we looked at Companies with the most Layoffs. Now let's look at that per month.

-- Rolling Total of Layoffs Per Month

SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY dates
ORDER BY dates ASC;

SELECT SUBSTRING(`date`,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) is not null
GROUP BY dates
ORDER BY dates ASC;

-- now use it in a CTE so we can query off of it

WITH Rolling_total AS 
(
SELECT SUBSTRING(`date`,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) is not null 
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates, total_laid_off,
SUM(total_laid_off) OVER (ORDER BY dates ASC) as rolling_total_layoffs
FROM Rolling_total
ORDER BY dates ASC;

-- Companies with the most Layoffs per year.

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT company, year(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company,year(`date`)
ORDER BY company; 

SELECT company, year(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company,year(`date`)
ORDER BY sum(total_laid_off) desc;
					-- (or)-- 
SELECT company, year(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company,year(`date`)
ORDER BY 3 desc;

WITH Company_Year AS 
(
  SELECT company, YEAR(`date`) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(`date`) 
)
select * 
from Company_Year;

WITH Company_Year (company,years, total_laid_off) AS 
(
  SELECT company, YEAR(`date`) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(`date`) 
)
Select *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
from Company_Year;

WITH Company_Year (company,years, total_laid_off) AS 
(
  SELECT company, YEAR(`date`) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(`date`) 
)
Select *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
from Company_Year
Where years is not null;

WITH Company_Year (company,years, total_laid_off) AS 
(
  SELECT company, YEAR(`date`) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(`date`) 
)
Select *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
from Company_Year
Where years IS NOT NULL
order by ranking ;

WITH Company_Year AS 
(
  SELECT company, YEAR(`date`) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(`date`) 
)
, Company_Year_Rank AS (
  SELECT *, 
  DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
  where years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank;

WITH Company_Year AS 
(
  SELECT company, YEAR(`date`) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(`date`) 
)
, Company_Year_Rank AS (
  SELECT *, 
  DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
  where years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE ranking <= 5;

SELECT * 
FROM layoffs_staging2;





