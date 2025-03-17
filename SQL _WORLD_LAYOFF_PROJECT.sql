alter table `layoffs (1)` rename to layoffs;  

select * from layoffs; 

-- 1 remove dup 
--   2.std data 
-- 3.null or blank value 
-- 4. remove column and row  
-- other data   

create table layoffs_stagging 
like layoffs; 

select * from layoffs_stagging;

INSERT layoffs_stagging 
select * 
from layoffs;   


select * from layoffs_stagging;  



WITH duplicate_cte as 
( 
select *,
row_number() over(
partition by company,location,
industry,total_laid_off,percentage_laid_off,`date`,
stage,country,funds_raised_millions) as row_num
from layoffs_stagging 
) 
delete from duplicate_cte
where row_num >1;




CREATE TABLE `layoffs_stagging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `Row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



insert into layoffs_stagging2
select *,
row_number() over(
partition by company,location,
industry,total_laid_off,percentage_laid_off,`date`,
stage,country,funds_raised_millions) as row_num
from layoffs_stagging; 

select * from layoffs_stagging2;  

delete 
from layoffs_stagging2 
where row_num >1;  

-- standardizing data 

select company,trim(company)
from layoffs_stagging2;  

UPDATE layoffs_stagging2 
set company = trim(company);


-- actual industry   

select distinct industry 
from layoffs_stagging2;
;


update layoffs_stagging2 
set industry = 'Crypto' 
where industry like '';

select * 
from layoffs_stagging2 
where industry like 'Crypto%';

select  distinct country  
from layoffs_stagging2 
where country like 'United States' 
order by 1;



select distinct country 
from layoffs_stagging2 
order by 1;  

select * from layoffs_stagging2;  


select distinct country,trim(TRAILING '-' FROM country)
from layoffs_stagging2 
order by 1;  


UPDATE layoffs_stagging2
SET country = trim(TRAILING '-' FROM country) 
where country LIKE 'United States%';

# how to do maonths date year 

 SELECT `date`, 
str_to_date(`date`,'%m/%d/%y')
 FROM layoffs_stagging2;   
 
SELECT `date` 
FROM layoffs_stagging2;
 
 
UPDATE layoffs_stagging2  
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');
 
 ALTER TABLE layoffs_stagging2
 MODIFY COLUMN `DATE` DATE;  
 
 
 SELECT * 
 FROM layoffs_stagging2 
 where total_laid_off is null 
 and percentage_laid_off is null;
 
 
 select distinct industry 
 from layoffs_stagging2 
 where industry is null 
or industry = '';
 
 
 
 select * 
 from layoffs_stagging2 
 where company = 'Airbnb';  
 
 
 -- join used 
 
 select * 
 from layoffs_stagging2 t1 
 join layoffs_stagging2 t2 
	on t1.company = t2.company 
where (t1.industry is NULL or t1.industry = '')
AND t2.industry is not null;   



UPDATE layoffs_stagging2 t1  
JOIN  layoffs_stagging2 t2  
   ON  t1.company = t2.company 
SET t1.industry = t2.industry 
where t1.industry is NULL
AND t2.industry is not null;   


update layoffs_stagging2 
set industry = null 
where industry = '';
select * from  layoffs_stagging2;  


 SELECT * 
 FROM layoffs_stagging2 
 where total_laid_off is null 
 and percentage_laid_off is null;  
 
 
 delete 
FROM layoffs_stagging2 
where total_laid_off is null 
and percentage_laid_off is null;  

-- Explotary data analysis 

 select * 
 from layoffs_stagging2;

select max(total_laid_off),max(percentage_laid_off) 
from layoffs_stagging2;

select * 
 from layoffs_stagging2 
 where percentage_laid_off = 1 
 order by funds_raised_millions desc;   
 
 select company,sum(total_laid_off) 
 from layoffs_stagging2 
 group by company 
 order by 2 desc;

# min 

select min(`date`),max(`date`) 
from layoffs_stagging2;


 select industry,sum(total_laid_off) 
 from layoffs_stagging2 
 group by industry 
 order by 2 desc;  
 
 select country,sum(total_laid_off) 
 from layoffs_stagging2 
 group by country 
 order by 2 desc;  
 
 select * from layoffs_stagging2;
 
 
 
 select `date`,sum(total_laid_off) 
 from layoffs_stagging2 
 group by `date`
 order by 1 desc;  
 
  select year( `date`),sum(total_laid_off) 
 from layoffs_stagging2 
 group by year(`date`)
 order by 1 desc;  
 
 
 select stage ,sum(total_laid_off) 
 from layoffs_stagging2 
 group by stage
 order by 2 desc;   
 
 
 # percetnage 

select company,avg(percentage_laid_off) 
 from layoffs_stagging2 
 group by company
 order by 2 desc;  
 
 
 SELECT 
    SUBSTRING(`date`, 1, 7) AS `MONTH`, 
    SUM(total_laid_off) 
FROM 
    layoffs_stagging2   
WHERE 
    SUBSTRING(`date`, 1, 7) IS NOT NULL  
GROUP BY 
    `MONTH`
ORDER BY 
     1 ASC;  
    
    
    
WITH ROLLING_Total AS (
    SELECT 
        SUBSTRING(`date`, 1, 7) AS `MONTH`, 
        SUM(total_laid_off) AS total_off
    FROM 
        layoffs_stagging2   
    WHERE 
        SUBSTRING(`date`, 1, 7) IS NOT NULL  
    GROUP BY 
        SUBSTRING(`date`, 1, 7)
    ORDER BY 
        `MONTH` ASC
)
SELECT 
    `MONTH`, total_off,
    SUM(total_off) OVER (ORDER BY `MONTH`) AS rolling_total
FROM 
    ROLLING_Total;

    
    
    
WITH ROLLING_Total AS (
    SELECT 
        SUBSTRING(`date`, 1, 7) AS `MONTH`, 
        SUM(total_laid_off) AS total_off
    FROM 
        layoffs_stagging2   
    WHERE 
        SUBSTRING(`date`, 1, 7) IS NOT NULL  
    GROUP BY 
        SUBSTRING(`date`, 1, 7)
    ORDER BY 
        `MONTH` ASC
)
SELECT 
    `MONTH`, total_off,
    SUM(total_off) OVER (ORDER BY `MONTH`) AS rolling_total
FROM 
    ROLLING_Total; 
    
    
SELECT company, YEAR(`date`) AS year, SUM(total_laid_off) AS total_laid_off
FROM layoffs_stagging2
GROUP BY company, YEAR(`date`)
ORDER BY company ASC;

 
 SELECT company, YEAR(`date`) AS year, SUM(total_laid_off) AS total_laid_off
FROM layoffs_stagging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;
 
 
 # RABNK WISE DATA ANALYSIS 
 
 
 with Company_Year (company,years,total_laid_off) as 
 (
 SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY company, YEAR(`date`)
) 
select *,dense_rank() over (partition by years order by total_laid_off desc) as Ranking 
from Company_Year
where years is not null  
order by Ranking asc;




WITH Company_Year AS (
    SELECT company, YEAR(`date`) AS years, SUM(total_laid_off) AS total_laid_off
    FROM layoffs_stagging2
    GROUP BY company, YEAR(`date`)
), 
Company_Year_Rank AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
    FROM Company_Year
    WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5
ORDER BY years, Ranking;






