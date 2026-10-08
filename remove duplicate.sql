# data cleaning


select*
from world_layoffs.layoffs;

-- Remove Duplicates--
-- Standarization--
-- Null values or blank values--
-- Remove any columns--
DROP TABLE IF EXISTS layoff_staging;

CREATE TABLE layoff_staging
LIKE layoffs; # creating a duplicte of row data

# USE layoff_staging;

INSERT layoff_staging
select*
from world_layoffs.layoffs;

select*
from world_layoffs.layoff_staging;

# duplicates
select*,
ROW_NUMBER() OVER(
    PARTITION BY company, location, industry, total_laid_off,percentage_laid_off, date, stage, country, funds_raised_millions) as row_num
from world_layoffs.layoff_staging;


# cte
WITH duplicate_cte AS
(   SELECT*,
    ROW_NUMBER() OVER(
    PARTITION BY company,location, industry, total_laid_off,percentage_laid_off, date, stage, country, funds_raised_millions) as row_num
    from world_layoffs.layoff_staging

)
select*
FROM duplicate_cte
where row_num>1
;

select*
from world_layoffs.layoffs
where company = 'casper';

# again creating a copy table before delting dupliactets

DROP TABLE IF EXISTS layoff_staging2;
CREATE TABLE layoff_staging2
LIKE layoff_staging ;
-- like is used to copy the exact structure (columns, data types, and indexes) of an existing table without copying its data.

ALTER TABLE layoff_staging2 # ALTER lets you change a table that already exists.
ADD row_num INT;

INSERT INTO layoff_staging2 # we are inserting also checking the row_num once again
select*,
ROW_NUMBER() OVER(PARTITION BY
                company,        
                location,
                industry,
               total_laid_off,
               percentage_laid_off,
               `date`,
               stage,
               country,
               funds_raised_millions) as row_num
from layoff_staging;

select*
from layoff_staging2
WHERE row_num>1
;

# deleting the duplicates
DELETE FROM layoff_staging2
WHERE row_num>1
;

select*
from layoff_staging2
WHERE row_num>1









