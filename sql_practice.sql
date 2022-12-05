--Solutions to https://www.sql-practice.com/

--1. Show first name, last name, and gender of patients who's gender is 'M'

SELECT first_name, last_name, gender FROM patients
WHERE gender LIKE 'M';


--2. Show first name and last name of patients who does not have allergies. (null)

SELECT first_name, last_name FROM patients
WHERE allergies IS NULL;

--3. Show first name of patients that start with the letter 'C'

SELECT first_name FROM patients
WHERE first_name LIKE 'C%';

--4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)

SELECT first_name, last_name FROM patients
WHERE weight BETWEEN 100 AND 120;

--5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'

UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;

--6. Show first name and last name concatinated into one column to show their full name.

SELECT CONCAT(first_name, ' ', last_name) FROM patients;

--7. Show first name, last name, and the full province name of each patient. Example: 'Ontario' instead of 'ON'

SELECT first_name, last_name, province_name FROM patients
LEFT JOIN province_names ON patients.province_id = province_names.province_id;

--8. Show how many patients have a birth_date with 2010 as the birth year.

SELECT COUNT(*) FROM patients
WHERE YEAR(birth_date) = 2010;

--9. Show the first_name, last_name, and height of the patient with the greatest height.

SELECT first_name, last_name, height FROM patients
WHERE height = (SELECT MAX(height) FROM patients);

--10. Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000

SELECT * FROM patients
WHERE patient_id IN (1, 45, 534, 879, 1000);

--11. Show the total number of admissions

SELECT COUNT(*) FROM admissions;

--12. Show all the columns from admissions where the patient was admitted and discharged on the same day.

SELECT * FROM admissions
WHERE admission_date = discharge_date;

--13. Show the total number of admissions for patient_id 579.

SELECT patient_id, COUNT(*) FROM admissions
WHERE patient_id = 579;

--14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?

SELECT DISTINCT city FROM patients
WHERE province_id LIKE 'NS';

--15. Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70

SELECT first_name, last_name, birth_date FROM patients
WHERE height > 160 AND weight > 70;

--16. Write a query to find list of patients first_name, last_name, and allergies from Hamilton where allergies are not null

SELECT first_name, last_name, allergies FROM patients
WHERE city = 'Hamilton' AND allergies IS NOT NULL;

--17. Based on cities where our patient lives in, write a query to display the list of unique city starting with a vowel (a, e, i, o, u). Show the result order in ascending by city.

SELECT DISTINCT(city) FROM patients
WHERE city LIKE 'A%'
OR city LIKE 'E%'
OR city LIKE 'I%'
OR city LIKE 'O%'
OR city LIKE 'U%'
ORDER BY city ASC;

--18. Show unique birth years from patients and order them by ascending.

SELECT DISTINCT YEAR(birth_date) AS year FROM patients
ORDER BY year ASC;

--19. Show unique first names from the patients table which only occurs once in the list.

--For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.

SELECT DISTINCT first_name FROM patients
GROUP BY first_name
HAVING COUNT(*) = 1;

--20. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.

SELECT patient_id, first_name FROM patients
WHERE first_name LIKE 'S%s' AND LEN(first_name) >= 6;

--21. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.

--Primary diagnosis is stored in the admissions table.

SELECT p.patient_id, first_name, last_name FROM patients AS p
LEFT JOIN admissions AS a ON p.patient_id = a.patient_id
WHERE diagnosis = 'Dementia';

--22. Display every patient's first_name. Order the list by the length of each name and then by alphbetically

SELECT first_name FROM patients
ORDER BY LEN(first_name), first_name ASC;

--23. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.

SELECT
COUNT(CASE WHEN gender = 'M' THEN 1 END) as male,
COUNT(CASE WHEN gender = 'F' THEN 1 END) as female,
FROM patients;

--24. Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.

SELECT first_name, last_name, allergies FROM patients
WHERE allergies IN ('Penicillin', 'Morphine')
ORDER BY allergies, first_name, last_name;

--25. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

SELECT patient_id, diagnosis FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;

--26. Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.

SELECT DISTINCT city, COUNT(patient_id) FROM patients
GROUP BY city
ORDER BY COUNT(patient_id) DESC, city ASC;

--27. Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"

SELECT first_name, last_name, 'Patient' AS role from patients
UNION ALL
SELECT first_name, last_name, 'Doctor' AS role from doctors;

--28. Show all allergies ordered by popularity. Remove NULL values from query.

SELECT allergies, COUNT(allergies) FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY COUNT(allergies) DESC;

--29. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.

SELECT first_name, last_name, birth_date FROM patients
WHERE YEAR(birth_date) LIKE '197%'
ORDER BY birth_date ASC;

--30. We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
--EX: SMITH,jane

SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS name FROM patients
ORDER BY first_name DESC;

--31. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.

SELECT province_id, SUM(height) FROM patients
GROUP BY province_id
HAVING SUM(height) > 7000;

--32. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'

SELECT MAX(weight) - MIN(weight) AS diff FROM patients
WHERE last_name = 'Maroni';

--33. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.

SELECT DAY(admission_date) AS day_num, COUNT(*) AS num FROM admissions
GROUP BY day_num
ORDER BY num DESC;

--34. Show all columns for patient_id 542's most recent admission_date.

SELECT * FROM admissions
WHERE patient_id = 542
GROUP BY patient_id
HAVING MAX(admission_date);

SELECT *, MAX(admission_date) FROM admissions
WHERE patient_id = 542;

--35. Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
--1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
--2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.

SELECT patient_id, attending_doctor_id, diagnosis FROM admissions
WHERE (patient_id % 2 != 0 AND attending_doctor_id IN (1, 5, 19))
OR (attending_doctor_id LIKE ('%2%') AND LEN(patient_id) = 3);

--36. Show first_name, last_name, and the total number of admissions attended for each doctor. Every admission has been attended by a doctor.

SELECT first_name, last_name, COUNT(attending_doctor_id) FROM admissions AS a
LEFT JOIN doctors AS d ON a.attending_doctor_id = d.doctor_id
GROUP BY attending_doctor_id;

--37. For each physicain, display their id, full name, and the first and last admission date they attended.

SELECT doctor_id,
CONCAT(first_name, ' ', last_name) AS name,
MIN(admission_date) AS last,
MAX(admission_date) AS first FROM admissions AS a
LEFT JOIN doctors AS d ON a.attending_doctor_id = d.doctor_id
GROUP BY name
ORDER BY doctor_id ASC;

--38. Display the total amount of patients for each province. Order by descending.

SELECT COUNT(patient_id) AS count, province_name FROM patients
LEFT JOIN province_names ON patients.province_id = province_names.province_id
GROUP BY province_name
ORDER BY count DESC;

--39. For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.

SELECT CONCAT(p.first_name, ' ', p.last_name) AS full_name,
diagnosis,
CONCAT(d.first_name, ' ', d.last_name) AS doctor_name FROM patients AS p
LEFT JOIN admissions AS a ON p.patient_id = a.patient_id
LEFT JOIN doctors AS d ON a.attending_doctor_id = d.doctor_id
WHERE diagnosis IS NOT NULL;

SELECT CONCAT(p.first_name, ' ', p.last_name) AS full_name,
diagnosis,
CONCAT(d.first_name, ' ', d.last_name) AS doctor_name FROM patients AS p
JOIN admissions AS a ON p.patient_id = a.patient_id
JOIN doctors AS d ON a.attending_doctor_id = d.doctor_id;

--40. Display the number of duplicate patients based on their first_name and last_name.

SELECT first_name, last_name, COUNT(*) FROM patients
GROUP BY last_name, first_name
HAVING COUNT(last_name) > 1;

--41. Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the list by the weight group decending.

--For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.

SELECT COUNT(*), FLOOR(weight/10) * 10 AS weight_group FROM patients
GROUP by weight_group
order by weight_group DESC;

--42. Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m)2) >= 30.

--weight is in units kg.
--height is in units cm.

SELECT patient_id, weight, height,
CASE
    WHEN weight/POWER(height/100.0, 2) >= 30 THEN 1
    WHEN weight/POWER(height/100.0, 2) < 30 THEN 0
    ELSE 'Unknown'
END AS is_obese
FROM patients;

--43. Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'

--Check patients, admissions, and doctors tables for required information. 

SELECT p.patient_id, p.first_name, p.last_name, specialty FROM patients AS p
JOIN admissions AS a ON p.patient_id = a.patient_id
JOIN doctors AS d ON a.attending_doctor_id = d.doctor_id
WHERE diagnosis = 'Epilepsy' AND d.first_name = 'Lisa';

--44. All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.

--The password must be the following, in order:
--1. patient_id
--2. the numerical length of patient's last_name
--3. year of patient's birth_date

SELECT DISTINCT patients.patient_id,
CONCAT(patients.patient_id, LEN(last_name), YEAR(birth_date)) AS temp_password FROM patients
JOIN admissions ON patients.patient_id = admissions.patient_id;

--45. Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.

--Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.

SELECT 'Yes' AS yes_insurance, COUNT(*) * 10 total_cost
FROM admissions
WHERE patient_id % 2 = 0
UNION
SELECT 'No' AS no_insurance, COUNT(*) * 50 total_cost
FROM admissions
WHERE patient_id % 2 != 0;

--46. Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name

SELECT province_name FROM
( SELECT province_name,
SUM(gender = 'M') AS male,
SUM(gender = 'F') AS female FROM patients
LEFT JOIN province_names ON patients.province_id = province_names.province_id
GROUP BY province_name
HAVING male > female );

--47. We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
--- First_name contains an 'r' after the first two letters.
--- Identifies their gender as 'F'
--- Born in February, May, or December
--- Their weight would be between 60kg and 80kg
--- Their patient_id is an odd number
--- They are from the city 'Kingston'

SELECT * FROM patients
WHERE first_name LIKE '__r%'
AND gender = 'F'
AND MONTH(birth_date) IN (2, 5, 12)
AND weight BETWEEN 60 AND 80
AND patient_id % 2 != 0
AND city = 'Kingston';

--48. Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.

SELECT CONCAT(ROUND(100 * AVG(gender = 'M'), 2), '%') FROM patients;

--49. For each day display the total amount of admissions on that day. Display the amount changed from the previous date.

SELECT admission_date,
COUNT(admission_date),
COUNT(admission_date) - LAG(COUNT(admission_date)) OVER (ORDER BY admission_date) AS diff FROM admissions
GROUP BY admission_date
ORDER BY admission_date ASC;

--50. Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.

SELECT province_name FROM province_names
ORDER BY 
CASE 
    WHEN province_name = 'Ontario' THEN 0
    ELSE 1
END, province_name ASC;