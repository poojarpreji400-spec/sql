# normalizing
# data cleaning

select*
from world_layoffs.layoff_staging2
;

select DISTINCT company, (TRIM(company)) # trim - remove leading and trailing spaces from text
from world_layoffs.layoff_staging2
;


UPDATE layoff_staging2
set company = TRIM(company); # then we upadted

select DISTINCT industry # ORDER BY 1 means you are sorting the query results by the very first column listed in your SELECT statement. 
from world_layoffs.layoff_staging2
ORDER BY 1
;


-- select DISTINCT company, industry # ORDER BY 2 means you are sorting the query results by the second column listed in your SELECT statement. 
-- from world_layoffs.layoff_staging2
-- ORDER BY 2
;

select *
from world_layoffs.layoff_staging2
WHERE industry LIKE 'Crypto%' # like - used with text data(partially filter)
;

UPDATE layoff_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%'
;


select DISTINCT industry # ORDER BY 1 means you are sorting the query results by the very first column listed in your SELECT statement. 
from world_layoffs.layoff_staging2
;


select DISTINCT location
from world_layoffs.layoff_staging2
ORDER BY 1
;

select DISTINCT country
from world_layoffs.layoff_staging2
ORDER BY 1
;

select DISTINCT country
from world_layoffs.layoff_staging2
WHERE country LIKE 'United States%'
ORDER BY 1
;

select DISTINCT TRIM(TRAILING '.' FROM country) # specifing we are look for a dot
from world_layoffs.layoff_staging2
WHERE country LIKE 'United States%'
ORDER BY 1
;

UPDATE layoff_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%'
;

select country
from world_layoffs.layoff_staging2
order by 1
;

# change the data type of date column
select `date`,
STR_TO_DATE(`date`, '%m/%d/%Y') # string to date(text - string)
# (date - column, format (month, date, year))
from world_layoffs.layoff_staging2
;

UPDATE layoff_staging2
SET date = STR_TO_DATE(`date`, '%m/%d/%Y')
;


# changing data type
ALTER TABLE layoff_staging2
MODIFY COLUMN `date` DATE;


select *
from world_layoffs.layoff_staging2
;










