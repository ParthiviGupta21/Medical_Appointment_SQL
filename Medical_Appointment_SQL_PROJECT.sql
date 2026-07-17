Create database Medical_Appointment;
use Medical_Appointment;

-- 1. Slots Table
CREATE TABLE Slots (
    slot_id INT PRIMARY KEY,
    appointment_date DATE,
    appointment_time TIME,
    is_available BOOLEAN
);

-- 2. Patients Table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(60),
    sex VARCHAR(15),
    dob DATE,
    insurance VARCHAR(30)
);

-- 3. Appointments Table
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    slot_id INT,
    scheduling_date DATE,
    appointment_date DATE,
    appointment_time TIME,
    scheduling_interval INT,
    status VARCHAR(20),
    check_in_time TIME,
    appointment_duration FLOAT,
    start_time TIME,
    end_time TIME,
    waiting_time FLOAT,
    patient_id INT,
    sex VARCHAR(15),
    age INT,
    age_group VARCHAR(20),

    FOREIGN KEY (slot_id) REFERENCES Slots(slot_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);
select*from appointments;
select count(*) as Total_Appointments from appointments;

select*from patients;
select count(*) as Total_patients from patients;

select*from slots;
select count(*) as Total_slots from slots;

-- Basic Queries --
-- Available slots --
SELECT * FROM Slots
WHERE is_available = 'False';

-- Distinct insurance providers --
SELECT DISTINCT insurance FROM Patients;

-- Where + Filters
-- Completed appointments
SELECT * FROM Appointments
WHERE status = 'attended';

-- Patients above age 30
SELECT * FROM Appointments
WHERE age > 30;

-- Joins --
-- Appointment + Patient details
SELECT a.appointment_id, p.name, a.status
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id;

-- Slot + Appointment (Left Join) --
SELECT s.slot_id, s.appointment_time, a.status
FROM Slots s
LEFT JOIN Appointments a ON s.slot_id = a.slot_id;

-- Full Join View
SELECT p.name, a.appointment_date, s.appointment_time
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
JOIN Slots s ON a.slot_id = s.slot_id;

-- Slot + Appointment (Right Join)
SELECT s.slot_id, s.appointment_time, a.status
FROM Slots s
RIGHT JOIN Appointments a 
ON a.slot_id = s.slot_id;

-- Aggregate function --
-- Total appointments by status
SELECT status, COUNT(*) 
FROM Appointments
GROUP BY status;

-- Avg waiting time
SELECT AVG(waiting_time) FROM Appointments;

-- Max duration
SELECT MAX(appointment_duration) FROM Appointments;

-- String Function --
-- Uppercase names
SELECT UPPER(name) FROM Patients;

-- Extract first name
SELECT SUBSTRING(name, 1, 4) FROM Patients;

-- Name length
SELECT name, LENGTH(name) FROM Patients;


-- 17 Days between scheduling & appointment
SELECT appointment_id,
DATEDIFF(appointment_date, scheduling_date) AS days_diff
FROM Appointments;

-- Case Statement--
-- Categorize waiting time--
SELECT appointment_id,
CASE 
    WHEN waiting_time < 5 THEN 'Low'
    WHEN waiting_time BETWEEN 5 AND 15 THEN 'Medium'
    ELSE 'High'
END AS waiting_category
FROM Appointments;

-- Subqueries --
--  Patients with max waiting time
SELECT * FROM Appointments
WHERE waiting_time = (SELECT MAX(waiting_time) FROM Appointments);

-- Patients with above average duration
SELECT * FROM Appointments
WHERE appointment_duration > 
      (SELECT AVG(appointment_duration) FROM Appointments);
      
-- Window function --
-- Rank patients by waiting time
SELECT appointment_id, waiting_time,
RANK() OVER (ORDER BY waiting_time DESC) AS rank_wait
FROM Appointments;

-- Running total of appointments
SELECT appointment_date,
COUNT(*) OVER (ORDER BY appointment_date) AS running_total
FROM Appointments;

-- Partition by status
SELECT appointment_id, status,
COUNT(*) OVER (PARTITION BY status) AS total_by_status
FROM Appointments;



-- Peak appointment hour
SELECT appointment_time, COUNT(*) AS total
FROM Appointments
GROUP BY appointment_time
ORDER BY total DESC;

-- Patient visit frequency
SELECT patient_id, COUNT(*) AS visits
FROM Appointments
GROUP BY patient_id
ORDER BY visits DESC;

-- Average waiting time by age group
SELECT age_group, AVG(waiting_time)
FROM Appointments
GROUP BY age_group;


-- Repeat patients (more than 2 visits)
SELECT patient_id, COUNT(*) AS visit_count
FROM Appointments
GROUP BY patient_id
HAVING COUNT(*) > 2;

-- First and last visit of each patient
SELECT patient_id,
MIN(appointment_date) AS first_visit,
MAX(appointment_date) AS last_visit
FROM Appointments
GROUP BY patient_id;

-- Peak booking day
SELECT appointment_date, COUNT(*) AS total
FROM Appointments
GROUP BY appointment_date
ORDER BY total DESC;

-- Appointments by hour
SELECT HOUR(appointment_time) AS hour, COUNT(*) AS total
FROM Appointments
GROUP BY HOUR(appointment_time)
ORDER BY total DESC;

-- Unused slots
SELECT * FROM Slots
WHERE slot_id NOT IN (SELECT slot_id FROM Appointments);

-- -------------------------------------------------------- --
-- DATA EXPLORATION --

-- Total records
SELECT COUNT(*) FROM Appointments;

-- Unique patients
SELECT COUNT(DISTINCT patient_id) FROM Appointments;

-- Status distribution
SELECT status, COUNT(*) 
FROM Appointments
GROUP BY status;

-- Date range
SELECT MIN(appointment_date), MAX(appointment_date)
FROM Appointments;

-- Top 5 patients by Visit
SELECT patient_id, COUNT(*) AS visits
FROM Appointments
GROUP BY patient_id
ORDER BY visits DESC
LIMIT 5;

SELECT appointment_id,
DATEDIFF(appointment_date, scheduling_date) AS delay_days
FROM Appointments;

SELECT sex, COUNT(*) AS total
FROM Appointments
GROUP BY sex;


SELECT p.patient_id, p.name, COUNT(*) AS visits
FROM Appointments a
JOIN Patients p 
ON a.patient_id = p.patient_id
GROUP BY p.patient_id, p.name
ORDER BY visits DESC
LIMIT 5;



