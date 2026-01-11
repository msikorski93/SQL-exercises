--SQL Exercises, Practice, Solution - JOINS
--https://www.w3resource.com/sql-exercises/sql-joins-exercises.php

--1. Sales & City Matching
--From the following tables write a SQL query to find the salesperson and customer who reside in the same city. Return Salesman, cust_name and city.

select name, cust_name, city
from salesman as s
inner join customer as c
on s.salesman_id = c.salesman_id
where s.city = c.city;

--2. Orders in Amount Range
--From the following tables write a SQL query to find those orders where the order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city.

select ord_no, purch_amt, cust_name, city
from orders as o
inner join customer as c
on o.customer_id = c.customer_id
where purch_amt between 500 and 2000;

--3. Salesman-Customer Representation
--From the following tables write a SQL query to find the salesperson(s) and the customer(s) he represents. Return Customer Name, city, Salesman, commission.

select c.cust_name, c.city, s.name, s.commission
from salesman as s
inner join customer as c
on s.salesman_id = c.salesman_id;

--4. High Commission Salespeople
--From the following tables write a SQL query to find salespeople who received commissions of more than 12 percent from the company. Return Customer Name, customer city, Salesman, commission.

select c.cust_name, c.city, s.name, s.commission
from salesman as s
inner join customer as c
on s.salesman_id = c.salesman_id
where s.commission > 0.12;

--5. Different City & High Commission
--From the following tables write a SQL query to locate those salespeople who do not live in the same city where their customers live and have received a commission of more than 12% from the company. Return Customer Name, customer city, Salesman, salesman city, commission.

select c.cust_name, c.city, s.name, s.city, s.commission
from salesman as s
inner join customer as c
on s.salesman_id = c.salesman_id
where c.city != s.city
and s.commission > 0.12;

--6. Order Details Report
--From the following tables write a SQL query to find the details of an order. Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission.

select
o.ord_no,
o.ord_date,
o.purch_amt,
c.cust_name,
c.grade,
s.name,
s.commission
from orders as o
inner join customer as c
on o.customer_id = c.customer_id
inner join salesman as s
on o.salesman_id = s.salesman_id;

--7. Join All Tables Uniquely
--Write a SQL statement to join the tables salesman, customer and orders so that the same column of each table appears once and only the relational rows are returned.

select o.*, c.*, s.*
from orders as o
natural join customer as c
natural join salesman as s;

--8. Customer & Salesman Sorted by Customer_ID
--From the following tables write a SQL query to display the customer name, customer city, grade, salesman, salesman city. The results should be sorted by ascending customer_id.

select
c.cust_name,
c.city,
c.grade,
s.name,
s.city
from customer as c
inner join salesman as s
on c.salesman_id = s.salesman_id
order by c.customer_id;

--9. Customers with Grade Less Than 300
--From the following tables write a SQL query to find those customers with a grade less than 300. Return cust_name, customer city, grade, Salesman, salesmancity. The result should be ordered by ascending customer_id.

select
c.cust_name,
c.city,
c.grade,
s.name,
s.city
from customer as c
left join salesman as s
on c.salesman_id = s.salesman_id
where c.grade < 300
order by c.customer_id;

--10. Customer Order Report by Date
--Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to determine whether any of the existing customers have placed an order or not.

select
c.cust_name,
c.city,
o.ord_no,
o.ord_date,
o.purch_amt
from customer as c
left join orders as o
on c.customer_id = o.customer_id
order by o.ord_date;

--11. Order & Salesperson Report
--SQL statement to generate a report with customer name, city, order number, order date, order amount, salesperson name, and commission to determine if any of the existing customers have not placed orders or if they have placed orders through their salesman or by themselves.

select
c.cust_name,
c.city,
o.ord_no,
o.ord_date,
o.purch_amt,
s.name,
s.commission
from customer as c
left join orders as o
on c.customer_id = o.customer_id
left join salesman as s
on c.salesman_id = s.salesman_id;

--12. Salespersons List (Including Unassigned)
--Write a SQL statement to generate a list in ascending order of salespersons who work either for one or more customers or have not yet joined any of the customers.

select
s.name,
s.city,
s.salesman_id
from salesman as s
right join customer as c
on s.salesman_id = c.salesman_id
order by s.name;

--13. Comprehensive Sales & Order Report
--From the following tables write a SQL query to list all salespersons along with customer name, city, grade, order number, date, and amount. Condition for selecting list of salesmen : 1. Salesmen who works for one or more customer or, 2. Salesmen who not yet join under any customer, Condition for selecting list of customer : 3. placed one or more orders, or 4. no order placed to their salesman.

select
c.cust_name,
c.city,
c.grade,
o.ord_no,
o.ord_date,
o.purch_amt
from customer as c
right join salesman as s
on c.salesman_id = s.salesman_id
right join orders as o
on o.customer_id = c.customer_id;

--14. Salesmen List with Order and Grade Criteria
--Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000 and must have a grade, or he may not have placed any order to the associated supplier.

select
s.name,
c.cust_name,
o.purch_amt,
c.grade
from salesman as s
right join customer as c
on s.salesman_id = c.salesman_id
left join orders as o
on o.customer_id = c.customer_id
where o.purch_amt >= 2000
and c.grade is not null;

--15. Customer Order Placement Report
--For those customers from the existing list who put one or more orders, or which orders have been placed by the customer who is not on the list, create a report containing the customer name, city, order number, order date, and purchase amount.

select
c.cust_name,
c.city,
o.ord_no,
o.ord_date,
o.purch_amt
from customer as c
left join orders as o
on c.customer_id = o.customer_id;

--16. Customer Order & Grade Report
--Write a SQL statement to generate a report with the customer name, city, order no. order date, purchase amount for only those customers on the list who must have a grade and placed one or more orders or which order(s) have been placed by the customer who neither is on the list nor has a grade.

select
c.cust_name,
c.city,
o.ord_no,
o.ord_date,
o.purch_amt
from customer as c
full join orders as o
on c.customer_id = o.customer_id
where c.grade is not null;

--17. Salesman-Customer Full Combination
--Write a SQL query to combine each row of the salesman table with each row of the customer table.

select s.*, c.*
from salesman as s
cross join customer as c;

--18. Cartesian Product with City Flag
--Write a SQL statement to create a Cartesian product between salesperson and customer, i.e. each salesperson will appear for all customers and vice versa for that salesperson who belongs to that city.

select s.*, c.*
from salesman as s
cross join customer as c
where s.city is not null;

--19. Cartesian Product with Valid City & Grade
--Write a SQL statement to create a Cartesian product between salesperson and customer, i.e. each salesperson will appear for every customer and vice versa for those salesmen who belong to a city and customers who require a grade.

select s.*, c.*
from salesman as s
cross join customer as c
where s.city is not null
and c.grade is not null;

--20. Cartesian Product with Non Matching Cities
--Write a SQL statement to make a Cartesian product between salesman and customer i.e. each salesman will appear for all customers and vice versa for those salesmen who must belong to a city which is not the same as his customer and the customers should have their own grade.

select s.*, c.*
from salesman as s
cross join customer as c
where s.city is not null
and s.city != c.city
and c.grade is not null;

--21. Matched Company & Item Join
--From the following tables write a SQL query to select all rows from both participating tables as long as there is a match between pro_com and com_id.

select c.*, i.*
from company_mast as c
inner join item_mast as i
on c.com_id = i.pro_com;

--22. Product & Company Details
--Write a SQL query to display the item name, price, and company name of all the products.

select
i.pro_name,
i.pro_price,
c.com_name
from item_mast as i
left join company_mast as c
on c.com_id = i.pro_com;

--23. Average Price by Company
--From the following tables write a SQL query to calculate the average price of items of each company. Return average value and company name.

select
avg(i.pro_price) as avg_val,
c.com_name
from item_mast as i
inner join company_mast as c
on c.com_id = i.pro_com
group by c.com_name;

--24. Average Price (>=350) by Company
--From the following tables write a SQL query to calculate and find the average price of items of each company higher than or equal to Rs. 350. Return average value and company name.

select
avg(i.pro_price) as avg_val,
c.com_name
from item_mast as i
inner join company_mast as c
on c.com_id = i.pro_com
group by c.com_name
having avg(i.pro_price) >= 350.0;

--25. Most Expensive Product by Company
--From the following tables write a SQL query to find the most expensive product of each company. Return pro_name, pro_price and com_name.

select
i.pro_name,
i.pro_price,
c.com_name
from item_mast as i
inner join company_mast as c
on c.com_id = i.pro_com
where i.pro_price =
(select max(pro_prices)
from item_mast
where pro_com = i.pro_com);

--26. Employee & Department Full Report
--From the following tables write a SQL query to display all the data of employees including their department.

select
det.*,
dep.dpt_name,
dep.dpt_allotment
from emp_details as det
left join emp_department as dep
on det.emp_dept = dep.dpt_code;

--27. Employee Name & Department Sanction
--From the following tables write a SQL query to display the first and last names of each employee, as well as the department name and sanction amount.

select
det.emp_fname,
det.emp_lname,
dep.dpt_name,
dep.dpt_allotment
from emp_details as det
inner join emp_department as dep
on det.emp_dept = dep.dpt_code;

--28. High Budget Departments Employee List
--From the following tables write a SQL query to find the departments with budgets more than Rs. 50000 and display the first name and last name of employees.

select
det.emp_fname,
det.emp_lname
from emp_details as det
inner join emp_department as dep
on det.emp_dept = dep.dpt_code
where dep.dpt_allotment > 50000;

--29. Departments with More Than Two Employees
--From the following tables write a SQL query to find the names of departments where more than two employees are employed. Return dpt_name.

select
dep.dpt_name,
count(*) as emp_count
from emp_department as dep
inner join emp_details as det
on det.emp_dept = dep.dpt_code
group by dep.dpt_name
having count(*) > 2;