--Solutions to https://www.sql-ex.ru/

--Database schema here:
--https://www.sql-ex.com/help/select13.php#db_1

--Exercise: 1 (Serge I: 2002-09-30)
--Find the model number, speed and hard drive capacity for all the PCs with prices below $500.
--Result set: model, speed, hd.

SELECT model, speed, hd FROM pc
WHERE price < 500;


--Exercise: 2 (Serge I: 2002-09-21)
--List all printer makers. Result set: maker.

SELECT DISTINCT maker FROM product
WHERE type = 'printer'
ORDER BY maker asc;


--Exercise: 3 (Serge I: 2002-09-30)
--Find the model number, RAM and screen size of the laptops with prices over $1000.

SELECT model, ram, screen FROM laptop
WHERE price > 1000;


--Exercise: 4 (Serge I: 2002-09-21)
--Find all records FROM the Printer table containing data about color printers.

SELECT * FROM printer
WHERE type = 'y';


--Exercise: 5 (Serge I: 2002-09-30)
--Find the model number, speed and hard drive capacity of PCs cheaper than $600 having a 12x or a 24x CD drive.

SELECT model, speed, hd FROM pc
WHERE price < 600 AND cd IN ('12x', '24x');

--or

SELECT model, speed, hd FROM pc
WHERE price < 600 AND (cd = '12x' OR cd = '24x');


--Exercise: 6 (Serge I: 2002-10-28)
--For each maker producing laptops with a hard drive capacity of 10 Gb or higher, find the speed of such laptops.
--Result set: maker, speed.

SELECT DISTINCT maker, speed FROM product AS p, laptop AS l
WHERE p.model = l.model AND hd >= 10;


--Exercise: 7 (Serge I: 2002-11-02)
--Get the models and prices for all commercially available products (of any type) produced by maker B.

SELECT product.model, price FROM product, laptop
WHERE product.model = laptop.model AND maker = 'B'
UNION
SELECT product.model, price FROM product, pc
WHERE product.model = pc.model AND maker = 'B'
UNION
SELECT product.model, price FROM product, printer
WHERE product.model = printer.model AND maker = 'B';


--Exercise: 8 (Serge I: 2003-02-03)
--Find the makers producing PCs but not laptops. 

SELECT maker FROM product WHERE type = 'pc'
EXCEPT
SELECT maker FROM product WHERE type = 'laptop';


--Exercise: 9 (Serge I: 2002-11-02)
--Find the makers of PCs with a processor speed of 450 MHz or more. Result set: maker.

SELECT DISTINCT maker FROM product AS pr, pc
WHERE pr.model = pc.model AND speed >= 450;


--Exercise: 10 (Serge I: 2002-09-23)
--Find the printer models having the highest price. Result set: model, price.

SELECT DISTINCT model, price FROM printer
WHERE price = (SELECT MAX(price) FROM printer);


--Exercise: 11 (Serge I: 2002-11-02)
--Find out the average speed of PCs.

SELECT AVG(speed) FROM pc;


--Exercise: 12 (Serge I: 2002-11-02)
--Find out the average speed of the laptops priced over $1000.

SELECT AVG(speed) FROM laptop
WHERE price > 1000;


--Exercise: 13 (Serge I: 2002-11-02)
--Find out the average speed of the PCs produced by maker A.

SELECT AVG(speed) FROM pc, product AS pr
WHERE maker = 'A' AND pc.model = pr.model;


--Exercise: 14 (Serge I: 2002-11-05)
--For the ships in the Ships table that have at least 10 guns, get the class, name, and country.

SELECT ships.class, name, country FROM ships, classes
WHERE numGuns >= 10 AND ships.class = classes.class;


--Exercise: 15 (Serge I: 2003-02-03)
--Get hard drive capacities that are identical for two or more PCs.
--Result set: hd. 

SELECT DISTINCT hd FROM pc
GROUP BY hd
HAVING COUNT(hd) >= 2;


--Exercise: 16 (Serge I: 2003-02-03)
--Get pairs of PC models with identical speeds and the same RAM capacity. Each resulting pair should be displayed only once, i.e. (i, j) but not (j, i).
--Result set: model with the bigger number, model with the smaller number, speed, and RAM.

SELECT DISTINCT t1.model, t2.model, t1.speed, t1.ram
FROM pc AS t1, pc AS t2
WHERE t1.model > t2.model
AND t1.speed = t2.speed
AND t1.ram = t2.ram;


--Exercise: 17 (Serge I: 2003-02-03)
--Get the laptop models that have a speed smaller than the speed of any PC.
--Result set: type, model, speed.

SELECT DISTINCT p.type, l.model, l.speed
FROM product AS p, laptop AS l
WHERE p.model = l.model AND p.type = 'Laptop' AND l.speed < (SELECT MIN(speed) FROM pc);


--Exercise: 18 (Serge I: 2003-02-03)
--Find the makers of the cheapest color printers.
--Result set: maker, price.

SELECT DISTINCT product.maker, printer.price
FROM product, printer
WHERE product.model = printer.model AND printer.color = 'y' AND printer.price = (SELECT MIN(price) FROM printer WHERE color = 'y');


--Exercise: 19 (Serge I: 2003-02-13)
--For each maker having models in the Laptop table, find out the average screen size of the laptops he produces.
--Result set: maker, average screen size.

SELECT maker, AVG(screen)
FROM laptop AS l, product AS p
WHERE l.model = p.model
GROUP BY maker;


--Exercise: 20 (Serge I: 2003-02-13)
--Find the makers producing at least three distinct models of PCs.
--Result set: maker, number of PC models.

SELECT maker, COUNT(DISTINCT model)
FROM product
WHERE type = 'pc'
GROUP BY maker
HAVING COUNT(*) >= 3;


--Exercise: 21 (Serge I: 2003-02-13)
--Find out the maximum PC price for each maker having models in the PC table. Result set: maker, maximum price.

SELECT DISTINCT maker, MAX(price)
FROM pc, product
WHERE pc.model = product.model
GROUP BY maker;


--Exercise: 22 (Serge I: 2003-02-13)
--For each value of PC speed that exceeds 600 MHz, find out the average price of PCs with identical speeds.
--Result set: speed, average price.

SELECT speed, AVG(price) FROM pc
WHERE speed > 600
GROUP BY speed;


--Exercise: 23 (Serge I: 2003-02-14)
--Get the makers producing both PCs having a speed of 750 MHz or higher and laptops with a speed of 750 MHz or higher.
--Result set: maker.

SELECT maker FROM product AS pr, pc
WHERE speed >= 750 AND pr.model = pc.model
INTERSECT
SELECT maker FROM product AS pr, laptop
WHERE speed >= 750 AND pr.model = laptop.model;


--Exercise: 24 (Serge I: 2003-02-03)
--List the models of any type having the highest price of all products present in the database.

WITH table_1 AS
(
SELECT DISTINCT model, price FROM pc
UNION
SELECT DISTINCT model, price FROM laptop
UNION
SELECT DISTINCT model, price FROM printer
)
SELECT model FROM table_1
WHERE price = (SELECT MAX(price) FROM table_1);


--Exercise: 25 (Serge I: 2003-02-14)
--Find the printer makers also producing PCs with the lowest RAM capacity and the highest processor speed of all PCs having the lowest RAM capacity.
--Result set: maker. 

SELECT DISTINCT maker FROM product
WHERE type = 'printer'
AND maker IN (SELECT maker FROM product JOIN
(
SELECT model, speed, ram FROM pc
WHERE speed = (
SELECT MAX(speed) FROM pc
WHERE ram = (
SELECT MIN(ram) FROM pc)
) 
AND ram = (SELECT MIN(ram) FROM pc)
) AS table_2
ON product.model = table_2.model);


--Exercise: 26 (Serge I: 2003-02-14)
--Find out the average price of PCs and laptops produced by maker A.
--Result set: one overall average price for all items.

WITH table_1 AS
(
SELECT laptop.model, price
FROM laptop
JOIN product ON laptop.model = product.model
WHERE maker = 'A'
UNION ALL
SELECT pc.model, price
FROM pc
JOIN product ON pc.model = product.model
WHERE maker = 'A'
)
SELECT AVG(price) FROM table_1;


--Exercise: 27 (Serge I: 2003-02-03)
--Find out the average hard disk drive capacity of PCs produced by makers who also manufacture printers.
--Result set: maker, average HDD capacity.

SELECT maker, AVG(hd) FROM pc
JOIN product ON pc.model = product.model
WHERE maker IN (SELECT DISTINCT maker FROM product WHERE type LIKE 'Printer')
GROUP BY maker;


--Exercise: 28 (Serge I: 2012-05-04)
--Using Product table, find out the number of makers who produce only one model.

SELECT COUNT(*)
FROM
(SELECT maker
FROM product
GROUP BY maker
HAVING COUNT(model) = 1) AS result;


--Exercise: 29 (Serge I: 2003-02-14)
--Under the assumption that receipts of money (inc) and payouts (out) are registered not more than once a day for each collection point [i.e. the primary key consists of (point, date)], write a query displaying cash flow data (point, date, income, expense).
--Use Income_o and Outcome_o tables.

SELECT i.point, i.date, i.inc, o.out
FROM income_o AS i
LEFT JOIN outcome_o AS o ON i.point = o.point AND i.date = o.date
UNION
SELECT o.point, o.date, i.inc, o.out
FROM outcome_o AS o
LEFT JOIN income_o AS i ON o.point = i.point AND o.date = i.date;


--Exercise: 30 (Serge I: 2003-02-14)
--Under the assumption that receipts of money (inc) and payouts (out) can be registered any number of times a day for each collection point [i.e. the code column is the primary key], display a table with one corresponding row for each operating date of each collection point.
--Result set: point, date, total payout per day (out), total money intake per day (inc).
--Missing values are considered to be NULL.

SELECT DISTINCT point, date, sum(out) AS out, sum(inc) AS inc FROM
(
SELECT income.point, income.date, out, inc
FROM income
LEFT JOIN outcome ON income.point = outcome.point AND
income.date = outcome.date AND income.code= outcome.code
UNION ALL
SELECT outcome.point, outcome.date, out, inc
FROM outcome 
LEFT JOIN income ON income.point = outcome.point AND
income.date = outcome.date AND income.code = outcome.code) AS table_1
GROUP BY point, date;


--Exercise: 31 (Serge I: 2002-10-22)
--For ship classes with a gun caliber of 16 in. or more, display the class and the country.

SELECT class, country FROM classes
WHERE bore >= 16;


--Exercise: 32 (Serge I: 2003-02-17)
--One of the characteristics of a ship is one-half the cube of the calibre of its main guns (mw).
--Determine the average ship mw with an accuracy of two decimal places for each country having ships in the database.

SELECT country, CONVERT(NUMERIC(10, 2), AVG(POWER(bore, 3)/2)) AS weight
FROM (SELECT country, bore, name
FROM classes AS c, ships AS s
WHERE s.class = c.class
UNION
SELECT country, bore, ship
FROM classes AS c, outcomes AS o
WHERE o.ship = c.class
AND o.ship NOT IN (SELECT DISTINCT name FROM ships)) AS table_1
GROUP BY country;


--Exercise: 33 (Serge I: 2002-11-02)
--Get the ships sunk in the North Atlantic battle.
--Result set: ship.

SELECT ship FROM outcomes
WHERE battle LIKE '%North Atlantic%' AND result = 'sunk';


--Exercise: 34 (Serge I: 2002-11-04)
--In accordance with the Washington Naval Treaty concluded in the beginning of 1922, it was prohibited to build battle ships with a displacement of more than 35 thousand tons.
--Get the ships violating this treaty (only consider ships for which the year of launch is known).
--List the names of the ships.

SELECT name
FROM ships AS s
JOIN classes AS c ON s.class = c.class
WHERE displacement > 35000 AND launched >= 1922 AND type = 'bb';


--Exercise: 35 (qwrqwr: 2012-11-23)
--Find models in the Product table consisting either of digits only or Latin letters (A-Z, case insensitive) only.
--Result set: model, type.

SELECT model, type FROM product
WHERE model NOT LIKE '%[^A-Z]%' OR model NOT LIKE '%[^0-9]%'


--Exercise: 36 (Serge I: 2003-02-17)
--List the names of lead ships in the database (including the Outcomes table).

SELECT name FROM ships
WHERE name IN (SELECT class FROM classes)
UNION
SELECT ship FROM outcomes
WHERE ship IN (SELECT class FROM classes);


--Exercise: 37 (Serge I: 2003-02-17)
--Find classes for which only one ship exists in the database (including the Outcomes table).

SELECT c.class
FROM
(SELECT s.class, s.name
FROM ships AS s
UNION
SELECT o.ship AS 'class', o.ship
FROM outcomes AS o
WHERE NOT EXISTS (SELECT * FROM ships AS s WHERE s.name = o.ship)) AS s
INNER JOIN classes AS c ON c.class = s.class
GROUP BY c.class
HAVING COUNT(*) = 1;


--Exercise: 38 (Serge I: 2003-02-19)
--Find countries that ever had classes of both battleships (‘bb’) AND cruisers (‘bc’).

SELECT country FROM classes WHERE type = 'bb'
INTERSECT
SELECT country FROM classes WHERE type = 'bc';


--Exercise: 39 (Serge I: 2003-02-14)
--Find the ships that `survived for future battles`; that is, after being damaged in a battle, they participated in another one, which occurred later.

SELECT DISTINCT o.ship
FROM outcomes AS o
LEFT JOIN battles AS b ON b.name = o.battle
WHERE o.result = 'damaged'
AND EXISTS(SELECT * FROM outcomes AS out
LEFT JOIN battles AS bat ON bat.name = out.battle
WHERE out.ship = o.ship
AND bat.date > b.date);


--Exercise: 40 (Serge I: 2012-04-20)
--Get the makers who produce only one product type and more than one model. Output: maker, type.

SELECT DISTINCT maker, type FROM product
WHERE maker IN
(SELECT maker FROM product
GROUP BY maker
HAVING COUNT(DISTINCT type) = 1 AND COUNT(model) > 1);