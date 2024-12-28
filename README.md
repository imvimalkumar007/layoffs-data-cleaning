# layoffs_data_analysis

An SQL project for cleaning and standardising layoff data.

# Layoffs Data Cleaning Project

## Overview
This project demonstrates my ability to clean and standardize data using SQL. The dataset contains information about layoffs across industries, including company names, industries, and layoff statistics. Using SQL, I cleaned and prepared the data for analysis by removing duplicates, handling missing values, standardizing formats, and restructuring the dataset.

## Project Highlights
- Removed duplicate records using SQL's `ROW_NUMBER()` function.
- Standardized inconsistent text and date formats.
- Handled missing values by replacing blanks or removing uninformative rows.
- Finalized the dataset, making it analysis-ready.

## Files Included
- `data cleaning project.sql`: The complete SQL script for cleaning the dataset.
- `layoffs.csv`: The raw dataset before cleaning (sourced from KAGGLE).

## Steps in the Process
1. **Removing Duplicates**: Identified and removed duplicate rows using `ROW_NUMBER()`.
2. **Handling Missing Values**: Replaced blank values with `NULL` and deleted rows with no useful information.
3. **Standardizing Text**: Trimmed extra spaces and standardized column values (e.g., industries).
4. **Date Conversion**: Converted inconsistent date formats into a standard `DATE` type.

## Key SQL Skills Demonstrated
- `ROW_NUMBER()` for duplicate handling.
- `CASE` statements for conditional cleaning.
- `TRIM` and `REGEXP` for text and format standardization.
- `ALTER TABLE` to restructure columns.

## How to Use This Project
1. Clone this repository to your computer.
2. Import the raw dataset (`layoffs_raw.csv`) into a database.
3. Run the SQL script (`layoffs_cleaning.sql`) step by step to clean the data.

## Future Steps
- Visualize trends in layoffs by industry or location using Tableau or Power BI.
- Perform further exploratory data analysis to uncover insights.
