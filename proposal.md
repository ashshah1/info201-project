# Skyfall

## Impacts of Weather on Crime

### Team Members:
* Allessandra Quevedo (allymdq@uw.edu)
* Bradley Wilson (bradlw12@uw.edu)
* Ash Shah (ashni@uw.edu)

Info-201: Technical Foundations of Informatics  
The Information School  
University of Washington  
Autumn 2019

### 1.0 Introduction

#### 1.1 Problem Situation

We want to analyze the frequency of crime in big cities, as it relates to weather patterns at the time. Seattle has a high crime rate and as residents of the city, it is important that we understand its patterns. This kind of data can also be helpful to law enforcement officials and others to predict crime rate fluctuations. Crime is directly correlated to safety and we need to understand one to ensure the other.

#### 1.2 What is the Problem

We will explore the weather patterns of major cities in the United States and the crime rates that occur within those cities. As a society we always want crime rates to fall within our city. Therefore, we want to analyze contributions to the rise and fall of crime rates. Our question is: Does weather affect the amount of crime that happens in a city?


#### 1.3 What does it matter?

Crime rate is not a constant, straight line. Just like most phenomena, crime fluctuates. One day may break record highs, the next may break record lows. Therefore, in an effort to minimize crime, one must understand the factors behind its rise and fall. Toning in on weather patterns and its effect on crime rate will provide more understanding behind crime deterrences. The more crime deterrences are understood, the more we can do to prevent crime from happening.

#### 1.4 How will it be addressed?

We intend to study crime patterns in Seattle and see if there is a correlation between crime statistics and weather patterns. Both crime and weather are broad, umbrella terms encompassing a large array of items, we want to narrow down on these and focus on specific crimes and their frequencies in harsher weather conditions, such as storms and heavy snowfall, as opposed to their rates during other seasons.

### 2.0 Research Questions

* What type of weather, if any, deters crime from happening?  
* Are certain types of crimes more likely to occur in particular weather patterns?


### 3.0 Possible Data Sets

* The first data set that we will be using to study this is from the NOAA that outlines precipitation, temperature, snowfall, and other weather conditions over a period of one year in Seattle. 15 attributes, thousands of observations. [Dataset](datasets/Weather_Data.csv)
* The second data set that we will be using is from the Seattle Police Department (published on the City of Seattle’s data portal) that documents the crimes reported within the city. We will use the data collected over one year. 11 attributes, thousands of observations. [Dataset](https://data.seattle.gov/Public-Safety/Crime-Data/4fs7-3vj5)

### 4.0 Information Visualizations

https://scx2.b-cdn.net/gfx/news/2018/2-violentcrime.jpg (Source: Harp) [1]

Figure 1: Typical two-dimensional graph with two lines. One represents the crime rate over time, the other represents the weather for that particular day measured in temperature, precipitation, etc.

https://ggwash.org/images/posts/200806-seattlewalkscore.png (Source: GGWASH) [2]

Figure 2: Heat maps of Seattle demonstrating the crime rate on a particular day with a particular weather pattern. The heat map changes as new weather types are selected.


### 5.0 Team Coordination

* Weekly Meeting Time : Tuesdays at 12 p.m.
* Individual Goals
  * Bradley: Developing skills in R data manipulation, visualizing data, and communicating the problem. Role will change depending on the task at hand.
  * Allessandra: Explore the impact of data visualizations on real world problems.
  * Ash: To learn how to apply and interact with datasets to solve real world problems. We plan on dividing roles on a much smaller scale as we move through the problem, so we'll each do a little of everything.
* We intend communicate over Microsoft Teams. We do also have a group chat on top of our weekly meetings.
* If we do hit a roadblock with communication and work division, we plan to talk through it calmly since we all, at the end of the day, have the same end goal in mind.


### 6.0 Questions

--

### 7.0 References

[1] Ryan D. Harp et al, The Influence of Interannual Climate Variability on Regional Violent Crime Rates in the United States, GeoHealth (2018). https://phys.org/news/2018-11-violent-crime-warmer-winters.html.

[2] Alpert, David. “WalkScore Heat Maps.” Greater Greater Washington, 13 June 2008, https://ggwash.org/view/498/walkscore-heat-maps.

Crime Reports in Seattle per day - [Dataset](https://data.seattle.gov/Public-Safety/Crime-Data/4fs7-3vj5)

Weather Statistics per day at a certain location tags in the Seattle Area - [Dataset](datasets/Weather_Data.csv)
