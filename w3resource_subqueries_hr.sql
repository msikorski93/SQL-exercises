--SQL Exercises, Practice, Solution - SUBQUERIES
--https://www.w3resource.com/sql-exercises/sql-subqueries-exercises.php

--1. From the following table, write a SQL query to find those employees who receive a higher salary than the employee with ID 163. Return first name, last name.

select
first_name,
last_name
from employees
where salary >
(select salary
from employees
where employee_id = 163);

--2. From the following table, write a SQL query to find out which employees have the same designation as the employee whose ID is 169. Return first name, last name, department ID and job ID.

select
first_name,
last_name,
department_id,
job_id
from employees
where job_id =
(select job_id
from employees
where employee_id = 169);

--3. From the following table, write a SQL query to find those employees whose salary matches the lowest salary of any of the departments. Return first name, last name and department ID.

select
first_name,
last_name,
department_id,
from employees
where salary in
(select min(salary)
from employees
group by department_id);

--4. From the following table, write a SQL query to find those employees who earn more than the average salary. Return employee ID, first name, last name.

select
employee_id,
first_name,
last_name
from employees
where salary >
(select avg(salary)
from employees);

--5. From the following table, write a SQL query to find those employees who report to that manager whose first name is ‘Payam’. Return first name, last name, employee ID and salary.

select
first_name,
last_name,
employee_id,
salary
from employees
where manager_id =
(select employee_id
from employees
where first_name = 'Payam');

--6. From the following tables, write a SQL query to find all those employees who work in the Finance department. Return department ID, name (first), job ID and department name.

select
e.department_id,
e.first_name,
e.job_id,
d.department_name
from employees as e
left join departments as d
on e.department_id = d.department_id
where d.department_name = 'Finance';

--7. From the following table, write a SQL query to find the employee whose salary is 3000 and reporting person’s ID is 121. Return all fields.

select *
from employees
where manager_id =
(select employee_id
from employees
where employee_id = 121)
and salary = 3000.0;

--or

select *
from employees
where manager_id = 121 and salary = 3000.0;

--8. From the following table, write a SQL query to find those employees whose ID matches any of the numbers 134, 159 and 183. Return all the fields.

select *
from employees
where employee_id in (134, 159, 183);

--9. From the following table, write a SQL query to find those employees whose salary is in the range of 1000, and 3000 (Begin and end values have included.). Return all the fields.

select *
from employees
where salary >= 1000.0 and salary <= 3000.0;

--10. From the following table and write a SQL query to find those employees whose salary falls within the range of the smallest salary and 2500. Return all the fields.

select *
from employees
where salary >=
(select min(salary) from employees)
and salary <= 2500.0;

--11. From the following tables, write a SQL query to find those employees who do not work in the departments where managers’ IDs are between 100 and 200 (Begin and end values are included.). Return all the fields of the employees.

select *
from employees
where department_id not in
(select department_id from departments between 100 and 200);

--12. From the following table, write a SQL query to find those employees who get second-highest salary. Return all the fields of the employees.

select *
from employees
where salary =
(select salary
from employees
order by salary desc
limit 1 offset 1);

--13. From the following tables, write a SQL query to find those employees who work in the same department as ‘Clara’. Exclude all those records where first name is ‘Clara’. Return first name, last name and hire date.

select
first_name,
last_name,
hire_date
from employees
where department_id =
(select department_id
from employees
where first_name = 'Clara')
and first_name != 'Clara';

--14. From the following tables, write a SQL query to find those employees who work in a department where the employee’s first name contains the letter 'T'. Return employee ID, first name and last name.

select
employee_id,
first_name,
last_name
from employees
where department_id in
(select department_id
from employees
where first_name like 'T%');

--15. From the following tables, write a SQL query to find those employees who earn more than the average salary and work in the same department as an employee whose first name contains the letter 'J'. Return employee ID, first name and salary.

select
employee_id,
first_name,
salary
from employees
where salary >
(select avg(salary) from employees)
and department_id in
(select department_id
from employees
where first_name like '%j%');

--16. From the following table, write a SQL query to find those employees whose department is located at ‘Toronto’. Return first name, last name, employee ID, job ID.

select
first_name,
last_name,
employee_id,
job_id
from employees
where department_id in
(select department_id
from departments as d
inner join locations as l
on d.location_id = l.location_id
where l.city = 'Toronto');

--17. From the following table, write a SQL query to find those employees whose salary is lower than that of employees whose job title is ‘MK_MAN’. Return employee ID, first name, last name, job ID.

select
employee_id,
first_name,
last_name,
job_id
from employees
where salary < any
(select salary
from employees 
where job_id = 'MK_MAN');

--18. From the following table, write a SQL query to find those employees whose salary is lower than that of employees whose job title is "MK_MAN". Exclude employees of Job title ‘MK_MAN’. Return employee ID, first name, last name, job ID.

select
employee_id,
first_name,
last_name,
job_id
from employees
where salary < any
(select salary
from employees 
where job_id = 'MK_MAN')
and job_id != 'MK_MAN';

--19. From the following table, write a SQL query to find those employees whose salary exceeds the salary of all those employees whose job title is "PU_MAN". Exclude job title ‘PU_MAN’. Return employee ID, first name, last name, job ID.

select
employee_id,
first_name,
last_name,
job_id
from employees
where salary > any
(select salary
from employees 
where job_id = 'PU_MAN')
and job_id != 'PU_MAN';

--20. From the following table, write a SQL query to find those employees whose salaries are higher than the average for all departments. Return employee ID, first name, last name, job ID.

select
employee_id,
first_name,
last_name,
job_id
from employees
where salary >
(select avg(salary)
from employees
group by department_id);

--21.  From the following table, write a SQL query to check whether there are any employees with salaries exceeding 3700. Return first name, last name and department ID.

select
first_name,
last_name,
department_id
from employees
where exists
(select *
from employees
where salary> 3700.0);

--22. From the following table, write a SQL query to calculate total salary of the departments where at least one employee works. Return department ID, total salary.

select
department_id,
sum(salary) as total_sum
from
(select *
from employees as e
left join departments as d
on e.department_id = d.department_id)
group by department_id;

--or

select
department_id,
sum(salary) as total_sum
from employees
group by department_id;

--23. Write a query to display the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.

select
employee_id,
first_name,
last_name,
case job_id
when 'ST_MAN' then 'salesman'
when 'IT_PROG' then 'developer'
else job_id
end as job_title
from employees;

--24. Write a query to display the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.

select
employee_id,
first_name,
last_name,
salary,
case salary
when salary < (select avg(salary) from employees) then 'low'
else 'high'
end as salary_status
from employees;

--25. Write a query to display the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees) and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.

select
employee_id,
first_name,
last_name,
salary as salary_drawn,
salary - (select avg(salary) from employees) as avg_compare,
case salary
when salary < (select avg(salary) from employees) then 'low'
else 'high'
end as salary_status
from employees;

--26. From the following table, write a SQL query to find all those departments where at least one employee is employed. Return department name.

select distinct d.department_name
from employees as e
inner join departments as d
on e.department_id = d.department_id;

--27. From the following tables, write a SQL query to find employees who work in departments located in the United Kingdom. Return first name.

select first_name
from employees
where department_id in
(select d.department_id
from departments as d
inner join locations as l
on d.location_id = l.location_id
inner join countries as c
on l.country_id = c.country_id
where c.country_name = 'United Kingdom');

--28. From the following table, write a SQL query to find out which employees are earning more than the average salary and who work in any of the IT departments. Return last name.

select last_name
from employees
where salary > (select avg(salary) from employees)
and department_id in
(select department_id
from departments
where department_name = 'IT');

--29. From the following table, write a SQL query to find all those employees who earn more than an employee whose last name is 'Ozer'. Sort the result in ascending order by last name. Return first name, last name and salary.

select
first_name,
last_name,
salary
from employees
where salary >
(select salary from employees where last_name = 'Ozer')
order by last_name;

--30. From the following tables, write a SQL query find the employees who report to a manager based in the United States. Return first name, last name.

select
e.first_name,
e.last_name
from employees as e
inner join employees as m
on e.manager_id = m.employee_id
inner join departments as d
on m.department_id = d.department_id
inner join locations as l
on d.location_id = l.location_id
where l.country_id = 'US';

--or

select
first_name,
last_name
from employees
where manager_id in
(select m.employee_id
from employees as m
inner join departments as d
on m.department_id = d.department_id
inner join locations as l
on d.location_id = l.location_id
where l.country_id = 'US');

--31. From the following tables, write a SQL query to find those employees whose salaries exceed 50% of their department's total salary bill. Return first name, last name.

select
e.first_name,
e.last_name
from employees as e
where salary >

(select sum(salary) * 0.5
from employees as m
inner join departments as d
on e.department_id = m.department_id
);

--32. From the following tables, write a SQL query to find those employees who are managers. Return all the fields of employees table.

select *
from employees
where employee_id in
(select disitnct manager_id from employees);

--33. From the following table, write a SQL query to find those employees who manage a department. Return all the fields of employees table.

select *
from employees
where manager_id = any
(select disitnct manager_id from departments);

--34. From the following table, write a SQL query to search for employees who receive such a salary, which is the maximum salary for salaried employees, hired between January 1st, 2002 and December 31st, 2003. Return employee ID, first name, last name, salary, department name and city.

select
e.employee_id,
e.first_name,
e.last_name,
e.salary,
e.department_id,
l.city
from employees as e
inner join departments as d
on e.department_id = d.department_id
inner join locations as l
on d.location_id = l.location_id
where e.salary =
(select max(e.salary)
from employees
and e.hire_date between '2002-01-01' and '2003-12-31');

--or

select
e.employee_id,
e.first_name,
e.last_name,
e.salary,
e.department_id,
l.city
from employees as e, departments as d, locations as l
where e.salary =
(select max(e.salary)
from employees
and e.hire_date between '2002-01-01' and '2003-12-31')
and e.department_id = d.department_id
and d.location_id = l.location_id;

--35. From the following tables, write a SQL query to find those departments that are located in the city of London. Return department ID, department name.

select
d.department_id,
d.department_name
from departments as d, locations as l
where l.city = 'London'
and d.location_id = l.location_id;

--or

select
d.department_id,
d.department_name
from departments as d
inner join locations as l
on d.location_id = l.location_id
where l.city = 'London';

--or

select
department_id,
department_name
from departments
where location_id =
(select location_id
from locations
where city = 'London');

--36. From the following table, write a SQL query to find those employees who earn more than the average salary. Sort the result-set in descending order by salary. Return first name, last name, salary, and department ID.

select
first_name,
last_name,
salary,
department_id
from employees
where salary > (select avg(salary) from employees)
order by salary desc;

--37. From the following table, write a SQL query to find those employees who earn more than the maximum salary for a department of ID 40. Return first name, last name and department ID.

select
first_name,
last_name,
department_id
from employees
where salary >
(select max(salary)
from employees
where department_id = 40);

--38. From the following table, write a SQL query to find departments for a particular location. The location matches the location of the department of ID 30. Return department name and department ID.

select
department_name,
department_id
from departments
where location_id =
(select location_id
from departments
where department_id = 30);

--39. From the following table, write a SQL query to find employees who work for the department in which employee ID 201 is employed. Return first name, last name, salary, and department ID.

select
first_name,
last_name,
salary,
department_id
from employees
where department_id =
(select department_id
from employees
where employee_id = 201);

--40. From the following table, write a SQL query to find those employees whose salary matches that of the employee who works in department ID 40. Return first name, last name, salary, and department ID.

select
first_name,
last_name,
salary,
department_id
from employees
where salary in
(select salary
from employees
where department_id = 40);

--41. From the following table, write a SQL query to find those employees who work in the department 'Marketing'. Return first name, last name and department ID.

select
first_name,
last_name,
department_id
from employees
where department_id =
(select department_id
from departments
where department_name = 'Marketing');

--42. From the following table, write a SQL query to find those employees who earn more than the minimum salary of a department of ID 40. Return first name, last name, salary, and department ID.

select
first_name,
last_name,
salary,
department_id
from employees
where salary > any
(select max(salary)
from employees
where department_id = 40);

--43. From the following table, write a SQL query to find those employees who joined after the employee whose ID is 165. Return first name, last name and hire date.

select
first_name,
last_name,
hire_date
from employees
where hire_date >
(select hire_date
from employees
where employee_id = 165);

--44. From the following table, write a SQL query to find those employees who earn less than the minimum salary of a department of ID 70. Return first name, last name, salary, and department ID.

select
first_name,
last_name,
salary,
department_id
from employees
where salary <
(select min(salary)
from employees
where department_id = 70);

--45. From the following table, write a SQL query to find those employees who earn less than the average salary and work at the department where Laura (first name) is employed. Return first name, last name, salary, and department ID.

select
first_name,
last_name,
salary,
department_id
from employees
where salary < (select avg(salary) from employees)
and department_id =
(select department_id
from employees
where first_name = 'Laura');

--46. From the following tables, write a SQL query to find all employees whose department is located in London. Return first name, last name, salary, and department ID.

select
e.first_name,
e.last_name,
e.salary,
e.department_id
from employees as e
where department_id in
(select d.department_id
from departments as d
where d.location_id =
(select l.location_id
from locations as l
where l.city = 'London'));

--or

select
e.first_name,
e.last_name,
e.salary,
e.department_id
from employees as e
inner join departments as d
on e.department_id = d.department_id
inner join locations as l
on d.location_id = l.location_id
where l.city = 'London';

--47. From the following tables, write a SQL query to find the city of the employee of ID 134. Return city.

select city
from locations as l
where l.location_id =
(select d.location_id
from departments as d
where d.department_id =
(select e.department_id
from employees as e
where e.employee_id = 134));

--or

select city
from locations as l
inner join departments as d
on l.location_id = d.location_id
inner join employees as e
on e.department_id = d.department_id
where e.employee_id = 134;

--48. From the following tables, write a SQL query to find those departments where maximum salary is 7000 and above. The employees worked in those departments have already completed one or more jobs. Return all the fields of the departments.

select *
from d.departments as d
where d.department_id in
(select e.department_id
from employees as e
where e.employee_id in

(select j.employee_id
from job_history as j
group by j.employee_id
having count(j.employee_id) >= 1)

group by e.department_id
having max(e.salary) >= 7000.0);

--or

select distinct d.*
from d.departments as d
inner join employees as e
on d.department_id = e.department_id
inner join job_history as j
on e.employee_id = j.employee_id
group by d.department_id
having max(e.salary) >= 7000.0;

--49. From the following tables, write a SQL query to find those departments where the starting salary is at least 8000. Return all the fields of departments.

select d.*
from d.departments as d
inner join employees as e
on d.department_id = e.department_id
where e.department_id in
(select e.department_id
from employees
group by e.department_id
having min(e.salary) >= 8000.0);

--or

select d.*
from d.departments as d
inner join employees as e
on d.department_id = e.department_id
group by d.department_id
having min(e.salary) >= 8000.0;

--50. From the following table, write a SQL query to find those managers who supervise four or more employees. Return manager name, department ID.

select
first_name,
last_name
from employees
where employee_id in
(select manager_id
from employees
group by manager_id
having count(*) >= 4);

--51. From the following table, write a SQL query to find employees who have previously worked as 'Sales Representatives'. Return all the fields of jobs.

select j.*
from jobs as j
where j.job_id in
(select e.job_id
from employees as e
where e.employee_id in
(select k.employee_id
from job_history as k
where k.job_id = 'SA_REP'));

--52. From the following table, write a SQL query to find those employees who earn the second-lowest salary of all the employees. Return all the fields of employees.

select *
from employees
where salary =
(select salary
from employees
order by 1
limit 1 offset 1);

--or

select *
from
(select *,
dense_rank() over (order by salary) as rnk
from employees)
where rnk = 2;

--or

select m.*
from employees as m
where 2 =
(select count(distinct e.salary)
from employees as e
where e.salary <= m.salary);

--53. From the following table, write a SQL query to find the departments managed by Susan. Return all the fields of departments.

select *
from departments
where manager_id in
(select employee_id
from employees
where first_name = 'Susan');

--54. From the following table, write a SQL query to find those employees who earn the highest salary in a department. Return department ID, employee name, and salary.

select
department_id,
first_name,
salary
from
(select *,
rank() over (partition by department_id order by salary desc) as rnk
from employees)
where rnk = 1;

--55. From the following table, write a SQL query to find those employees who have not had a job in the past. Return all the fields of employees.

select *
from employees
where employee_id not in
(select employee_id
from job_history);