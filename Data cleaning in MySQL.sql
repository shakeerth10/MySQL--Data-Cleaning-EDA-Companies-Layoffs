create database project;
use project;

select * from layoffs;
select * from layoff_staging;
select * from layoffs_staging2;

				-- Data Cleaning--

-- 1.Remove duplicates
-- 2.Standardize the data
-- 3.Null or blank values
-- 4.Remove any columns

					-- 1.Remove duplicates-- 

select * from layoffs;

create table layoff_staging
like layoffs;

insert layoff_staging
select * from layoffs;

select * from layoff_staging;

SELECT company, industry, total_laid_off,`date`,
ROW_NUMBER() OVER (PARTITION BY company, industry, total_laid_off,`date`) AS row_num
FROM 
layoff_staging;

SELECT *,
	ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
		) AS row_num
FROM 
layoff_staging;


with duplicate_cte as (
SELECT *,
	ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
		) AS row_num
FROM 
layoff_staging )
select * 
from duplicate_cte
where row_num>1;

select * 
from layoff_staging
where company='Casper';

CREATE TABLE layoffs_staging2 (
`company` text,
`location`text,
`industry`text,
`total_laid_off` INT,
`percentage_laid_off` text,
`date` text,
`stage`text,
`country` text,
`funds_raised_millions` int,
row_num INT
);
    
INSERT INTO layoffs_staging2
(`company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
`row_num`)
SELECT `company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM layoff_staging;
    
select * 
from layoffs_staging2;

select * 
from layoffs_staging2
where row_num>1;    
    
delete 
from layoffs_staging2
where row_num>1;
    
select * 
from layoffs_staging2
where row_num=1;      
    
    
						-- 2.Standardize the data-- 

select * 
from layoffs_staging2;

select distinct(company)
from layoffs_staging2;

select distinct(trim(company))
from layoffs_staging2;

select company,trim(company)
from layoffs_staging2;
                        
update layoffs_staging2
set company=trim(company);
  
select company,trim(company)
from layoffs_staging2;  

select distinct(industry)
from layoffs_staging2;
                        
select *
from layoffs_staging2
where industry like 'Crypto%' ;

update layoffs_staging2
set industry='Crypto'
where industry like 'Crypto%';                      
 
      -- Check
select *
from layoffs_staging2
where industry ='crypto currency';

select distinct(industry)
from layoffs_staging2;
                        
select distinct(location)
from layoffs_staging2;
                        
select distinct(country)
from layoffs_staging2;  

select *
from layoffs_staging2
where country like 'United states%' ;

select distinct country,trim(country)
from layoffs_staging2; 

select distinct country,trim(trailing '.' from country)
from layoffs_staging2; 

update layoffs_staging2
set country=trim(trailing '.' from country)
where country like 'United state%';

select distinct country,trim(trailing '.' from country)
from layoffs_staging2;

Select distinct(stage)
from layoffs_staging2;

select *
from layoffs_staging2;

select `date`,
str_to_date(`date`,'%m/%d/%y')
from layoffs_staging2;

select `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoffs_staging2;

Update layoffs_staging2
set `date`= str_to_date(`date`,'%m/%d/%Y');

select `date`
from layoffs_staging2;

Alter table layoffs_staging2
modify column `date` date;

select *
from layoffs_staging2;


						-- 3.Null or blank values-- 
                        
select *
from layoffs_staging2;

Select * 
from layoffs_staging2
where total_laid_off = null;

Select * 
from layoffs_staging2
where total_laid_off is null;

Select * 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

update layoffs_staging2
set industry=null
where industry=''; 

select distinct(industry)
from layoffs_staging2;

Select * 
from layoffs_staging2
where industry is null
or industry ='';

Select * 
from layoffs_staging2
where company='Airbnb';

Select * 
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company=t2.company
where (t1.industry is null or t1.industry='')
and t2.industry is not null;

Select t1.industry,t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company=t2.company
where (t1.industry is null or t1.industry='')
and t2.industry is not null;

update layoffs_staging2 t1 
join layoffs_staging2 t2
	on t1.company=t2.company
set t1.industry=t2.industry
where t1.industry is null 
and t2.industry is not null;

Select * 
from layoffs_staging2
where company='Airbnb';

Select * 
from layoffs_staging2
where industry is null
or industry ='';

Select * 
from layoffs_staging2
where company like 'bally%';

Select * 
from layoffs_staging2;

				-- 4.Remove any columns-- 

Select * 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

Delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

Select * 
from layoffs_staging2;

Alter table layoffs_staging2
drop column row_num; 

Select * 
from layoffs_staging2;
                        
                        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    




