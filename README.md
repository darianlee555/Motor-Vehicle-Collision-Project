# NYC Motor Vehicle Collisions Analysis and Dashboard

### Project Overview

![head-on-collision (1)](https://github.com/darianlee555/Portfolio-Projects/assets/145151765/df3a5688-d1b2-4640-b683-49a8bd0e000d)

This is an **SQL** and **Power BI** project analyzing **NYC Motor Vehicle Collision Datasets** sourced from NYPD accident reports. The purpose of this project is to address critical questions related to traffic safety in NYC by providing insights and, ultimately, enhancing traffic safety through data-backed recommendations for the city to prevent potential future collisions.

### Data Sources

**Vehicle Dataset**: https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Vehicles/bm4k-52h4

**Crash Dataset**: https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Crashes/h9gi-nx95

**Person Dataset**: https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Person/f55k-p6yu

The **Vehicle Dataset** contains details on each vehicle involved in the crash.

The **Crash Dataset** contains details on the crash event.

The **Person Dataset** contains details for people involved in the crash.

For additional details and a description of each column in the datasets, please refer to the data source links above.

The **Vehicle and Person Datasets** are **fact tables** connected to the **Crash Dataset (the dimension table)**. The fact tables are connected to the dimension table via a **Galaxy Schema Data Model** through the common column: **'collision_id'** with **many-to-one relationships (*:1)** 

![data model](https://github.com/darianlee555/Portfolio-Projects/assets/145151765/e54e4ea7-c691-4d88-bbd9-52638aa9a712)

### Objectives

I aim to answer the following questions using the datasets:

1. What was the most common reason for a crash?
2. What ages were most likely to get into car crashes?
3. What Borough of New York had the most injuries and fatalies?
4. What month generally had the most crashes?
5. Who is more likely to get into an accident, males or females?
6. What was the most common injury?
7. What type of crash (single vehicle crash, double vehicle crash, triple vehicle crash, etc.) was most common?
8. For crashes that were fatalities, where was the location in the borough they occured?
9. What day and what timeframe had the most accidents?
10. What were the total number of crashes, injuries, and fatalities?

### Tools Used

**PostgreSQL** for Data Exploration, Cleaning, and Analysis

**Power BI** for Visualizations

### Skills/Concepts Demonstrated

The following **SQL** skills were used: Joins, Subqueries/CTEs, Windows Functions, Aggregate Functions, String Functions, Unions, Creating Views, Cases, Adding Data, Updating Data, Cleaning/Transforming/Reformatting Data.

If interested here is the code: https://github.com/darianlee555/Portfolio-Projects/blob/main/SQL%20Motor%20Vehicle%20Crashes%20Code.sql

The following **Power BI** features were incorporated: DAX, Measures, Page Navigation/Buttons, Data Modeling/Relationships, Filters.

### Data Visualization/Dashboard


![Screenshot (18)](https://github.com/darianlee555/Portfolio-Projects/assets/145151765/8381b284-ebda-4cf9-8d33-370d13ba8cf8)

![Screenshot (19)](https://github.com/darianlee555/Portfolio-Projects/assets/145151765/257386b4-4b9e-4a12-834e-9e1a69e44b47)

### Features:
- "More Info" and "Previous Info" are navigational buttons that allow the user to navigate easily through the two pages of the dashboard.
- The filters "Borough" and "Year" allow users to filter through the data to see data associated with a certain year and/or borough.
- The "Key Insights" from analyzing the data are put on the left-hand side to make them more obvious to users.
- A zoomable heat map is included with locations of fatalities for each borough so that the info about those particular collisions can be investigated further. 

### Analysis/Results/Insights
Here is the code used to obtain the following results/insights: https://github.com/darianlee555/Portfolio-Projects/blob/main/SQL%20Motor%20Vehicle%20Crashes%20Code.sql
- Driver Inattention/Distracted Driving was the most likely reason for a crash.
- People aged 21 to 40 were most likely to get into car crashes.
- Brooklyn has the most injuries and fatalies of any borough.
- July has the most crashes of any month.
- Males are more likely to get into a crash then females.
- Back injuries were the most common injury in a crash.
- Crashes involving two vehicles (double vehicle crash) were the most common type of crash with 1,502,012 total collisions.
- Friday has the most accidents of any day.
- Most accidents occur in the afternoon.
- The number of total crashes is 2,016,265.
- The number of total injuries is 609,150.
- The number of total fatalities is 2,913.

### Recommendations/Conclusions
Based on the data, in order to prevent future vehicle collisions in NYC, I would encourage more advertisements about the dangers of distracted driving. These ads should target the demographic of males aged 21 to 40, as they tend to be involved in the most accidents. Additionally, it's advisable to increase advertising efforts in Brooklyn specifically, as well as deploy more traffic directors or officers in Brooklyn, given that it is the most dangerous borough with the highest number of injuries and fatalities.

Furthermore, I recommend deploying more officers to patrol traffic in all boroughs on Friday afternoons, as this is the most likely timeframe for accidents to occur. While July has the highest number of crashes, it's worth noting that there is a clear increase in accidents after April, as shown in the line chart. Therefore, I would focus on increasing traffic safety measures from May onwards, as January through April generally have fewer crashes compared to other months.

By implementing any/all of these steps, it is possible that NYC can reduce the number of future collisions.

### More Screenshots showing Interactivity/Filters/Navigation
![](Media3.gif)
![](Media4.gif)
![Media5 (4)](https://github.com/darianlee555/Portfolio-Projects/assets/145151765/c724bed6-9265-4e71-9f03-65f8764e4f46)
