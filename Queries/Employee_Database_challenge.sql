DROP TABLE retirement_titles;
DROP TABLE unique_titles;
DROP TABLE retiring_titles;
DROP TABLE mentorship_eligibility;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Get Unique titles and count()
SELECT COUNT(emp_no) AS emp_count , title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC

-- Creating mentorship_eligibility table 
SELECT DISTINCT ON (e.emp_no) e.emp_no,e.first_name,e.last_name,e.birth_date,de.from_date,de.to_date,ti.title
INTO mentorship_eligibility
FROM employees e
LEFT JOIN dept_emp de ON e.emp_no = de.emp_no 
LEFT JOIN titles ti ON e.emp_no = ti.emp_no 
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (de.to_date = '9999-01-01') AND (ti.to_date = '9999-01-01')
ORDER BY e.emp_no ASC, ti.to_date DESC

-- Check employee 10291 latest title
SELECT * FROM titles 
WHERE emp_no = 10291

-- Total retiring titles 
SELECT COUNT(*) FROM unique_titles

-- Average salay of retiring employees per department.
SELECT d.dept_name, CAST(AVG(s.salary) AS DECIMAL(10,2)) AS avg_salary FROM salaries s
LEFT JOIN dept_emp de ON  s.emp_no = de.emp_no
LEFT JOIN departments d ON de.dept_no = d.dept_no
LEFT JOIN unique_titles ut ON s.emp_no = ut.emp_no
GROUP BY d.dept_name 
ORDER BY avg_salary DESC



 

