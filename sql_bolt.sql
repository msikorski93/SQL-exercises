--Solutions to https://sqlbolt.com/ exercises
--Exercise 1 — Tasks

--1. Find the title of each film
--2. Find the director of each film
--3. Find the title and director of each film
--4. Find the title and year of each film
--5. Find all the information about each film

SELECT Title FROM movies;

SELECT Director FROM movies;

SELECT Title, Director FROM movies;

SELECT Title, Year FROM movies;

SELECT * FROM movies;

--Exercise 2 — Tasks

--1. Find the movie with a row id of 6
--2. Find the movies released in the years between 2000 and 2010
--3. Find the movies not released in the years between 2000 and 2010
--4. Find the first 5 Pixar movies and their release year

SELECT * FROM movies
WHERE id = 6;

SELECT * FROM movies
WHERE Year BETWEEN 2000 AND 2010;

SELECT * FROM movies
WHERE Year NOT BETWEEN 2000 AND 2010;

SELECT * FROM movies
ORDER BY Year ASC LIMIT 5;

--Exercise 3 — Tasks

--1. Find all the Toy Story movies
--2. Find all the movies directed by John Lasseter
--3. Find all the movies (and director) not directed by John Lasseter
--4. Find all the WALL-* movies

SELECT * FROM movies
WHERE Title LIKE 'Toy Story%';

SELECT * FROM movies
WHERE Director LIKE 'John Lasseter';

SELECT * FROM movies
WHERE Director NOT LIKE 'John Lasseter';

SELECT * FROM movies
WHERE Title LIKE 'WALL-%';

--Exercise 4 — Tasks

--1. List all directors of Pixar movies (alphabetically), without duplicates
--2. List the last four Pixar movies released (ordered from most recent to least)
--3. List the first five Pixar movies sorted alphabetically
--4. List the next five Pixar movies sorted alphabetically

SELECT DISTINCT Director FROM movies
ORDER BY Director ASC;

SELECT * FROM movies
ORDER BY Year DESC LIMIT 4;

SELECT * FROM movies
ORDER BY Title ASC LIMIT 5;

SELECT * FROM movies
ORDER BY Title ASC LIMIT 5 OFFSET 5;

--Review 1 — Tasks

--1. List all the Canadian cities and their populations
--2. Order all the cities in the United States by their latitude from north to south
--3. List all the cities west of Chicago, ordered from west to east
--4. List the two largest cities in Mexico (by population)
--5. List the third and fourth largest cities (by population) in the United States and their population

SELECT City, Population FROM north_american_cities WHERE Country = 'Canada';

SELECT City FROM north_american_cities
WHERE Country = 'United States'
ORDER BY Latitude DESC;

SELECT City FROM north_american_cities
WHERE Longitude < (SELECT Longitude FROM north_american_cities WHERE City = 'Chicago')
ORDER BY Longitude ASC;

SELECT City FROM north_american_cities
WHERE Country = 'Mexico'
ORDER BY Population DESC LIMIT 2;

SELECT City FROM north_american_cities
WHERE Country = 'United States'
ORDER BY Population DESC LIMIT 2 OFFSET 2;

--Exercise 6 — Tasks

--1. Find the domestic and international sales for each movie
--2. Show the sales numbers for each movie that did better internationally rather than domestically
--3. List all the movies by their ratings in descending order

SELECT Title, Domestic_sales, International_sales FROM Movies
INNER JOIN Boxoffice ON Movies.Id = Boxoffice.Movie_id;

SELECT title, Domestic_sales, International_sales FROM Movies
INNER JOIN Boxoffice ON Movies.Id = Boxoffice.Movie_id
WHERE International_sales > Domestic_sales;

SELECT * FROM Movies
INNER JOIN Boxoffice ON Movies.Id = Boxoffice.Movie_id
ORDER BY Rating DESC;

--Exercise 7 — Tasks

--1. Find the list of all buildings that have employees
--2. Find the list of all buildings and their capacity
--3. List all buildings and the distinct employee roles in each building (including empty buildings)

SELECT DISTINCT Building_name FROM Buildings
INNER JOIN Employees ON Buildings.Building_name = Employees.Building;

SELECT * FROM Buildings;

SELECT DISTINCT Building_name, Role FROM Buildings 
LEFT JOIN Employees ON Buildings.Building_name = Employees.Building;

--Exercise 8 — Tasks

--1. Find the name and role of all employees who have not been assigned to a building
--2. Find the names of the buildings that hold no employees

SELECT Name, Role FROM Employees WHERE Building IS NULL;

SELECT Building_name FROM Buildings
LEFT JOIN Employees ON Buildings.Building_name = Employees.Building
WHERE Building IS NULL;

--Exercise 9 — Tasks

--1. List all movies and their combined sales in millions of dollars
--2. List all movies and their ratings in percent
--3. List all movies that were released on even number years

SELECT Title, (Domestic_sales + International_sales) / 1_000_000 AS Sales_Millions FROM Movies
LEFT JOIN Boxoffice ON Movies.Id = Boxoffice.Movie_id;

SELECT Title, Rating*10 AS Rating_Perc FROM Movies
LEFT JOIN Boxoffice ON Movies.Id = Boxoffice.Movie_id;

SELECT * FROM Movies WHERE Year % 2 = 0;

--Exercise 10 — Tasks

--1. Find the longest time that an employee has been at the studio
--2. For each role, find the average number of years employed by employees in that role
--3. Find the total number of employee years worked in each building

SELECT MAX(Years_employed) FROM employees;

SELECT Role, AVG(years_employed) FROM employees
GROUP BY Role;

SELECT Building, SUM(years_employed) FROM employees
GROUP BY Building;

--Exercise 11 — Tasks

--1. Find the number of Artists in the studio (without a HAVING clause)
--2. Find the number of Employees of each role in the studio
--3. Find the total number of years employed by all Engineers

SELECT COUNT(*) FROM employees
WHERE Role = 'Artist';

SELECT Role, COUNT(*) FROM employees
GROUP BY Role;

SELECT SUM(Years_employed) FROM employees
GROUP BY Role
HAVING Role = 'Engineer';

--Exercise 12 — Tasks

--1. Find the number of movies each director has directed
--2. Find the total domestic and international sales that can be attributed to each director

SELECT COUNT(Director) AS Num, Director FROM Movies
GROUP BY Director;

SELECT DISTINCT Director, (Domestic_sales + International_sales) AS Total_Sales FROM Movies
LEFT JOIN Boxoffice ON Movies.Id = Boxoffice.Movie_id
GROUP BY Director;

--Exercise 13 — Tasks

--1. Add the studio's new production, Toy Story 4 to the list of movies (you can use any director) ✓
--2. Toy Story 4 has been released to critical acclaim! It had a rating of 8.7, and made 340 million domestically and 270 million internationally. Add the record to the BoxOffice table.

INSERT INTO Movies (Id, Title, Director, Year, length_minutes)
VALUES ('4', 'Toy Story 4', 'Janusz Nowak', '2022', '82');

INSERT INTO Boxoffice (Movie_id, Rating, Domestic_sales, International_sales)
VALUES ('4', '8.7', '340_000_000', '370_000_000');

--Exercise 14 — Tasks

--1. The director for A Bug's Life is incorrect, it was actually directed by John Lasseter
--2. The year that Toy Story 2 was released is incorrect, it was actually released in 1999
--3. Both the title and director for Toy Story 8 is incorrect! The title should be "Toy Story 3" and it was directed by Lee Unkrich

UPDATE Movies
SET Director = 'John Lasseter'
WHERE Title="A Bug's Life";

UPDATE Movies
SET Year = '1999'
WHERE Title = 'Toy Story 2';

UPDATE Movies
SET Title = 'Toy Story 3', Director = 'Lee Unkrich'
WHERE Title = 'Toy Story%' AND Year = 2010;

UPDATE Movies
SET Title = 'Toy Story 3', Director = 'Lee Unkrich'
WHERE Title = 'Toy Story 8';

--Exercise 15 — Tasks

--1. This database is getting too big, lets remove all movies that were released before 2005.
--2. Andrew Stanton has also left the studio, so please remove all movies directed by him.

DELETE FROM Movies
WHERE Year < 2005;

DELETE FROM Movies
WHERE Director LIKE 'Andrew Stanton';

--Exercise 16 — Tasks

--1. Create a new table named Database with the following columns:

--– Name A string (text) describing the name of the database
--– Version A number (floating point) of the latest version of this database
--– Download_count An integer count of the number of times this database was downloaded
--This table has no constraints.

CREATE TABLE Database (
    Name TEXT,
    Version FLOAT,
    year INTEGER, 
    Download_count INTEGER
);

--Exercise 17 — Tasks

--1. Add a column named Aspect_ratio with a FLOAT data type to store the aspect-ratio each movie was released in.
--2. Add another column named Language with a TEXT data type to store the language that the movie was released in. Ensure that the default for this language is English.

ALTER TABLE Movies
ADD Aspect_ratio FLOAT;

ALTER TABLE Movies
ADD Language TEXT
DEFAULT 'English';

--Exercise 18 — Tasks

--1. We've sadly reached the end of our lessons, lets clean up by removing the Movies table
--2. And drop the BoxOffice table as well

DROP TABLE IF EXISTS Movies;

DROP TABLE IF EXISTS Boxoffice;