/* PostgreSQL used */

/* Skills used: Joins, Subqueries/CTEs, Windows Functions, Aggregate Functions, String Functions, Unions, Creating Views, Cases, Adding Data, Updating Data, 
Cleaning/Transforming/Reformatting Data */

/* The following datasets were used:
https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Vehicles/bm4k-52h4
https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Crashes/h9gi-nx95
https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Person/f55k-p6yu
*/

--Create Table for Crash Data
Create Table Crash_Data 
(
Crash_Date varchar(10),
Crash_Time varchar(5),
Borough varchar,
Zip_Code varchar(5),
Latitude double precision,
Longitude double precision,
Location varchar,
On_Street_Name varchar,
Cross_Street_Name varchar,
Off_Street_Name varchar,
Number_Of_Persons_Injured integer,
Number_Of_Persons_Killed integer,
Number_Of_Pedestrians_Injured integer,
Number_Of_Pedesterians_Killed integer,
Number_Of_Cyclist_Injured integer,
Number_Of_Cyclist_Killed integer,
Number_Of_Motorist_Injured integer,
Number_Of_Motorist_Killed integer,
Contributing_Factor_Vehicle_1 varchar,
Contributing_Factor_Vehicle_2 varchar,
Contributing_Factor_Vehicle_3 varchar,
Contributing_Factor_Vehicle_4 varchar,
Contributing_Factor_Vehicle_5 varchar,
Collision_ID integer,
Vehicle_Type_Code_1 varchar,
Vehicle_Type_Code_2 varchar,
Vehicle_Type_Code_3 varchar,
Vehicle_Type_Code_4 varchar,
Vehicle_Type_Code_5 varchar
);

--Import Crash Data
COPY Crash_Data
FROM 'C:\Users\Darian\Downloads\Motor_Vehicle_Collisions_-_Crashes.csv'
WITH (FORMAT CSV, HEADER);

--Create Vehicle Table
Create table vehicle_data 
(
Unique_ID integer,
Collision_ID integer,
Crash_Date varchar(10),
Crash_Time varchar(5),
Vehicle_ID varchar,
State_Registration varchar(2),
Vehicle_Type varchar,
Vehicle_Make varchar,
Vehicle_Model varchar,
Vehicle_Year int,
Travel_Direction varchar,
Vehicle_Occupants integer,
Driver_Sex varchar(1),
Driver_License_Status varchar,
Driver_License_Jurisdiction varchar,
Pre_Crash varchar,
Point_Of_Impact varchar,
Vehicle_Damage varchar,
Vehicle_Damage_1 varchar,
Vehicle_Damage_2 varchar,
Vehicle_Damage_3 varchar,
Public_Property_Damage varchar,
Public_Property_Damage_Type varchar,
Contributing_Factor_1 varchar,
Contributing_Factor_2 varchar
);

--Import Vehicle Data
COPY Vehicle_Data
FROM 'C:\Users\Darian\Downloads\Motor_Vehicle_Collisions_-_Vehicles.csv'
WITH (FORMAT CSV, HEADER);

-- Create Person Table
create table Person_Data
(
Unique_ID integer,
Collision_ID integer,
Crash_Date varchar(10),
Crash_Time varchar(5),
Person_ID varchar,
Person_Type varchar,
Person_Injury varchar,
Vehicle_ID integer,
Person_Age integer,
Ejection varchar,
Emotional_Status varchar,
Bodily_Injury varchar,
Position_In_Vehicle varchar,
Safety_Equipment varchar,
Ped_Location varchar,
Ped_Action varchar,
Complaint varchar,
Ped_Role varchar,
Contributing_Factor_1 varchar,
Contributing_Factor_2 varchar,
Person_Sex varchar(1)
);

--Import Person Data
COPY Person_Data
FROM 'C:\Users\Darian\Downloads\Motor_Vehicle_Collisions_-_Person.csv'
WITH (FORMAT CSV, HEADER);

/*Create a timestamp using the crash_date and crash_time columns*/
SELECT crash_date, crash_time, (RIGHT(crash_date,4) || '-' || LEFT(crash_date, 2) ||
        '-' || SUBSTR(crash_date, 4, 2) || ' ' || crash_time || ':00')::timestamp AS timestamp
from crash_data;

/* Add a Timestamp column with a proper timestamp for each crash*/
ALTER TABLE crash_data
ADD Timestamp timestamp
;
update crash_data 
set Timestamp = (RIGHT(crash_date,4) || '-' || LEFT(crash_date, 2) ||
        '-' || SUBSTR(crash_date, 4, 2) || ' ' || crash_time || ':00')::timestamp;

--Show all columns from crash table
select * from crash_data;

/*add a separate column that gives the year for each crash */
Alter Table crash_data
add Year integer;
update crash_data
set Year = EXTRACT('Year' FROM timestamp);
alter table vehicle_data
add Year int;
update vehicle_data
set year = right(crash_date, 4)::int;
alter table person_data
add Year int;
update person_data
set year = right(crash_date, 4)::int;
   
/*Reformat Excel Date format (mm/dd/yyyy) to SQL date format (yyyy-mm-dd)*/
select crash_date,
right(crash_date, 4) || '-' || left(crash_date, 2) || '-' || substr(crash_date,4,2) as crash_date_reformatted
from crash_data;

/*Update the date column to be in SQL date format and type (yyyy-mm-dd)*/
Update crash_data
Set crash_date = right(crash_date, 4) || '-' || left(crash_date, 2) || '-' || substr(crash_date,4,2);
alter table crash_data
alter column crash_date type date using crash_date::date;

/*Reformat Borough, On_Street_Name, Off_Street_Name, Cross_Street_Name Columns so that first letter is capitalized and the rest of the letters are in lowercase*/
select borough, initcap(borough), on_street_name, initcap(on_street_name), 
cross_street_name, initcap(cross_street_name), off_street_name, initcap(off_street_name) from crash_data;

/*Update the above columns with the reformatted columns above*/
Update crash_data
Set borough = initcap(borough),
On_street_name = initcap(on_street_name),
Cross_street_name = initcap(cross_street_name),
Off_street_name = initcap(off_street_name);

/* find the total number of fatalities and total number of people injured */
select sum(number_of_persons_killed) as Total_Fatalities, sum(number_of_persons_injured) as Total_Amount_Injured
from crash_data;

/* find the total number of fatalities and total number of people injured by borough and order by total fatalities descending*/
select borough, sum(number_of_persons_killed) as Total_Fatalities, 
sum(number_of_persons_injured) as Total_Amount_Injured
from crash_data
where borough IS NOT NULL
group by borough
order by 2 desc
;

--Find all of the unique values within the contributing_factor_vehicle columns.
Select contributing_factor_vehicle_1
from crash_data
UNION
Select contributing_factor_vehicle_2
from crash_data
UNION
Select contributing_factor_vehicle_3
from crash_data
UNION
Select contributing_factor_vehicle_4
from crash_data
UNION
Select contributing_factor_vehicle_5
from crash_data;

/*Clean the contributing_factor columns so that spelling errors and capitalization issues are addressed.*/
update crash_data
set contributing_factor_vehicle_1 = 'Drugs (Illegal)'
where contributing_factor_vehicle_1 = 'Drugs (illegal)';
update crash_data
set contributing_factor_vehicle_1 = 'Illness'
where contributing_factor_vehicle_1 = 'Illnes';
update crash_data
set contributing_factor_vehicle_1 = 'Cell Phone (hand-held)'
where contributing_factor_vehicle_1 = 'Cell Phone (hand-Held)';
update crash_data
set contributing_factor_vehicle_2 = 'Drugs (Illegal)'
where contributing_factor_vehicle_2 = 'Drugs (illegal)';
update crash_data
set contributing_factor_vehicle_2 = 'Illness'
where contributing_factor_vehicle_2 = 'Illnes';
update crash_data
set contributing_factor_vehicle_2 = 'Cell Phone (hand-held)'
where contributing_factor_vehicle_2 = 'Cell Phone (hand-Held)';
update crash_data
set contributing_factor_vehicle_3 = 'Drugs (Illegal)'
where contributing_factor_vehicle_3 = 'Drugs (illegal)';
update crash_data
set contributing_factor_vehicle_3 = 'Illness'
where contributing_factor_vehicle_3 = 'Illnes';
update crash_data
set contributing_factor_vehicle_3 = 'Cell Phone (hand-held)'
where contributing_factor_vehicle_3 = 'Cell Phone (hand-Held)';
update crash_data
set contributing_factor_vehicle_4 = 'Drugs (Illegal)'
where contributing_factor_vehicle_4 = 'Drugs (illegal)';
update crash_data
set contributing_factor_vehicle_4 = 'Illness'
where contributing_factor_vehicle_4 = 'Illnes';
update crash_data
set contributing_factor_vehicle_4 = 'Cell Phone (hand-held)'
where contributing_factor_vehicle_4 = 'Cell Phone (hand-Held)';
update crash_data
set contributing_factor_vehicle_5 = 'Drugs (Illegal)'
where contributing_factor_vehicle_5 = 'Drugs (illegal)';
update crash_data
set contributing_factor_vehicle_5 = 'Illness'
where contributing_factor_vehicle_5 = 'Illnes';
update crash_data
set contributing_factor_vehicle_5 = 'Cell Phone (hand-held)'
where contributing_factor_vehicle_5 = 'Cell Phone (hand-Held)';

/* combine all of the contributing_factor columns and values into one column*/ 
select contributing_factor_vehicle_1 as contributing_factor from crash_data
UNION ALL
select contributing_factor_vehicle_2 from crash_data
UNION ALL
select contributing_factor_vehicle_3 from crash_data
UNION ALL
select contributing_factor_vehicle_4 from crash_data
UNION ALL
select contributing_factor_vehicle_5 from crash_data;

/* give a count of each contributing_factor and put them in descending order (exclude null values) */
select contributing_factor, count(contributing_factor) as total_count
from (select contributing_factor_vehicle_1 as contributing_factor from crash_data
UNION ALL
select contributing_factor_vehicle_2 from crash_data
UNION ALL
select contributing_factor_vehicle_3 from crash_data
UNION ALL
select contributing_factor_vehicle_4 from crash_data
UNION ALL
select contributing_factor_vehicle_5 from crash_data) as vehicle_contributing_factor
where contributing_factor IS NOT NULL
group by contributing_factor
order by 2 desc;

/* give a count of each contributing_factor by borough and put it in descending order by count (exclude null values) */
select borough, contributing_factor, count(contributing_factor) as total_count from (
select borough, contributing_factor_vehicle_1 as contributing_factor from crash_data
UNION ALL
select borough, contributing_factor_vehicle_2 from crash_data
UNION ALL
select borough, contributing_factor_vehicle_3 from crash_data
UNION ALL
select borough, contributing_factor_vehicle_4 from crash_data
UNION ALL
select borough, contributing_factor_vehicle_5 from crash_data
) as sub
where contributing_factor is not null and borough is not null
group by borough, contributing_factor
order by 3 desc
;

/* give a count of each contributing_factor by borough and put it in descending order by count (exclude null values). But use a CTE this time.*/
with CTE as (
select borough, contributing_factor_vehicle_1 as contributing_factor from crash_data
UNION ALL
select borough, contributing_factor_vehicle_2 from crash_data
UNION ALL
select borough, contributing_factor_vehicle_3 from crash_data
UNION ALL
select borough, contributing_factor_vehicle_4 from crash_data
UNION ALL
select borough, contributing_factor_vehicle_5 from crash_data
)
select borough, contributing_factor, count(contributing_factor) as total_count 
from CTE
where contributing_factor is not null and borough is not null
group by borough, contributing_factor
order by 3 desc
;

/* Show the number of injuries and fatalities by borough and driver sex (include M and F only)*/
select borough, driver_sex, count(number_of_persons_injured) as injury_count, count(number_of_persons_killed) as fatality_count
from crash_Data as crash
join vehicle_data as vehicle
on crash.collision_id = vehicle.collision_id
Where borough IS NOT NULL AND Driver_Sex is NOT NULL AND Driver_Sex != 'U'
group by borough, driver_sex
order by 1, 2 desc
;

/* give a total count of each contributing_factor within each borough and order them by borough (asc) and then by total count (desc) */
select borough, contributing_factor, count(contributing_factor) as total_count
from (select borough, contributing_factor_vehicle_1 as contributing_factor from crash_data
UNION ALL
select borough, contributing_factor_vehicle_2 from crash_data
UNION ALL
select borough, contributing_factor_vehicle_3 from crash_data
UNION ALL
select borough, contributing_factor_vehicle_4 from crash_data
UNION ALL
select borough, contributing_factor_vehicle_5 from crash_data) as vehicle_contributing_factor
where borough IS NOT NULL
group by borough, contributing_factor
order by 1, 3 desc
;

/* Put the above query in a view*/
CREATE VIEW Borough_Factor_View AS 
select borough, contributing_factor, count(contributing_factor) as total_count
from (select borough, contributing_factor_vehicle_1 as contributing_factor from crash_data
UNION ALL
select borough, contributing_factor_vehicle_2 from crash_data
UNION ALL
select borough, contributing_factor_vehicle_3 from crash_data
UNION ALL
select borough, contributing_factor_vehicle_4 from crash_data
UNION ALL
select borough, contributing_factor_vehicle_5 from crash_data) as vehicle_contributing_factor
where borough IS NOT NULL
group by borough, contributing_factor
order by 1, 3 desc;

/* Show the top 3 contributing factors for each borough. Don’t include null values and Unspecified*/
select * from(
select *, rank() over (partition by borough order by total_count desc) as rank 
from (
select borough, contributing_factor, count(contributing_factor) as total_count from (
select borough, contributing_factor_vehicle_1 as contributing_factor from crash_data
UNION ALL
select borough, contributing_factor_vehicle_2 from crash_data
UNION ALL
select borough, contributing_factor_vehicle_3 from crash_data
UNION ALL
select borough, contributing_factor_vehicle_4 from crash_data
UNION ALL
select borough, contributing_factor_vehicle_5 from crash_data
) as sub
where contributing_factor is not null and borough is not null and contributing_factor != 'Unspecified'
group by borough, contributing_factor
order by 3 desc
) as sub2 
) as sub3
where rank <=3
;

/*Use the view created earlier to simplify the query above*/
select * 
from(
select *, rank() over borough_window as rank
from borough_factor_view
window borough_window as (partition by borough order by total_count desc)
) as sub
where rank <=3
;

/* Make age ranges for the drivers in motor vehicles involved in crashes and make a count 
for the number of drivers that fall within each range */
select count(*) as total_count, CASE WHEN person_age BETWEEN 0 and 20 then 'Age 0-20'
WHEN person_age BETWEEN 21 and 40 then 'Age 21-40'
WHEN person_age between 41 and 60 then 'Age 41-60'
WHEN person_age between 61 and 80 then 'Age 61-80'
When person_age between 81 and 100 then 'Age 81-100'
ELSE 'Out Of Ranges' END as Age_Range
from person_data
where ped_role = 'Driver' and person_age is not null
group by 2
;

/* show the total number of injuries, fatalities, and crashes by month */
select to_char(timestamp, 'Month') as month, extract('month' from timestamp) as month_number, 
sum(number_of_persons_injured) as total_injury_count, 
sum(number_of_persons_killed) as total_fatality_count, count(collision_id) as total_crashes
from crash_data
group by 1, 2
order by 2;

/*Do the above without the helper column month_number*/
select to_char(timestamp, 'Month') as month, 
sum(number_of_persons_injured) as total_injury_count, 
sum(number_of_persons_killed) as total_fatality_count, count(collision_id) as total_crashes
from crash_data
group by 1
order by to_date(to_char(timestamp,'Month'),'Month');


/* show the total number of injuries, fatalities, and crashes by year */
select year, 
sum(number_of_persons_injured) as total_injury_count, 
sum(number_of_persons_killed) as total_fatality_count, count(collision_id) as total_crashes
from crash_data
group by 1
order by 1;

/*Show the top 3 reasons for a crash by month, don’t include nulls and unspecified values*/
Create View combined_factors as 
select *, contributing_factor_vehicle_1 as contributing_factor, vehicle_type_code_1 as vehicle_type from crash_data
UNION ALL
select *, contributing_factor_vehicle_2, vehicle_type_code_2 from crash_data
UNION ALL
select *, contributing_factor_vehicle_3, vehicle_type_code_3 from crash_data
UNION ALL
select *, contributing_factor_vehicle_4, vehicle_type_code_4 from crash_data
UNION ALL
select *, contributing_factor_vehicle_5, vehicle_type_code_5 from crash_data;

select * from
(select *, rank() over (partition by month order by total_crashes desc) as rank from(
select to_char(timestamp, 'Month') as month, contributing_factor, count(DISTINCT collision_id) as total_crashes
from combined_factors
where contributing_factor is not null and contributing_factor != 'Unspecified'
group by 1,2
order by to_date(to_char(timestamp,'Month'),'Month'), total_crashes desc
) as sub
order by to_date(month,'Month'), rank) as sub2
where rank <=3
;

Create View combined_factors as 
select borough, year, collision_id, contributing_factor_vehicle_1 as contributing_factor, vehicle_type_code_1 as vehicle_type from crash_data
UNION ALL
select borough, year, collision_id, contributing_factor_vehicle_2, vehicle_type_code_2 from crash_data
UNION ALL
select borough, year, collision_id, contributing_factor_vehicle_3, vehicle_type_code_3 from crash_data
UNION ALL
select borough, year, collision_id, contributing_factor_vehicle_4, vehicle_type_code_4 from crash_data
UNION ALL
select borough, year, collision_id, contributing_factor_vehicle_5, vehicle_type_code_5 from crash_data;

/* Show number of crashes by driver sex (include male and female only) */
Select driver_sex, count(unique_id) as total_crashes from vehicle_data
where driver_sex != 'U' AND driver_sex is not null
Group by 1;

/* Show number of crashes by driver sex and year (include male and female only)*/
Select driver_sex, year, count(unique_id) as total_crashes from vehicle_data
where driver_sex != 'U' AND driver_sex is not null
Group by 1, 2;

/* Add a Month column that gives the month that each crash occurred*/
ALTER TABLE crash_data
ADD Month varchar,
ADD Month_Number int
;

update crash_data 
set Month = to_char(timestamp, 'Mon'),
Month_number = extract('month' from timestamp) 
;

/* Show a count of the type of injuries in desc order, don’t include 'Does Not Apply' or 'Unknown' or NULLS*/
select bodily_injury, count(bodily_injury) as count 
from person_data
where bodily_injury != 'Does Not Apply' AND bodily_injury != 'Unknown' AND bodily_injury IS NOT NULL
group by 1 
order by 2 desc;

/* Give a Count of the Number of Vehicles In a Crash */
select number_of_vehicles_in_crash, count(number_of_vehicles_in_crash) as count 
from (
select collision_id, count(vehicle_type) as number_of_vehicles_in_crash
from combined_factors
where vehicle_type is not null
group by collision_id) as sub
group by number_of_vehicles_in_crash;

/* Create a view to simplify the above */
Create View Number_Of_Vehicles_Involved as 
select collision_id, count(vehicle_type) as number_of_vehicles_in_crash
from combined_factors
where vehicle_type is not null
group by collision_id;
select number_of_vehicles_in_crash, count(number_of_vehicles_in_crash) as count 
from number_of_vehicles_involved
group by number_of_vehicles_in_crash;

/* Show number of crashes, injuries, and fatalities by the day of the week */
select extract('dow' from timestamp) as day_of_week, 
sum(number_of_persons_injured) as total_injury_count, 
sum(number_of_persons_killed) as total_fatality_count, count(collision_id) as total_crashes
from crash_data
group by 1
order by 1;

/* Show number of crashes, injuries, and fatalities by the day of the week using the day names*/
select to_char(timestamp, 'Dy') as day_of_week, 
sum(number_of_persons_injured) as total_injury_count, 
sum(number_of_persons_killed) as total_fatality_count, count(collision_id) as total_crashes
from crash_data
group by 1;

/* Add a column to crash_data that gives the day of the week the crash occurred */
alter table crash_data
add day_of_week VARCHAR;
update crash_data
set day_of_week = to_char(timestamp, 'Dy');

/* Show number of crashes by time (morning, afternoon, night) */
ALTER TABLE crash_data
ADD hour_of_crash int
;

update crash_data 
set hour_of_crash = EXTRACT('hour' FROM timestamp);
ALTER TABLE crash_data
ADD Time_of_day varchar;

update crash_data 
set time_of_day = case when hour_of_crash between 0 and 11 then 'Morning (12 AM to 11:59 AM)' 
when hour_of_crash between 12 and 17 then 'Afternoon (12 PM to 5:59 PM)' 
else 'Evening (6 PM to 11:59 PM)' end
;

select time_of_day, count(time_of_day) from crash_data
group by 1;


