--                     AGGREGATION ASSIGNMENT CODE



use world;

SELECT * FROM world.city;

-- Question 1 : Count how many cities are there in each country?
SELECT CountryCode, COUNT(Name) AS City_Count
FROM city
GROUP BY CountryCode ;

SELECT * FROM world.country;

-- Question 2 : Display all continents having more than 30 countries.

SELECT Continent, COUNT(*)
FROM world.country
GROUP BY Continent
HAVING COUNT(*) > 30 ;

-- Question 3 : List regions whose total population exceeds 200 million.
SELECT Region, SUM(Population) AS total_population
FROM world.country
GROUP BY Region
HAVING SUM(Population) > 200000000;

-- Question 4 : Find the top 5 continents by average GNP per country.

SELECT Continent, AVG(GNP) AS avg_gnp
FROM country
GROUP BY Continent
ORDER BY AVG(GNP) DESC
LIMIT 5;


-- Question 5 : Find the total number of official languages spoken in each continent.
SELECT Continent, COUNT(Language) AS total_languages
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T'
GROUP BY Continent ;


-- Question 6 : Find the maximum and minimum GNP for each continent.
SELECT Continent, MAX(GNP) AS max_GNP, MIN(GNP) AS min_GNP
FROM country
GROUP BY Continent;


-- Question 7 : Find the country with the highest average city population.
SELECT co.Name, AVG(ci.Population) AS AVG_Population
FROM city ci
JOIN country co
ON ci.CountryCode = co.Code
GROUP BY co.Name
ORDER BY AVG(ci.Population) DESC
LIMIT 1;


-- Question 8 : List continents where the average city population is greater than 200,000.
SELECT co.Continent, AVG(ci.Population)
FROM city ci
JOIN country co
ON ci.CountryCode = co.Code
GROUP BY co.Continent
HAVING  AVG(ci.Population) > 200000;


-- Question 9 : Find the total population and average life expectancy for each continent, ordered by average life
-- expectancy descending.
SELECT Continent, SUM(Population), AVG(LifeExpectancy)
FROM country
GROUP BY Continent
ORDER BY AVG(LifeExpectancy) DESC;



-- Question 10 : Find the top 3 continents with the highest average life expectancy, but only include those where
-- the total population is over 200 million.
SELECT Continent, SUM(Population), AVG(LifeExpectancy)
FROM country
GROUP BY Continent
HAVING SUM(Population) > 200000000
ORDER BY AVG(LifeExpectancy) DESC
LIMIT 3;


