# data cleaning
# DROP DATABASE IF EXISTS world_layoffs;

# CREATE DATABASE world_layoffs;

USE world_layoffs;

DROP TABLE IF EXISTS layoffs;

CREATE TABLE layoffs (
    company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off INT,
    percentage_laid_off TEXT,
    `date` TEXT,
    stage TEXT,
    country TEXT,
    funds_raised_millions INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/layoffs.csv'
INTO TABLE layoffs
FIELDS TERMINATED BY ',' # Each column is separated by a comma.
ENCLOSED BY '"' # The values - "Google","California","Technology","100"
LINES TERMINATED BY '\r\n' # Each row in your Windows CSV ends with a Windows line break.
# \r\n = Windows newline.
IGNORE 1 ROWS # Skip the first row., because that the header
( # Here is the order of the columns coming from the CSV
    company,
    location,
    industry,
    total_laid_off,
    percentage_laid_off,
    `date`,
    stage,
    country,
    @funds_raised_millions # we temporarily put it into a user variable:
)
SET funds_raised_millions =
    NULLIF(TRIM(@funds_raised_millions), 'NULL'); # clean
    # trim unnecessary spaces, slashes, then converting csv null to sql null


SHOW VARIABLES LIKE 'secure_file_priv';

SELECT COUNT(*) FROM layoffs;

