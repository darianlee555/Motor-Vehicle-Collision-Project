# NYC Motor Vehicle Collisions Analysis and Dashboard

### Project Overview

![backasda](https://github.com/darianlee555/Portfolio-Projects/assets/145151765/2589553d-bc28-4033-8c40-f5a18bc48db3)

This is an **SQL** and **Power BI** project analysing **NYC Motor Vehicle Collision datasets** made from NYPD accident reports. The point of this project is to answer crucial questions with regards to traffic safety in NYC by providing insights and hopefully improving traffic safety by recommending data-backed course of actions for NYC to prevent possible future collisions.

### Data Sources

**Vehicle Dataset**: https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Vehicles/bm4k-52h4

**Crash Dataset**: https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Crashes/h9gi-nx95

**Person Dataset**: https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Person/f55k-p6yu

The **Vehicle Dataset** contains details on each vehicle involved in the crash.

The **Crash Dataset** contains details on the crash event.

The **Person Dataset** contains details for people involved in the crash.

The **Vehicle and Person Datasets** are **fact tables** connected to the **Crash Dataset (the dimension table)**. The fact tables are connected to the dimension table via a **Star Schema Data Model** through the common column: **'collision_id'** with **many-to-one relationships (*:1)** 

![data model](https://github.com/darianlee555/Portfolio-Projects/assets/145151765/e54e4ea7-c691-4d88-bbd9-52638aa9a712)

### Objectives

I wanted to answer the following questions using the data. I picked these specific questions as they might be realistic questions that people might ask about the data:

* What was the most common reason for a crash?
* What ages were most likely to get into car crashes?
* What Borough of New York had the most injuries and fatalies?
* What month generally had the most crashes?
* Who is more likely to get into an accident, males or females?
* What was the most common injury?
* What type of crash (single vehicle crash, double vehicle crash, triple vehicle crash, etc.) was most common? 
* For crashes that were fatalities, where was the location in the borough they occured?
* What day and what timeframe had the most accidents?
* What were the total number of crashes, injuries, and fatalities?

### Tools Used

**PostgreSQL** for Data Exploration, Cleaning, and Analysis

**Power BI** for Visualizations

### Skills/Concepts Demonstrated

The following **SQL** skills were used: Joins, Subqueries/CTEs, Windows Functions, Aggregate Functions, Unions, Creating Views, Cases, Adding Data, Updating Data, 
Cleaning/Transforming/Reformatting Data.

If interested here is the code: https://github.com/darianlee555/Portfolio-Projects/blob/main/SQL%20Motor%20Vehicle%20Crashes%20Code.sql

The following **Power BI** features were incorporated: DAX, Measures, Page Navigation/Buttons, Data Modelling/Relationships, Filters.

### Data Visualization/Dashboard

![lets go](https://github.com/darianlee555/Portfolio-Projects/assets/145151765/53dd69c0-d5dc-480b-b41c-4376876dfc61)
![page 2](https://github.com/darianlee555/Portfolio-Projects/assets/145151765/1c9e556d-37b1-4a49-8233-0dc92720788d)

### Features:
- "More Info" and "Previous Info" are navigational buttons that allow the user to navigate easily through the two pages of the dashboard.
- The filters "Borough" and "Year" allow users to filter through the data to see data associated with a certain year and/or borough.
- The "Key Insights" from analyzing the data are put on the left-hand side to make them more obvious to users.
- A zoomable map is included with locations of fatalities for each borough so that the info about those particular collisions can be investigated further. 

### Analysis
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

### Recommendations
Based on the data, in order to prevent future vehicle collisions in NYC, I would encourage more advertisements about the dangers of distracted driving. I would have these ads target the demographic of males that are aged 21 to 40 as they tend to get into the most accidents. I would encourage more ads in Brooklyn specifically, as well as have more traffic directors or officers in Brooklyn since Brooklyn is the most dangerous borough with the most injuries and fatalies. I would also have more officers patrol traffic in all boroughs on Friday afternoons since that's the most likely timeframe that an accident will occur. Also, even though July is the month with the most crashes, it's clear that after April, there is a clear increase in the number of crashes as seen in the line chart graph. Therefore, I would focus more on increasing traffic safety measures from May onwards, as January through April have a somewhat low amount of crashes in comparison to other months. If all/any of these steps are taken, perhaps they will reduce the amount of future collisions NYC has. 
