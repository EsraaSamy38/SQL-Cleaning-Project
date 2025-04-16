select* 
from layoffs;

create table layoffs_staging
like layoffs;

select*
from layoffs_staging;

insert into layoffs_staging
select *
from layoffs;


select * , 
row_number()over(
partition by company,location,industry,total_laid_off,
percentage_laid_off,`date`,stage,country,funds_raised_millions) 
from layoffs_staging;

with dublicate_cte as  
(
select * , 
row_number()over(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage
,country,funds_raised_millions) as row_num
from layoffs_staging
)
select*
from dublicate_cte
where row_num > 1;

CREATE TABLE `layoffs_staging_1` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL, `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select*
from layoffs_staging_1;

insert into layoffs_staging_1
select * , 
row_number()over(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage
,country,funds_raised_millions) as row_num
from layoffs_staging;

select *
from layoffs_staging_1
where row_num > 1;

delete
from layoffs_staging_1
where row_num > 1;

select *
from layoffs_staging2
where row_num > 1;


select company, (trim(company))   
From layoffs_staging_1;

update layoffs_staging_1  
set company = trim(company);

Select distinct industry
from layoffs_staging_1
order by 1; 

Select*
from layoffs_staging_1
where industry like 'crypto%';

Update layoffs_staging_1
set industry = 'crypto'
where industry like 'crypto%';

Select distinct industry 
from layoffs_staging_1;

Select distinct country
from layoffs_staging_1
order by 1; 

Select distinct country
from layoffs_staging_1
where country like 'United States%';

Select distinct country , trim( trailing '.' from country)
From layoffs_staging_1
Order by 1;

Update layoffs_staging_1
Set country = trim( trailing '.' from country)
Where country like 'United States%';

Select distinct country
from layoffs_staging_1
order by 1;


select `date`,
str_to_date(`date`, '%m/%d/%Y/')
from layoffs_staging_1;

Update layoffs_staging_1
set `date` = str_to_date(`date`, '%m/%d/%Y/');

select `date`
from layoffs_staging_1;

alter table layoffs_staging_1
modify column `date` date;


select *
from layoffs_staging_1
where total_laid_off is null 
or total_laid_off = '';

select *
from layoffs_staging_1
where industry is null
or industry = '';

select *
from layoffs_staging_1
where company= 'Airbnb';

select t1.industry,t2.industry
from layoffs_staging_1 as t1
join layoffs_staging_1 as t2
	on t1.company= t2.company
where t1.industry is null 
and t2.industry is not null ;

update layoffs_staging_1
set industry = null
where industry = '';

update layoffs_staging_1 t1
join layoffs_staging_1 as t2
	on t1.company= t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null ;

select *
from layoffs_staging_1
where industry is null
or industry = '';

select *
from layoffs_staging_1
where company like 'Ball%';


select *
from layoffs_staging_1
where total_laid_off is null 
and total_laid_off is null ;

delete
from layoffs_staging_1
where total_laid_off is null 
and total_laid_off is null;

select*
from layoffs_staging_1;

alter table layoffs_staging_1
drop column row_num;







