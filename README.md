# Medical_Appointment_SQL

Medical Appointment SQL Analysis

A SQL-based analysis of a healthcare appointment system — exploring patient behavior, scheduling patterns, and slot utilization across **111,488 appointments** to surface insights that can reduce waiting time and no-shows.

Problem Statement

Healthcare providers lose efficiency and revenue when appointment slots go unused, patients wait too long, or no-shows disrupt scheduling. This project uses SQL to analyze a healthcare appointment dataset — spanning **Patients**, **Slots**, and **Appointments** — to answer:

- When are peak booking hours and days, and how well are slots utilized?
- How long do patients wait, and does it vary by age group?
- Which patients are repeat visitors, and what's the gap between scheduling and appointment dates?
- What's the breakdown of appointment outcomes (attended, cancelled, returned, no-show)?

##  About the Dataset

Three relational tables in a `Medical_Appointment` database:

| Table | Rows | Columns | Description |
|---|---|---|---|
| `Appointments` | 111,488 | 16 | Core fact table — status, timing, waiting time, patient demographics |
| `Slots` | 104,360 | 4 | Available appointment time slots |
| `Patients` | 36,697 | 5 | Patient demographics and insurance info |

##  Tools & Techniques Used

- **SQL** (MySQL syntax) — schema design with primary/foreign keys, joins, aggregations
- **Techniques covered**:
  - Joins (`INNER`, `LEFT`, `RIGHT`) across Patients, Appointments, and Slots
  - Aggregate functions (`COUNT`, `AVG`, `MAX`) and `GROUP BY` / `HAVING`
  - String functions (`UPPER`, `SUBSTRING`, `LENGTH`)
  - Date functions (`DATEDIFF`, `HOUR`) for scheduling-gap and peak-hour analysis
  - `CASE` statements for waiting-time categorization
  - Subqueries (max/average filtering)
  - Window functions (`RANK() OVER`, `COUNT() OVER` with `PARTITION BY`, running totals)

##  Key Insights

- **Scheduling efficiency**: Measured the gap between scheduling date and appointment date (`DATEDIFF`) to flag long lead times that correlate with no-shows.
- **Waiting time patterns**: Categorized waits into Low / Medium / High buckets and compared average waiting time across age groups to identify where patients wait longest.
- **Peak demand**: Identified peak appointment hours and peak booking days via `GROUP BY` + `ORDER BY`, useful for staffing decisions.
- **Slot utilization**: Found unused slots (`NOT IN` subquery) to quantify unbooked capacity.
- **Patient loyalty**: Ranked patients by visit frequency and isolated repeat patients (>2 visits) using `HAVING COUNT(*) > 2`.
- **Outcome breakdown**: Quantified appointment status distribution (attended, cancelled, returned, refunded) to assess overall fulfillment health.

- 
