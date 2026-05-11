# 📊 HR Analytics & Employee Attrition Analysis

> A comprehensive end-to-end HR analytics project using **SQL (PostgreSQL)** for data engineering and **Power BI** for interactive visualization — uncovering the key drivers of employee attrition and workforce risk.

---

## 📁 Project Structure

```
hr-analytics-dashboard/
│
├── Dataset/
│   ├── HR-Employee-Attrition.csv       # Employee attrition dataset
│   
│
├── SQL/
│   └── hr_analytics_project_sql.sql    # Full SQL analysis pipeline
│
├── PowerBI/
│   └── hr_analytics_employee_attrition_dashboard.pbix
│                                          # Interactive Power BI dashboard
│
├── Dashboards/
│   ├── executive_dashboard.png         # Executive Workforce Overview
│   ├── compensation_growth.png         # Compensation & Career Growth Analysis
│   ├── satisfaction_analysis.png       # Employee Satisfaction & Engagement Analysis
│   └── workforce_risk.png              # Workforce Risk & Attrition Analysis
│
└── README.md                           # Project documentation
```

---

## 🎯 Project Objective

This project analyzes a company's employee dataset to:

- Identify **why employees leave** (attrition drivers)
- Segment the workforce by **risk level**
- Uncover patterns in **compensation, satisfaction, and career growth**
- Enable HR leadership to make **data-driven retention decisions**

---

## 🗄️ Dataset Overview

The dataset contains **1,470 employee records** with 35 attributes across demographics, job details, compensation, satisfaction scores, and tenure metrics.

| Category | Key Columns |
|---|---|
| Demographics | Age, Gender, MaritalStatus, Education |
| Job Details | Department, JobRole, JobLevel, BusinessTravel |
| Compensation | MonthlyIncome, DailyRate, PercentSalaryHike, StockOptionLevel |
| Satisfaction | JobSatisfaction, EnvironmentSatisfaction, WorkLifeBalance, RelationshipSatisfaction |
| Tenure & Growth | YearsAtCompany, YearsInCurrentRole, YearsSinceLastPromotion, TotalWorkingYears |
| Risk Indicators | OverTime, Attrition |

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| **PostgreSQL** | Database design, data cleaning, transformation, analysis |
| **Power BI** | Interactive dashboards and visual storytelling |
| **SQL Window Functions** | Salary ranking, comparative analysis |
| **Power BI DAX** | KPI measures, attrition rate calculations |

---

## 🔄 SQL Pipeline

The SQL script is structured in 10 progressive phases:

### 1. Data Understanding
```sql
-- Preview data and check distributions
SELECT attrition, COUNT(*) FROM employee_attrition GROUP BY attrition;
```

### 2. Data Cleaning
- Null value checks on key columns (`MonthlyIncome`)
- Duplicate employee detection using `GROUP BY` + `HAVING COUNT(*) > 1`

### 3. Data Transformation
Derived columns created for readability and segmentation:

| Transformation | Output |
|---|---|
| Age bucketing | `'18-25'`, `'26-35'`, `'36-45'`, `'46+'` |
| Income banding | `'Low Income'` (<3K), `'Medium Income'` (3K–7K), `'High Income'` (>7K) |
| Satisfaction labels | `'Low'`, `'Medium'`, `'High'`, `'Very High'` |
| Work-life balance labels | `'Bad'`, `'Good'`, `'Better'`, `'Best'` |

### 4–9. Analytical Queries
Deep-dive analysis across six domains:

- **Attrition Analysis** — by department, job role, gender, overall rate
- **Overtime Analysis** — overtime vs. attrition rate comparison
- **Salary Analysis** — department averages, salary band vs. attrition, top earners by department (window functions)
- **Satisfaction Analysis** — job satisfaction, work-life balance, and environment satisfaction vs. attrition
- **Career Growth Analysis** — promotion delay patterns, tenure vs. attrition
- **High-Risk Employee Analysis** — multi-factor risk segmentation

### 10. Summary Views
Three reusable views created for Power BI connectivity:

| View | Purpose |
|---|---|
| `vw_hr_summary` | Aggregated salary and tenure by department/role/gender |
| `vw_employee_analysis` | Full enriched employee profile with all derived labels |
| `vw_employee_risk_analysis` | Risk tier classification per employee |

---

## 📊 Power BI Dashboards

### Dashboard 1 — HR Analytics Executive Dashboard

> **Audience:** C-Suite / HR Leadership  
> **Purpose:** Company-wide attrition snapshot

**KPIs:**
| Metric | Value |
|---|---|
| Total Employees | 1,470 |
| Total Attrition | 237 |
| Attrition Rate | **16.12%** |
| Average Salary | $6.5K/month |
| High-Risk Employees | 39 |
| Average Experience | 11.28 years |

**Key Insights:**
- **Research & Development** has the highest absolute attrition (133 employees), though this also reflects the largest department size
- **Sales** follows with significant attrition driven by high-pressure roles
- **Lab Technicians (62)** and **Sales Executives (57)** are the top two most affected job roles
- The **26–35 age group** sees the highest attrition across both genders — indicating early-career flight risk
- **Males account for 63.29%** of total attrition vs. 36.71% female

---

### Dashboard 2 — Compensation & Career Growth Analysis

> **Audience:** HR Business Partners, Compensation Teams  
> **Purpose:** Understand salary structures and promotion-linked attrition

**KPIs:**
| Metric | Value |
|---|---|
| Average Salary Hike | 15.2% |
| Employees Without Promotion | 260 |
| High Income Employees | 435 |
| Avg. Years at Company | 7 |

**Key Insights:**
- Attrition is **heavily concentrated in Year 0–1** since last promotion — employees who feel stagnant leave early
- Company tenure analysis shows **peak attrition in Years 1–3**, suggesting early-tenure disengagement
- **Sales department** has the highest average salary (~$7.0K), followed by HR (~$6.7K) and R&D (~$6.3K)
- **43.54% of employees** are in the Medium Income band — the group most susceptible to competitive offers
- **Managers earn ~$17K** and Research Directors ~$16K, creating a clear earnings gap from entry-level roles (~$3K)
- 260 employees have gone without a promotion — a critical retention risk pool

---

### Dashboard 3 — Employee Experience Analysis

> **Audience:** HR Operations, Culture & Engagement Teams  
> **Purpose:** Map satisfaction and work-life balance to attrition

**KPIs:**
| Metric | Value |
|---|---|
| Avg. Job Satisfaction Score | 2.73 / 4 |
| Avg. Work-Life Balance Score | 2.76 / 4 |
| Overtime Employees | 416 |
| Low Satisfaction Employees | 569 |

**Key Insights:**
- Attrition is **distributed across all satisfaction levels** — even "High" satisfaction employees (73 attritions) leave, suggesting satisfaction alone is insufficient
- Employees with **Environment Satisfaction = 1 (lowest)** have the highest attrition (72), confirming workplace environment is a top driver
- **"Better" work-life balance** (score 3) has the largest employee group — but also the most attrition departures, as this group is the largest overall
- **569 low-satisfaction employees** represent a significant at-risk population
- **Single employees account for 50.63%** of attrition — the most mobile demographic, followed by Married (35.44%) and Divorced (13.92%)

---

### Dashboard 4 — Workforce Risk Analysis

> **Audience:** HR Leadership, Department Heads  
> **Purpose:** Identify and quantify workforce risk factors

**KPIs:**
| Metric | Value |
|---|---|
| Overtime Attrition Rate | **53.59%** |
| Poor Work-Life Balance Employees | 424 |
| Low Satisfaction Employees | 569 |
| Employees Without Promotion | 260 |

**Key Insights:**

* Attrition is heavily concentrated in Year 0–1 since last promotion — employees who feel stagnant leave early
* Company tenure analysis shows peak attrition in Years 1–3, suggesting early-tenure disengagement
* Sales department has the highest average salary (≈$7.0K), followed by HR (≈$6.7K) and R&D (≈$6.3K)
* 43.54% of employees are in the Medium Income band — the group most susceptible to competitive offers
* Managers earn ≈$17K and Research Directors ≈$16K, creating a clear earnings gap from entry-level roles (≈$3K)
* 260 employees have gone without a promotion — a critical retention risk pool
---

## 🔍 Cross-Dashboard Key Findings

| # | Finding | Business Impact |
|---|---|---|
| 1 | Overtime attrition rate is **53.59%** | Mandatory OT policies are destroying retention |
| 2 | **260 employees** have never been promoted | Promotion pipeline gaps are building resentment |
| 3 | **Lab Technicians & Sales Executives** lead role-level attrition | Role-specific burnout requires targeted intervention |
| 4 | **Early tenure (Years 1–3)** is highest-risk | Onboarding and early career experience need redesign |
| 5 | **Single employees aged 26–35** are the most mobile group | Competitive market makes this segment easy to poach |
| 6 | Low-income band correlates with high attrition | Compensation benchmarking is critical |

---

## 💡 Strategic Recommendations

1. **Overtime Policy Reform** — Implement overtime caps or compensatory days off; the 53.59% attrition rate among OT employees is unsustainable
2. **Promotion Pipeline Audit** — 260 employees without promotion need structured growth plans before they self-select out
3. **Targeted Retention for R&D & Sales** — Both departments account for the overwhelming majority of attrition; role-specific engagement programs are needed
4. **Early Tenure Engagement Programs** — Structured 90-day and 1-year check-ins to catch disengagement before it becomes a resignation
5. **Competitive Salary Review** — With 43.54% in the medium band and average hike at 15.2%, benchmarking against industry standards is essential
6. **High-Risk Employee Intervention** — The 39 flagged high-risk employees (overtime + low satisfaction + poor WLB) should be prioritized for 1:1 HR conversations

---

## 🚀 How to Run This Project

### SQL Setup
```sql
-- 1. Create the table
-- Run the CREATE TABLE statement in hr_attrition_analysis.sql

-- 2. Import data
-- Load your CSV into the employee_attrition table

-- 3. Execute analysis
-- Run queries sequentially from sections 1–10

-- 4. Create views for Power BI
-- Execute the three CREATE VIEW statements at the end
```

### Power BI Setup
1. Connect Power BI to your PostgreSQL database
2. Import the three views: `vw_hr_summary`, `vw_employee_analysis`, `vw_employee_risk_analysis`
3. Open the `.pbix` file and refresh the data source connection

---

## 📌 Future Enhancements

- [ ] Predictive attrition model using Python (logistic regression / random forest)
- [ ] Automated monthly attrition reporting pipeline
- [ ] Department-level drill-through pages in Power BI
- [ ] Integration with HRIS systems for live data refresh

---

## 👤 Author

**Nithin Shibu**  
Data Analyst | SQL · Power BI · HR Analytics  


---

## 📄 License

This project is for educational and portfolio purposes. Dataset based on the IBM HR Analytics Employee Attrition dataset.
