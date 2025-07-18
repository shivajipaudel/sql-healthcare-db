-- EASY LEVEL QUESTIONS

-- E1. Show first_name, last_name, and gender of patients whose gender is 'M'.
SELECT 
    first_name, last_name, gender
FROM
    patients
WHERE
    gender = 'M';

-- E2. Show first_name, last_name of patients who do not have allergies (NULL).
SELECT 
    first_name, last_name
FROM
    patients
WHERE
    allergies IS NULL;

-- E3. Show first_name of patients that start with the letter 'C'.
SELECT 
    first_name
FROM
    patients
WHERE
    first_name LIKE 'C%';

-- E4. Show first_name, last_name of patients whose weight is between 100 and 120 (inclusive).
SELECT 
    first_name, last_name
FROM
    patients
WHERE
    weight BETWEEN 100 AND 120;
    
-- E5. Update the patients table where allergies is NULL and set it to 'NKA'.
UPDATE patients 
SET 
    allergies = 'NKA'
WHERE
    allergies IS NULL;
-- E6. Show full name by concatenating first_name and last_name into one column.
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name
FROM
    patients;
    
-- E7. Show first_name, last_name, and full province name of each patient (e.g., 'Ontario' instead of 'ON').
SELECT 
    first_name, last_name, province_name
FROM
    patients
        JOIN
    province_names ON patients.province_id = province_names.province_id;
    
-- E8. Show how many patients have birth_date in the year 2010.
SELECT 
    COUNT(birth_date) AS total_patients
FROM
    patients
WHERE
    YEAR(birth_date) = 2010;
    
-- E9. Show first_name, last_name, and height of the tallest patient.
SELECT 
    first_name, last_name, height
FROM
    patients
WHERE
    height = (SELECT 
            MAX(height)
        FROM
            patients);
            
-- E10. Show all columns for patients whose patient_id is in: 1, 45, 534, 879, 1000.
SELECT 
    *
FROM
    patients
WHERE
    patient_id IN (1 , 45, 534, 879, 1000);
    
-- E11. Show the total number of admissions.
SELECT 
    COUNT(*) AS total_admissions
FROM
    admissions;
    
-- E12. Show all columns from admissions where admission_date = discharge_date.
SELECT 
    *
FROM
    admissions
WHERE
    admission_date = discharge_date;
    
-- E13. Show patient_id and total number of admissions for patient_id = 100.
SELECT 
    patient_id, COUNT(*) AS total_admissions
FROM
    admissions
WHERE
    patient_id = 100;

-- E14. Show unique cities that patients live in within province_id = 'NS'.
SELECT DISTINCT
    (city) AS unique_city
FROM
    patients
WHERE
    province_id = 'NS';

-- E15. Show first_name, last_name, and birth_date of patients with height > 160 and weight > 70.
SELECT 
    first_name, last_name, birth_date
FROM
    patients
WHERE
    height > 160 AND weight > 70;

        
-- MEDIUM LEVEL QUESTIONS

-- M1. Show first_name, last_name, and allergies of patients from 'Hamilton' with non-null allergies.
SELECT 
    first_name, last_name, allergies
FROM
    patients
WHERE
    allergies IS NOT NULL
        AND city = 'Hamilton';
        
-- M2. Show unique birth years from patients, ordered ascending.
SELECT DISTINCT
    YEAR(birth_date) AS birth_year
FROM
    patients
ORDER BY birth_year;

-- M3. Show unique first_names that appear only once in the list.
SELECT DISTINCT
    first_name
FROM
    patients
GROUP BY first_name
HAVING COUNT(first_name) = 1;

-- M4. Show patient_id, first_name where names start and end with 's' and length ≥ 2.
SELECT 
    patient_id, first_name
FROM
    patients
WHERE
    first_name LIKE 's%s'
        AND LENGTH(first_name) >= 2;

-- M5. Show patient_id, first_name, last_name of patients whose diagnosis is 'Dementia'.
SELECT 
    patients.patient_id, first_name, last_name
FROM
    patients
        JOIN
    admissions ON patients.patient_id = admissions.patient_id
WHERE
    diagnosis = 'Dementia';
    
-- M6. Display first_names of all patients, ordered by length of name then alphabetically.
SELECT 
    first_name
FROM
    patients
ORDER BY LENGTH(first_name) , first_name;

-- M7. Show total number of male and female patients in the same row.
SELECT 
    SUM(CASE
        WHEN gender = 'M' THEN 1
    END) AS male_total,
    SUM(CASE
        WHEN gender = 'F' THEN 1
    END) AS Female_total
FROM
    patients;
    
-- M8. Show first_name, last_name, allergies for patients allergic to 'Penicillin' or 'Morphine', ordered accordingly.
SELECT 
    first_name, last_name, allergies
FROM
    patients
WHERE
    allergies IN ('Penicillin' , 'Morphine')
ORDER BY allergies , first_name , last_name;

-- M9. Show patient_id, diagnosis for patients admitted multiple times with the same diagnosis.
SELECT 
    patient_id, diagnosis
FROM
    admissions
GROUP BY patient_id , diagnosis
HAVING COUNT(*) > 1;

-- M10. Show each city and total number of patients, ordered most to least, then alphabetically.
SELECT 
    city, COUNT(*) AS num_patients
FROM
    patients
GROUP BY city
ORDER BY num_patients DESC , city;

-- M11. Show first_name, last_name, and 'role' (either 'Patient' or 'Doctor').
select first_name,last_name,'patient' as role from patients
union all 
select first_name,last_name, 'doctor' as role from doctors;

-- M12. Show all allergies by popularity, excluding 'NKA' and NULL.
select allergies,count(*) as total_diagnosis
from patients 
where allergies is not null
group by allergies 
order by total_diagnosis desc;

-- M13. Show patients born in the 1970s; include first_name, last_name, and birth_date, ordered by earliest date.
select first_name,last_name,birth_date 
from patients 
where year(birth_date) between 1970 and 1979
order by birth_date;

-- M14. Show full names formatted like: LASTNAME,firstname (last name UPPERCASE, first name lowercase), ordered by first_name DESC.
select concat(upper(last_name),',',lower(first_name)) as full_name
from patients
order by first_name desc;

-- M15. Show province_ids with sum of height ≥ 7000.
select province_id, sum(height) as sum_height 
from patients
group by province_id
having sum_height>=7000;

-- M16. Show difference between max and min weight of patients with last name 'Maroni'.
SELECT MAX(weight) - min(weight) as weight_difference
FROM patients
WHERE last_name = 'Maroni';


-- M17. Show days (1–31) and how many admissions occurred on each. Order from most to least.
select day(admission_date) as day,count(*) as total_admission  
from admissions
group by day(admission_date) 
order by total_admission desc;

-- M18. Show all columns for most recent admission of patient_id = 100.
SELECT * 
FROM admissions 
WHERE patient_id = 100
ORDER BY admission_date DESC
LIMIT 1;

-- M19. Show patient_id, attending_doctor_id, diagnosis where:
-- Patient ID is odd and doctor is 1, 5, or 19, OR
-- Doctor ID contains a 2 and patient ID has 3 digits.
select patient_id,attending_doctor_id,diagnosis
from admissions
where patient_id%2!=0 and attending_doctor_id in (1,5,19)
or 
attending_doctor_id like '%2%' and length(patient_id) =3;

-- M20. Show first_name, last_name, and total number of admissions each doctor attended.
select d.first_name,d.last_name, count(*) as total_admission
from admissions 
join doctors d on admissions.attending_doctor_id = d.doctor_id 
group by attending_doctor_id;

-- M21. For each doctor, show doctor_id, full name, and their first and last admission date.
select doctor_id,concat(doctors.first_name,' ', doctors.last_name) as full_name,
min(admission_date) as first_admission_date, max(admission_date) as last_admission_date 
from doctors
join admissions on doctors.doctor_id = admissions.attending_doctor_id
group by doctor_id;

-- M22. Show total number of patients per province, ordered descending.
select province_name,count(*) as total_patient from province_names
join patients on patients.province_id = province_names.province_id
group by province_name 
order by total_patient desc;

-- M23. For every admission, show patient's full name, diagnosis, and attending doctor’s full name.
SELECT
  CONCAT(patients.first_name, ' ', patients.last_name) as patient_name,
  diagnosis,
  CONCAT(doctors.first_name,' ',doctors.last_name) as doctor_name
FROM patients
  JOIN admissions ON admissions.patient_id = patients.patient_id
  JOIN doctors ON doctors.doctor_id = admissions.attending_doctor_id;

-- M24. Show first name and number of duplicate patients based on fields.
select first_name, count(*) as no_of_duplicate 
from patients 
group by first_name 
having count(*)>1;

-- M25. Display:
-- Patient full name
-- Height (in feet, 1 decimal)
-- Weight (in pounds, no decimals)
-- Birth date
-- Gender (non abbreviated)
-- Convert CM to feet by dividing by 30.48.
-- Convert KG to pounds by multiplying by 2.205
select concat(first_name,' ',last_name) as patient_name,
round(height/30.48,1) as height_feet,
round(weight*2.205,0) as weight_pound,
birth_date,
case when gender='M' then 'Male'
else 'Female' end as abbreviated
from patients;


-- M26. Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)
select patient_id,first_name,last_name from patients
where patient_id not in (
select patient_id from admissions);      

-- HARD LEVEL QUESTIONS

-- H1. Show max_visits, min_visits, average_visits per day across admissions. Round avg to 2 decimals.
select max(total_visit) as max_visits,min(total_visit) as min_visits,
round(avg(total_visit),2) as average_visits
from
(select count(*) as total_visit from admissions
group by admission_date) a;

-- H2. Group patients by weight bucket (e.g., 100–109 → 100 group). Show total per group, ordered descending.
select count(*) as patient_in_group, round((weight/10)*10,0) as weight_group 
from patients 
group by weight_group 
order by weight_group desc;

-- H3. Show patient_id, weight, height, and isObese (Obese is defined as weight(kg)/(height(m)2) >= 30.
-- weight is in units kg.
-- height is in units cm.)
SELECT 
    patient_id,
    weight,
    height,
    CASE
        WHEN weight / POWER(height / 100.0, 2) >= 30 THEN 1
        ELSE 0
    END AS isObese
FROM
    patients;

-- H4. Show patient_id, full name, and attending doctor's specialty for patients diagnosed with 'Dementia' .
select p.patient_id,p.first_name,p.last_name,d.specialty 
from patients p 
join admissions a on p.patient_id = a.patient_id
join doctors d on a.attending_doctor_id = d.doctor_id
where a.diagnosis = 'Cancer';

-- H5. Show patient_id and a temp_password in format:
-- → patient_id + length_of_last_name + birth_year
-- (e.g., 542 + 5 + 1999 → 54251999)
select distinct p.patient_id, concat(p.patient_id,length(p.last_name),year(birth_date)) as temp_password 
from patients p
join admissions a on p.patient_id = a.patient_id;

-- H6. Calculate total cost of admissions for patients with/without insurance:
-- Even patient_id = insurance = $10
-- Odd = no insurance = $50
select 
case when patient_id%2 = 0 then 'Yes' else 'No' end as has_insurance,
sum(case when patient_id %2=0 then 10 else 50 end) as cost_after_insurance
from admissions 
group by has_insurance;

-- H7. Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.
select 
concat(Round(
100.0*count(case when gender='M' then 1 end)/count(*) ,2),'%'
) as male_per from patients;

-- H8. For each admission_date, show total admissions and difference vs previous date.
select admission_date, count(admission_date) as total_admission ,
count(admission_date) - lag(count(admission_date)) over (order by admission_date) as admission_count_change
from admissions
group by admission_date;

-- H9. Show province names sorted ascending, but always keep 'Ontario' at the top.
select province_name 
from province_names
order by (province_name='Ontario') desc, province_name;

-- H10. Show for each doctor:
-- doctor_id, full name, specialty, year, and total admissions for that year. 
select d.doctor_id, concat(first_name,' ',last_name) as doctor_name,specialty,
year(admission_date) as selected_year, count(*) as total_admission
from doctors d
left join admissions a on d.doctor_id = a.attending_doctor_id
group by doctor_id, selected_year;
