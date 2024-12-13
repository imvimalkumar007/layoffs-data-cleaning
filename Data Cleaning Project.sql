SELECT *
FROM
	layoffs
;

-- 1. Remove Duplicates
-- 2. Standardise the Data
-- 3. Null Values or Blank Values 
-- 4. Remove Any Columns 

CREATE TABLE 
	layoffs_staging
LIKE 
	layoffs;

    
INSERT 
	layoffs_staging
SELECT * 
FROM
	layoffs;

SELECT * 
FROM
	layoffs;
    
SELECT *,
ROW_NUMBER() 
OVER (PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM
	layoffs_staging;
    
WITH duplicate_cte AS 
(
SELECT *,
ROW_NUMBER() 
OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised) AS row_num
FROM
	layoffs_staging
)
DELETE 
FROM 
	duplicate_cte
WHERE 
	row_num > 1;
    
SELECT * 
FROM
	layoffs_staging
WHERE 
	company = 'Casper'
ORDER BY 
	`date`;
    
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` text,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised` double DEFAULT NULL, 
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * 
FROM 
	layoffs_staging2
WHERE 
	row_num > 1;
    
INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() 
OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised) AS row_num
FROM
	layoffs_staging;
    
DELETE 
FROM
	layoffs_staging2
WHERE
	row_num > 1;
    
SET SQL_SAFE_UPDATES = 0;

    
SELECT * 
FROM 
	layoffs_staging2
;

-- Standardising Data --

SELECT company, (TRIM(company)) 
FROM 
	layoffs_staging2;
    
UPDATE 
	layoffs_staging2
SET
	company = TRIM(company);
    
SELECT DISTINCT 
	country
FROM
	layoffs_staging2
ORDER BY 1;

SELECT DISTINCT 
	industry
FROM
	layoffs_staging2
ORDER BY 1;

SELECT * 
FROM 
	layoffs_staging2;
    
SELECT DISTINCT 
	location
FROM
	layoffs_staging2
ORDER BY 1;

UPDATE 
	layoffs_staging2
SET 
	industry = 'Crypto'
WHERE 
	industry LIKE 'Crypto%';
    
SELECT DISTINCT 
	country, 
    TRIM(TRAILING '.' FROM country)
FROM
	layoffs_staging2
ORDER BY 1;
    
UPDATE 
	layoffs_staging2
SET 
	country = TRIM(TRAILING '.' FROM country)
WHERE 
	country LIKE 'United States%';
    
SELECT `date`
FROM 
	layoffs_staging2;

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y') 
FROM 
	layoffs_staging2;

-- This was not working for me, when I ran this function, it returned all the NULL VALUES --
-- Here's my troubleshoot --

SELECT DISTINCT `date`
FROM layoffs_staging2;

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y') 
FROM 
	layoffs_staging2;
    
SELECT `date`
FROM 
	layoffs_staging2
WHERE 
	STR_TO_DATE(`date`, '%Y/%m/%d') IS NULL;

ALTER TABLE 
	layoffs_staging2
ADD COLUMN date_converted DATE;

UPDATE 
	layoffs_staging2
SET 
	date_converted = STR_TO_DATE(`date`, '%Y/%m/%d');

UPDATE layoffs_staging2
SET date_converted = CASE
    WHEN `date` REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN STR_TO_DATE(`date`, '%Y-%m-%d')
    WHEN `date` REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN STR_TO_DATE(`date`, '%m/%d/%Y')
    ELSE NULL -- Handle invalid formats gracefully
END;

SELECT `date`
FROM 
	layoffs_staging2
WHERE 
	date_converted IS NULL;

ALTER TABLE 
	layoffs_staging2 
DROP COLUMN 
	`date`;

ALTER TABLE 
	layoffs_staging2 
RENAME COLUMN 
	date_converted TO `date`;

SELECT `date`
FROM 
	layoffs_staging2;
    
-- Handling the NULL values --
    
SELECT *
FROM 
	layoffs_staging2
WHERE 
	total_laid_off IS NULL
    AND percentage_laid_off IS NULL;
    
    
SELECT *
FROM 
	layoffs_staging2
WHERE 
	company = 'Appsmith'
    ;
    
-- Removing columns with no important data --

SELECT *
FROM 
	layoffs_staging2
WHERE 
    total_laid_off = ''
    AND percentage_laid_off = '';
    
DELETE 
FROM 
	layoffs_staging2
WHERE 
    total_laid_off = ''
    AND percentage_laid_off = '';

ALTER TABLE 
	layoffs_staging2
DROP COLUMN 
	row_num;
