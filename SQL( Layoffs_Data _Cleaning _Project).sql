-- =============================================
-- LAYOFFS DATA CLEANING PROJECT
-- Purpose: Clean and prepare layoffs data for analysis
-- =============================================


# STEP 1: Create a staging table to preserve raw data
# (Original data remains untouched in 'layoffs' table)
create table layoffs_staging
like layoffs;

# Verify empty staging table structure
select*
from layoffs_staging;

# Copy all data from original table to staging
insert into layoffs_staging
select *
from layoffs;


-- =============================================
-- PHASE 1: DUPLICATE REMOVAL
-- ============================================

# Identify duplicate rows using ROW_NUMBER()
# Partition by all columns to find exact duplicates
select * , 
row_number()over(
partition by company,location,industry,total_laid_off,
percentage_laid_off,`date`,stage,country,funds_raised_millions) 
from layoffs_staging;

# Create CTE to isolate duplicates
with dublicate_cte as  
(
select * , 
row_number()over(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage
,country,funds_raised_millions) as row_num
from layoffs_staging
)

# Show only duplicate rows (row_num > 1)
select*
from dublicate_cte
where row_num > 1;

# Create new table to handle deduplication
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

# Insert data with row numbers for deduplication
insert into layoffs_staging_1
select * , 
row_number()over(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage
,country,funds_raised_millions) as row_num
from layoffs_staging;

# Show only duplicate rows (row_num > 1)
select *
from layoffs_staging_1
where row_num > 1;

# Delete duplicate rows (row_num > 1)
delete
from layoffs_staging_1
where row_num > 1;

# Verify deletion
select *
from layoffs_staging2
where row_num > 1;


-- =============================================
-- PHASE 2: DATA STANDARDIZATION
-- =============================================

# Trim whitespace from company names
select company, (trim(company))   
From layoffs_staging_1;

update layoffs_staging_1  
set company = trim(company);

# Standardize industry names (e.g., merge all crypto variations -in the next queries-)
Select distinct industry
from layoffs_staging_1
order by 1; 

Select*
from layoffs_staging_1
where industry like 'crypto%';

Update layoffs_staging_1
set industry = 'Crypto'
where industry like 'crypto%';

# Clean country names (remove trailing periods -in the next queries-)
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


-- =============================================
-- PHASE 3: DATE FORMATTING
-- =============================================

# Convert text dates to proper DATE format
select `date`,
str_to_date(`date`, '%m/%d/%Y/')
from layoffs_staging_1;

Update layoffs_staging_1
set `date` = str_to_date(`date`, '%m/%d/%Y/');

select `date`
from layoffs_staging_1;

# Alter table to change data type for date column
alter table layoffs_staging_1
modify column `date` date;


-- =============================================
-- PHASE 4: NULL VALUE HANDLING
-- =============================================

# Identify NULL values in key columns
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

# Change blank values to NULL values (to be able to Populate)
update layoffs_staging_1
set industry = null
where industry = '';

# Fill NULL industry values using self-join
# (Use known industry values from same company)
update layoffs_staging_1 t1
join layoffs_staging_1 as t2
	on t1.company= t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null ;

# Verify evrey NULL populated
select *
from layoffs_staging_1
where industry is null
or industry = '';

select *
from layoffs_staging_1
where total_laid_off is null 
and percentage_laid_off is null ;

# Remove records with NULL values in both columns
delete
from layoffs_staging_1
where total_laid_off is null 
and percentage_laid_off is null;

# Final cleanup: Remove row_num column
alter table layoffs_staging_1
drop column row_num;

# check table overall
select*
from layoffs_staging_1;