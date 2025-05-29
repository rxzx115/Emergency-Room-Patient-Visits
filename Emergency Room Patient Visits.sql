-- Use database
USE projects


-- Create  Table
CREATE TABLE patient_visits (
    patient_id NVARCHAR(50) PRIMARY KEY,
    gender NVARCHAR(10),
    age INT,
    sat_score INT,
    race NVARCHAR(50),
    admin_flag NVARCHAR(10),
    patient_waittime INT,
    department_referral NVARCHAR(100),
    time TIME,
    date DATE,
    hour INT,
    patient_name NVARCHAR(100)
)


-- Drop table
DROP TABLE patient_visits


-- Load the data
BULK INSERT patient_visits
FROM 'C:\Users\Ryan Zheng\Downloads\hospital_er_patients_data_a.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
)


-- Select the data
SELECT *
FROM patient_visits


-- How do average patient wait times differ across various demographic groups (e.g., by age, gender, and race)?
-- Age
SELECT
    age,
    AVG(patient_waittime) AS AverageWaitTimeMinutes,
    COUNT(patient_id) AS NumberOfPatients
FROM patient_visits
GROUP BY age
ORDER BY age ASC

-- Gender
SELECT
    gender,
    AVG(patient_waittime) AS AverageWaitTimeMinutes,
    COUNT(patient_id) AS NumberOfPatients
FROM patient_visits
GROUP BY gender
ORDER BY AverageWaitTimeMinutes DESC

-- Race
SELECT
    race,
    AVG(patient_waittime) AS AverageWaitTimeMinutes,
    COUNT(patient_id) AS NumberOfPatients
FROM
    patient_visits
GROUP BY race
ORDER BY AverageWaitTimeMinutes DESC


-- What is the direct correlation between patient wait times and reported patient satisfaction scores (sat_score)?
SELECT
    CASE
        WHEN patient_waittime BETWEEN 0 AND 15 THEN '0-15 Mins'
        WHEN patient_waittime BETWEEN 16 AND 30 THEN '16-30 Mins'
        WHEN patient_waittime BETWEEN 31 AND 45 THEN '31-45 Mins'
        WHEN patient_waittime BETWEEN 46 AND 60 THEN '46-60 Mins'
        ELSE '60+ Mins'
    END AS WaitTimeBand,
    AVG(sat_score) AS AverageSatisfactionScore,
    COUNT(patient_id) AS NumberOfPatientsInBand
FROM
    patient_visits -- 
WHERE
    sat_score IS NOT NULL
GROUP BY
    CASE
        WHEN patient_waittime BETWEEN 0 AND 15 THEN '0-15 Mins'
        WHEN patient_waittime BETWEEN 16 AND 30 THEN '16-30 Mins'
        WHEN patient_waittime BETWEEN 31 AND 45 THEN '31-45 Mins'
        WHEN patient_waittime BETWEEN 46 AND 60 THEN '46-60 Mins'
        ELSE '60+ Mins'
    END
ORDER BY
    MIN(patient_waittime)


-- How do patient arrival patterns (e.g., by hour of day or time of visit) influence average patient wait times and subsequent patient satisfaction scores?
SELECT
    hour AS ArrivalHourOfDay,
    AVG(patient_waittime) AS AverageWaitTimeMinutes,
    AVG(sat_score) AS AverageSatisfactionScore,
    COUNT(patient_id) AS NumberOfPatients
FROM
    patient_visits 
GROUP BY
    hour
ORDER BY
    hour


-- What is the impact of departments (department_referral) on average wait times or satisfaction levels compared to those not referred, or referred to other departments?
SELECT
    department_referral,
    AVG(patient_waittime) AS AverageWaitTimeMinutes,
    AVG(sat_score) AS AverageSatisfactionScore,
    COUNT(patient_id) AS NumberOfPatients
FROM
    patient_visits 
GROUP BY
    department_referral
ORDER BY
    AverageWaitTimeMinutes DESC


-- What is the relationship between a patient's admission status (admin_flag) and their average wait time and patient satisfaction score?
SELECT
    CASE
        WHEN admin_flag = 'TRUE' THEN 'Admitted' 
        ELSE 'Discharged'
    END AS AdmissionStatus,
    AVG(patient_waittime) AS AverageWaitTimeMinutes,
    AVG(sat_score) AS AverageSatisfactionScore,
    COUNT(patient_id) AS NumberOfPatients
FROM
    patient_visits 
GROUP BY
    admin_flag
ORDER BY
    AverageWaitTimeMinutes DESC

