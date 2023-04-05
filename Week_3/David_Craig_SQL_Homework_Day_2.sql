-- SQL Day 2 Lab and Homework

--MVP

--Q1
--a). Find the first name, last name and team name of employees who are members of teams.
SELECT 
	employees.first_name,
	employees.last_name,
	teams."name" 
FROM employees
INNER JOIN teams 
ON employees.team_id = teams.id; 

-- (b). Find the first name, last name and team name of employees who are members of teams and are enrolled in the pension scheme.

SELECT 
	employees.first_name,
	employees.last_name,
	teams."name" 
FROM employees
INNER JOIN teams 
ON employees.team_id = teams.id
WHERE pension_enrol = TRUE; 

-- (c). Find the first name, last name and team name of employees who are members of teams, where their team has a charge cost greater than 80.

SELECT 
	employees.first_name,
	employees.last_name,
	teams."name" 
FROM employees
INNER JOIN teams 
ON employees.team_id = team.id
WHERE teams.charge_cost = '100';

SELECT 
	employees.first_name,
	employees.last_name,
	teams."name" 
FROM employees
INNER JOIN teams 
ON employees.team_id = teams.id
WHERE CAST(teams.charge_cost AS NUMERIC) > 80;

-- Q2.
-- (a). Get a table of all employees details, together with their local_account_no and local_sort_code, if they have them.

SELECT 
	employees.*,
	pay_details.local_account_no,
	pay_details.local_sort_code
FROM employees 
INNER JOIN pay_details 
ON employees.pay_detail_id = pay_details.id; 

-- (b). Amend your query above to also return the name of the team that each employee belongs to.

SELECT 
  e.*,
  pd.local_account_no,
  pd.local_sort_code,
  t.name AS team_name
FROM employees AS e LEFT JOIN pay_details AS pd
ON e.pay_detail_id = pd.id
LEFT JOIN teams AS t
ON e.team_id = t.id;

--Q3 (a). Make a table, which has each employee id along with the team that employee belongs to.

SELECT 
	employees.id,
	teams."name" 
FROM employees INNER JOIN teams
ON employees.team_id = teams.id;

-- (b). Breakdown the number of employees in each of the teams.

SELECT 
	teams."name",
	count(employees.id) AS number_employees
FROM employees INNER JOIN teams
ON employees.team_id = teams.id
GROUP BY teams.name

--(c). Order the table above by so that the teams with the least employees come first.

SELECT 
	teams."name",
	count(employees.id) AS number_employees
FROM employees INNER JOIN teams
ON employees.team_id = teams.id
GROUP BY teams.name
ORDER BY number_employees


-- Q4. (a). Create a table with the team id, team name and the count of the number of employees in each team.

SELECT 
	teams.id,
	teams."name",
	count(employees.id) AS number_employees
FROM employees INNER JOIN teams
ON employees.team_id = teams.id
GROUP BY teams.id 

-- (b). The total_day_charge of a team is defined as the charge_cost of the team multiplied by the number of employees in the team. Calculate the total_day_charge for each team.

SELECT 
	teams.id,
	teams."name",
	count(employees.id) AS number_employees,
	count(employees.id) * cast(teams.charge_cost AS numeric) AS total_charge_cost
FROM employees 
INNER JOIN teams ON employees.team_id = teams.id
GROUP BY teams.id, teams."name", teams.charge_cost 


-- (c). How would you amend your query from above to show only those teams with a total_day_charge greater than 5000?

SELECT 
	teams."name",
	count(employees.id) * cast(teams.charge_cost AS numeric) > 5000 AS total_charge_cost_5000
FROM employees 
INNER JOIN teams ON employees.team_id = teams.id
GROUP BY teams.id, teams."name", teams.charge_cost;

--Question 5 How many of the employees serve on one or more committees?

SELECT 
count(DISTINCT(employee_id))
FROM employees_committees

--Question 6 How many of the employees do not serve on a committee?

SELECT
	count(employees.id)
FROM employees 
LEFT JOIN employees_committees 
ON employees.id = employees_committees.employee_id
WHERE employees_committees.committee_id IS NULL;









