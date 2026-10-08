
# EDA

# exploratory data analysis

select*
from world_layoffs.layoff_staging2
;


SELECT max(total_laid_off), max(percentage_laid_off)
from world_layoffs.layoff_staging2
;

select*
from world_layoffs.layoff_staging2
WHERE percentage_laid_off = 1
;

select*
from world_layoffs.layoff_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC
;

select*
from world_layoffs.layoff_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC
;


select company, sum(total_laid_off)
from world_layoffs.layoff_staging2
GROUP BY company
ORDER BY 2 DESC
;


SELECT min(`date`), max(`date`)
from world_layoffs.layoff_staging2
;


select industry, sum(total_laid_off)
from world_layoffs.layoff_staging2
GROUP BY industry
ORDER BY 2 DESC
;


select country,sum(total_laid_off)
from world_layoffs.layoff_staging2
GROUP BY country
ORDER BY 2 DESC
;


select YEAR(`date`),sum(total_laid_off)
from world_layoffs.layoff_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC
;


select stage,sum(total_laid_off)
from world_layoffs.layoff_staging2
GROUP BY stage
ORDER BY 2 DESC
;


select company ,avg(percentage_laid_off)
from world_layoffs.layoff_staging2
GROUP BY company
ORDER BY 2 DESC
;



SELECT SUBSTRING(`date`, 1, 7) as month, sum(total_laid_off)
from world_layoffs.layoff_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP by  `month`
ORDER BY 1 ASC
;



with rolling_total AS
(SELECT SUBSTRING(`date`, 1, 7) as month, sum(total_laid_off) as total_off
from world_layoffs.layoff_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP by  `month`
ORDER BY 1 ASC)
SELECT `month`, total_off, sum(total_off) OVER(ORDER BY `month`) as rolling_total
from rolling_total
;



select company, YEAR(`date`), sum(total_laid_off)
from world_layoffs.layoff_staging2
GROUP BY company, YEAR(`date`)
ORDER BY company
;

select company, YEAR(`date`), sum(total_laid_off)
from world_layoffs.layoff_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC
;



WITH company_year(company, years, total_laid_off) AS
(select company, YEAR(`date`), sum(total_laid_off)
from world_layoffs.layoff_staging2
GROUP BY company, YEAR(`date`))
select*
from company_year
;



# biggest layoff of each company and their year
WITH company_year(company, years, total_laid_off) AS
(select company, YEAR(`date`), sum(total_laid_off)
from world_layoffs.layoff_staging2
GROUP BY company, YEAR(`date`))
select *, DENSE_RANK() OVER (Partition by years ORDER BY total_laid_off DESC) as ranking
from company_year
;



WITH company_year(company, years, total_laid_off) AS
(select company, YEAR(`date`), sum(total_laid_off)
from world_layoffs.layoff_staging2
GROUP BY company, YEAR(`date`))
select *, DENSE_RANK() OVER (Partition by years ORDER BY total_laid_off DESC) as ranking
from company_year
where years is NOT null
ORDER BY ranking ASC
;



WITH company_year(company, years, total_laid_off) AS
(select company, YEAR(`date`), sum(total_laid_off)
from world_layoffs.layoff_staging2
GROUP BY company, YEAR(`date`)), # first cte
company_year_rank as
(select *, DENSE_RANK() OVER (Partition by years ORDER BY total_laid_off DESC) as ranking
from company_year
where years is NOT null) 
select*
from company_year_rank
WHERE ranking <=5
;


