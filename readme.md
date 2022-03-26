# Data Preparation & Workflow Management

# Research 

# Motivation
The main objective of this study is to analyze the impact of the Amsterdam Dance event, which is a yearly music festival active from 13th to 17th of October. A vast amount of domestic and international travelers come to the city to enjoy this event. Staying in an Airbnb is a viable option for guests who don't live in or nearby the city. The purpose of the study is to investigate whether an event such as Amsterdam Dance Event has an effect on the number of reviews written by guests. The Amsterdam Dance Event, hereafter also referred to as 'ADE', could increase guests' motivation for leaving a review. When the proposed phenomenon can be confirmed, the research could be replicated with the use of other events to further investigate this correlation. Another possible effect of an event such as ADE could be the increase of prices because of ADE (or other events) taking place in a city. For a detailed overview of the analyses, please proceed to the Analysis description below. 

# Data preparation
After downloading the files with regards to the Airbnb data of Amsterdam, the data was cleaned and ordered in order to be able to perform analyses. For example, all seasonal listings, which were different datasets, were combined in one data set. Furthermore, all relevant variables were selected for the purpose of creating a relevant data frame. The data was cleaned from any dollar signs, commas and other irrelevant signs. These types of steps were executed for the listings and review data as well as a combination of those two. Moreover, dummy variables were created for neighborhoods, seasons and room type. Different data sets were created for the purpose of being able to conduct the desired analyses. Herewith, a dataset including the data of the review per listing per day was created. Among others, a set per neighborhood was created for Amsterdam Dance Event as well as year round, subsets where the data of ADE is excluded and an overview of the distribution of reviews per year (2018-2021). For a detailed overview of the explored, cleaned and prepared data, please refer to the RMarkdown script. 

# Analysis description
**Two analyses are planned for this project**

**#analysis 1**
**Check the correlation between ADE and the amount of reviews left by guests**

The amount of reviews can be retrieved from the dataset. An event such as ADE might boost the motivation to leave a review, which can be further investigated. 
The yearly amount of reviews can be extracted to different neighbourhoods and be related to different time periods.


**#analysis 2**
**Make a price prediction in a linear regression model**

Right now, few prices can be retrieved from the dataset, as the data provider has fetched all the rates for a few dates in the year. Different columms such as the location, room type, and the review amount etc. could have impact on the price. To make a prediction for the prices of rooms throughout the city for next year's event, a regression analysis is run over these variables. 

The reviews can be left by guests of Airbnb up to 2 weeks after the end day of the stay. For this reason, the main time period measured against standardized data has been two weeks after the last date of the event.

