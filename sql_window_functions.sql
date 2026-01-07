--Solutions to https://www.windowfunctions.com/ exercises
--Intro questions

/*
1. We would like to find the total weight of cats grouped by age. But only return those groups with a total weight larger than 12.
Return: age, sum(weight) Order by: age
*/

SELECT
age,
SUM(weight) AS total_weight
FROM cats
GROUP BY age
HAVING SUM(weight) > 12
ORDER BY age;


--Over questions

/*
1. The cats must be ordered by name and will enter an elevator one by one. We would like to know what the running total weight is.
Return: name, running total weight
Order by: name
*/

SELECT
name,
SUM(weight) OVER (ORDER BY name) AS total_weight
FROM cats;

/*
2. The cats must be ordered first by breed and second by name. They are about to enter an elevator one by one. When all the cats of the same breed have entered they leave.

We would like to know what the running total weight of the cats is.
Return: name, breed, running total weight
Order by: breed, name 
*/

SELECT
name,
breed,
SUM(weight) OVER (PARTITION BY breed ORDER BY name) AS total_weight
FROM cats;

/*
3. The cats would like to see the average of the weight of them, the cat just after them and the cat just before them.

The first and last cats are content to have an average weight of consisting of 2 cats not 3.
Return: name, weight, average_weight
Order by: weight
*/

SELECT
name,
weight,
AVG(weight) OVER (ORDER BY weight ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS avg_weight
FROM cats;

/*
4. The cats must be ordered by weight descending and will enter an elevator one by one. We would like to know what the running total weight is.

If two cats have the same weight they must enter separately
Return: name, running total weight
Order by: weight desc
*/

SELECT
name,
SUM(weight) OVER (ORDER BY weight DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS total_weight
FROM cats
ORDER BY total_weight;


--Ranking questions

/*
1. The cats form a line grouped by color. Inside each color group the cats order themselves by name. Every cat must have a unique number for its place in the line.

We must assign each cat a unique number while maintaining their color & name ordering.
Return: unique_number, name, color
*/

SELECT
ROW_NUMBER() OVER(ORDER BY color, name) AS unique_num,
name,
color
FROM cats;

/*
2. We would like to find the fattest cat. Order all our cats by weight.

The two heaviest cats should both be 1st. The next heaviest should be 3rd.
Return: ranking, weight, name
Order by: ranking, name
*/

SELECT
RANK() OVER (ORDER BY weight DESC, name) AS ranking,
weight,
name
FROM cats
ORDER BY ranking, name;

/*
3. For cats age means seniority, we would like to rank the cats by age (oldest first).

However we would like their ranking to be sequentially increasing.
Return: ranking, name, age
Order by: ranking, name
*/

SELECT
DENSE_RANK() OVER (ORDER BY age DESC) AS ranking,
name,
age
FROM cats
ORDER BY ranking, name;

/*
4. Each cat would like to know what percentage of other cats weigh less than it
Return: name, weight, percent
Order by: weight
*/

SELECT
name,
weight,
PERCENT_RANK() OVER (ORDER BY weight)*100 AS percent
FROM cats;

/*
5. Each cat would like to know what weight percentile it is in. This requires casting to an integer
Return: name, weight, percent
Order by: weight
*/

SELECT
name,
weight,
CAST(CUME_DIST() OVER (ORDER BY weight)*100 AS INTEGER) AS percent
FROM cats;


--Grouping questions

/*
1. We are worried our cats are too fat and need to diet.

We would like to group the cats into quartiles by their weight.
Return: name, weight, weight_quartile
Order by: weight
*/

SELECT
name,
weight,
NTILE(4) OVER (ORDER BY weight) AS quartile
FROM cats;

/*
2. Cats are fickle. Each cat would like to lose weight to be the equivalent weight of the cat weighing just less than it.

Print a list of cats, their weights and the weight difference between them and the nearest lighter cat ordered by weight.
Return: name, weight, weight_to_lose
Order by: weight
*/

SELECT
name,
weight,
weight - LAG(weight, 1) OVER (ORDER BY weight) AS diff
FROM cats;

/*
3. The cats now want to lose weight according to their breed. Each cat would like to lose weight to be the equivalent weight of the cat in the same breed weighing just less than it.

Print a list of cats, their breeds, weights and the weight difference between them and the nearest lighter cat of the same breed.
Return: name, breed, weight, weight_to_lose
Order by: weight
*/

SELECT
name,
breed,
weight,
COALESCE(weight - LAG(weight, 1) OVER (PARTITION BY breed ORDER BY weight), 0.0) AS diff
FROM cats
ORDER BY weight, name;

/*
4. Cats are vain. Each cat would like to pretend it has the lowest weight for its color.

Print cat name, color and the minimum weight of cats with that color.
Return: name, color, lowest_weight_by_color
Order by: color, name
*/

SELECT
name,
color,
MIN(weight) OVER (PARTITION BY color ORDER BY weight) AS weight_col
FROM cats
ORDER BY color, name;

/*
5. Each cat would like to see the next heaviest cat's weight when grouped by breed. If there is no heavier cat print 'fattest cat'

Print a list of cats, their weights and either the next heaviest cat's weight or 'fattest cat'
Return: name, weight, breed, next_heaviest
Order by: weight
*/

SELECT
name,
weight,
breed,
COALESCE(CAST(LEAD(weight, 1) OVER (PARTITION BY breed ORDER BY weight) as VARCHAR), 'fattest cat') AS next_heaviest
FROM cats
ORDER BY weight;

/*
6. The cats have decided the correct weight is the same as the 4th lightest cat. All cats shall have this weight. Except in a fit of jealous rage they decide to set the weight of the lightest three to 99.9

Print a list of cats, their weights and their imagined weight
Return: name, weight, imagined_weight
Order by: weight
*/

SELECT
name,
weight,
COALESCE(NTH_VALUE(weight, 4) OVER (ORDER BY weight), 99.9) AS imagined_weight
FROM cats;

/*
7. The cats want to show their weight by breed. The cats agree that they should show the second lightest cat's weight (so as not to make other cats feel bad)

Print a list of breeds, and the second lightest weight of that breed
Return: breed, imagined_weight
Order by: breed
*/

SELECT
DISTINCT breed,
NTH_VALUE(weight, 2) OVER (PARTITION BY breed ORDER BY weight RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS imagined_weight
FROM cats
ORDER BY breed;


--Other questions

/*
1. This SQL function can be made simpler by using the WINDOW statement. Please try and use the WINDOW clause.

Each cat would like to see what half, third and quartile they are in for their weight.
Return: name, weight, by_half, thirds, quartile
Order by: weight
*/

SELECT
name,
weight,
NTILE(2) OVER NTILE_WINDOW AS by_half,
NTILE(3) OVER NTILE_WINDOW AS thirds,
NTILE(4) OVER NTILE_WINDOW AS quart
FROM cats window NTILE_WINDOW AS (ORDER BY weight)
ORDER BY weight, name;

/*
2. We would like to group our cats by color

Return 3 rows, each row containing a color and a list of cat names
Return: color, names Order by: color DESC
*/

SELECT
color,
ARRAY_AGG(name) AS names
FROM cats
GROUP BY color
ORDER BY color DESC;

/*
3. We would like to find the average weight of cats grouped by breed. Also, in the same query find the average weight of cats grouped by breed whose age is over 1
Return: breed, average_weight, average_old_weight Order by: breed
*/

SELECT
breed,
AVG(weight) AS avg_weight,
AVG(weight) FILTER (WHERE age > 1) AS avg_old_weight
FROM cats
GROUP BY breed
ORDER BY breed;