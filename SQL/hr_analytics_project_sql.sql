create table employee_attrition(
Age int,
Attrition varchar(10),
BusinessTravel VARCHAR(50),
DailyRate INT,
Department VARCHAR(100),
DistanceFromHome INT,
Education INT,
EducationField VARCHAR(100),
EmployeeCount INT,
EmployeeNumber INT PRIMARY KEY,
EnvironmentSatisfaction INT,
Gender VARCHAR(10),
HourlyRate INT,
JobInvolvement INT,
JobLevel INT,
JobRole VARCHAR(100),
JobSatisfaction INT,
MaritalStatus VARCHAR(20),
MonthlyIncome INT,
MonthlyRate INT,
NumCompaniesWorked INT,
Over18 VARCHAR(5),
OverTime VARCHAR(10),
PercentSalaryHike INT,
PerformanceRating INT,
RelationshipSatisfaction INT,
StandardHours INT,
StockOptionLevel INT,
TotalWorkingYears INT,
TrainingTimesLastYear INT,
WorkLifeBalance INT,
YearsAtCompany INT,
YearsInCurrentRole INT,
YearsSinceLastPromotion INT,
YearsWithCurrManager INT
 
);

--- 1. DATA UNDERSTANDING ------

--sample data

select * from employee_attrition 
limit 10;

--Count Total Employees

select count(*) from employee_attrition;

--Checking Attrition Distribution

select attrition ,count(*) 
from employee_attrition
group by attrition;

--- 2. DATA CLEANING ------

--Checking Null Values

select * from employee_attrition
where MonthlyIncome IS NULL;

--Checking Duplicate Employees

select employeenumber,count(*)
from employee_attrition
group by employeenumber
having count(*)>1;

--- 3. DATA TRANSFORMATION -----

--Creating Age Groups column

select age,
case
		when age between 18 and 25 then '18 - 25'
		when age between 26 and 35 then '26 - 35'
		when age between 36 and 45 then '36 - 45'
		else '46+'
end as age_group
from employee_attrition;

--Creating Salary Bands

select MonthlyIncome,
case 
		when MonthlyIncome<3000 then 'Low Income'
		when MonthlyIncome between 3000 and 7000 then 'Medium Income'
		else 'High Income'
end as salary_band
from employee_attrition;

--Convert Satisfaction Labels

select
case 
		when JobSatisfaction =1 then 'Low'
		when JobSatisfaction=2  then  'Medium'
		when JobSatisfaction=3  then  'High'
		when JobSatisfaction=4 then  'Very High'

end as satisfaction_level
from employee_attrition;

--convert work-life balance Labels

SELECT
    worklifebalance,

    CASE
        WHEN worklifebalance = 1 THEN 'Bad'
        WHEN worklifebalance = 2 THEN 'Good'
        WHEN worklifebalance = 3 THEN 'Better'
        WHEN worklifebalance = 4 THEN 'Best'
    END AS worklife_level

FROM employee_attrition;

-- 4. Attrition Analysis ----

-- Overall Attrition Rate

select 
	ROUND(
	100 * sum (case when attrition='Yes' then 1 else 0 END) /count(*) ,1
	)
 	AS attrition_rate 

from employee_attrition;

--Attrition by Department

select department,
	count(*) as attrition_count
from employee_attrition
where attrition = 'Yes'
group by department 
order by attrition_count DESC;

-- Department-wise Attrition Rate

SELECT
    department,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS attrition_count,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS attrition_rate

FROM employee_attrition

GROUP BY department

ORDER BY attrition_rate DESC;


--Attrition by Job Role

select jobrole,
      count(*) as attrition_count
from employee_attrition
where attrition= 'Yes'
group by jobrole
order by attrition_count DESC;

-- Attrition by Gender

SELECT
    gender,
    attrition,
    COUNT(*) AS employee_count

FROM employee_attrition

GROUP BY gender, attrition

ORDER BY gender;

-- 5. Overtime Analysis ----

-- Overtime vs Attrition

select overtime , attrition,
		count(*) as attrition_count
		from employee_attrition
	group by overtime,attrition;

-- Overtime Attrition Rate

SELECT
    overtime,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS attrition_count,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS overtime_attrition_rate

FROM employee_attrition

GROUP BY overtime;

		

--6. Salary Analysis ---------

-- Department-wise Average Salary

select department,
	ROUND(AVG(MonthlyIncome),2) as Avg_Salary
	from employee_attrition
	group by department;

-- Salary vs Attrition

SELECT
    attrition,

    ROUND(
        AVG(monthlyincome),
        2
    ) AS average_salary

FROM employee_attrition

GROUP BY attrition;

---- Salary Band vs Attrition

SELECT

    CASE
        WHEN monthlyincome < 3000 THEN 'Low Income'
        WHEN monthlyincome BETWEEN 3000 AND 7000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS salary_band,

    attrition,

    COUNT(*) AS employee_count

FROM employee_attrition

GROUP BY salary_band, attrition

ORDER BY salary_band;

-- Top Salary Employees by Department

SELECT
    department,
    jobrole,
    monthlyincome,

    RANK() OVER(
        PARTITION BY department
        ORDER BY monthlyincome DESC
    ) AS salary_rank

FROM employee_attrition;

-- 7. Satisfaction Analysis------

-- Job Satisfaction vs Attrition

SELECT
    jobsatisfaction,
    attrition,

    COUNT(*) AS employee_count

FROM employee_attrition

GROUP BY jobsatisfaction, attrition

ORDER BY jobsatisfaction;

--Work-Life Balance Analysis vs Attrition

select worklifebalance,
		attrition,
		count(*) as employees
from employee_attrition
group by worklifebalance,attrition
order by worklifebalance;

-- Environment Satisfaction vs Attrition

SELECT
    environmentsatisfaction,
    attrition,

    COUNT(*) AS employee_count

FROM employee_attrition

GROUP BY environmentsatisfaction, attrition

ORDER BY environmentsatisfaction;

 --8.CAREER GROWTH ANALYSIS---

--Promotion Delay Analysis
select  yearssincelastpromotion,
		count(*) as attrition_count
		from employee_attrition
		where attrition='Yes'
group by yearssincelastpromotion
order by yearssincelastpromotion;

-- Years at Company vs Attrition

SELECT
    yearsatcompany,

    COUNT(*) AS attrition_count

FROM employee_attrition

WHERE attrition = 'Yes'

GROUP BY yearsatcompany

ORDER BY yearsatcompany;


 ---9. HIGH RISK EMPLOYEE ANALYSIS---

--High Risk Employees

select * from employee_attrition
where overtime='Yes'
AND jobsatisfaction<=2 
AND  worklifebalance <= 2;

-- Risk Segmentation

SELECT
    employeenumber,
    department,
    jobrole,
    attrition,

    CASE

        WHEN overtime = 'Yes'
            AND jobsatisfaction <= 2
            AND worklifebalance <= 2
        THEN 'High Risk'

        WHEN jobsatisfaction <= 2
            OR worklifebalance <= 2
        THEN 'Medium Risk'

        ELSE 'Low Risk'

    END AS risk_level

FROM employee_attrition;


-- 10. Creating Summary Views ---

create VIEW vw_hr_summary AS
select 
	department,
	jobrole,
	gender,
	overtime,
	attrition,
	avg(monthlyincome) as avg_salary,
	AVG(yearsatcompany) AS avg_tenure
FROM employee_attrition
group by
	department,
	jobrole,
	gender,
	overtime,
	attrition;
	

-- Employee Analysis View

CREATE VIEW vw_employee_analysis AS

SELECT
    employeenumber,
    age,

    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        ELSE '46+'
    END AS age_group,

    gender,
    department,
    jobrole,
    maritalstatus,
    attrition,
    overtime,
    businesstravel,
    monthlyincome,

    CASE
        WHEN monthlyincome < 3000 THEN 'Low Income'
        WHEN monthlyincome BETWEEN 3000 AND 7000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS salary_band,

    jobsatisfaction,

    CASE
        WHEN jobsatisfaction = 1 THEN 'Low'
        WHEN jobsatisfaction = 2 THEN 'Medium'
        WHEN jobsatisfaction = 3 THEN 'High'
        WHEN jobsatisfaction = 4 THEN 'Very High'
    END AS satisfaction_level,

    worklifebalance,

    CASE
        WHEN worklifebalance = 1 THEN 'Bad'
        WHEN worklifebalance = 2 THEN 'Good'
        WHEN worklifebalance = 3 THEN 'Better'
        WHEN worklifebalance = 4 THEN 'Best'
    END AS worklife_level,

    yearsatcompany,
    yearssincelastpromotion,
    totalworkingyears

FROM employee_attrition;



-- Employee Risk Analysis View

CREATE VIEW vw_employee_risk_analysis AS

SELECT
    employeenumber,
    department,
    jobrole,
    attrition,
    overtime,
    jobsatisfaction,
    worklifebalance,
    yearssincelastpromotion,

    CASE

        WHEN overtime = 'Yes'
            AND jobsatisfaction <= 2
            AND worklifebalance <= 2
        THEN 'High Risk'

        WHEN jobsatisfaction <= 2
            OR worklifebalance <= 2
        THEN 'Medium Risk'

        ELSE 'Low Risk'

    END AS attrition_risk

FROM employee_attrition;

