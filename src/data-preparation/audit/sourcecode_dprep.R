# Create a review list for Amsterdam in the year 2021
## Packages and library functions
### Download the right packages for analysis
install.packages("haven")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("tidyverse") 
install.packages("readr")

### Run the installed packages using the library function
library(haven)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(readr)

## Download files
### Download Airbnb listings data for all the seasons of 2021
listings_autumn <- read_csv("http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-12-05/data/listings.csv.gz")
listings_summer <- read_csv("http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-09-07/data/listings.csv.gz") 
listings_spring <- read_csv("http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-06-03/data/listings.csv.gz") 
listings_winter <- read_csv("http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-03-04/data/listings.csv.gz")

### Download Airbnb calendar data calendar <- read_csv("http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-12-05/data/calendar.csv.gz")
### Download Airbnb reviews data
reviews <- read_csv("http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-12-05/data/reviews.csv.gz")

## Prepare the data frame for listings (Amsterdam 2021)
### Add a column for season
listings_autumn$season <- c("autumn")
listings_summer$season <- c("summer")
listings_spring$season <- c("spring")
listings_winter$season <- c("winter")

### Combine all seasonal listings 2021 and bind them together
adam_listings <- rbind(listings_autumn, listings_summer, listings_spring, listings_winter)

### Select the variables that are relevant for the data frame
new_listings_price <- adam_listings %>%
  select(id, neighbourhood_cleansed, room_type, price, season)

#### Remove the dollar sign and commas (for prices above thousand)
new_listings_price$price <- gsub('[$,]', '', new_listings_price$price)

#### Changing price variable from character to numeric
new_listings_price$price <- as.numeric(new_listings_price$price)

## Prepare the data frame for reviews (Amsterdam 2021)
### Select the variables that are relevant for the data frame
reviews_cleaned <- reviews %>% 
  select(listing_id, date, comments)

### Create subsets for reviews for every season of 2021 
reviews_autumn21 <- subset(reviews_cleaned, date> "2021-09-07" & date < "2021-12-05")
reviews_summer21 <- subset(reviews_cleaned, date> "2021-06-03" & date < "2021-09-07")
reviews_spring21 <- subset(reviews_cleaned, date> "2021-03-04" & date < "2021-06-03")
reviews_winter2021 <- subset(reviews_cleaned, date> "2020-12-06" & date < "2021-03-04")

#### Switch to plyr to enable the count function
detach(package:dplyr)
library(plyr)

### Count the number of reviews per season
amount_reviews_aut <- reviews_autumn21 %>% count("listing_id")
amount_reviews_aut$season <- c("autumn")
amount_reviews_sum <- reviews_summer21 %>% count("listing_id")
amount_reviews_sum$season <- c("summer")
amount_reviews_spr <- reviews_spring21 %>% count("listing_id")
amount_reviews_spr$season <- c("spring")
amount_reviews_win <- reviews_winter2021 %>% count("listing_id")
amount_reviews_win$season <- c("winter")

### Bind the seasonal review data into a single data frame
reviews2021 <- rbind(amount_reviews_aut, amount_reviews_sum, amount_reviews_spr, amount_reviews_win)

#### Detach plyr and load dplyr
detach(package:plyr)
library(dplyr)

## Join the review and listing data together
consolidated <- new_listings_price %>%
  inner_join(reviews2021, by = c("id" = "listing_id"), c("season" = "season"))

### Filter only for observations with reviews
seasonal_reviews <- filter(consolidated, season.x == season.y)

### Clean the data frame
new_reviews <- seasonal_reviews %>% 
  select(id, neighbourhood_cleansed, room_type, price, freq, season.y)

## Rename the variables
### Rename the neighbourhoods
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Oostelijk Havengebied - Indische Buurt", 3)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Centrum-West", 1)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Centrum-Oost", 1)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "De Baarsjes - Oud-West", 5)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Oud-Oost", 3)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "De Pijp - Rivierenbuurt", 4)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Slotervaart", 6)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Zuid", 4)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Watergraafsmeer", 3)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Westerpark", 5)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Noord-Oost", 2)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Bos en Lommer", 5)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Buitenveldert - Zuidas", 4)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Noord-West", 2)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Geuzenveld - Slotermeer", 6)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "De Aker - Nieuw Sloten", 6)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "IJburg - Zeeburgereiland", 3)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Bijlmer-Centrum", 7)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Gaasperdam - Driemond", 7)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Oud-Noord", 2)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Osdorp", 6)
new_reviews$neighbourhood_cleansed <- replace(new_reviews$neighbourhood_cleansed, new_reviews$neighbourhood_cleansed == "Bijlmer-Oost", 7)

### Rename the seasons
new_reviews$season.y <- replace(new_reviews$season.y, new_reviews$season.y == "autumn", 1)
new_reviews$season.y <- replace(new_reviews$season.y, new_reviews$season.y == "summer", 2)
new_reviews$season.y <- replace(new_reviews$season.y, new_reviews$season.y == "spring", 3)
new_reviews$season.y <- replace(new_reviews$season.y, new_reviews$season.y == "winter", 4)

### Rename room types
new_reviews$room_type <- replace(new_reviews$room_type, new_reviews$room_type == "Private room", 1)
new_reviews$room_type <- replace(new_reviews$room_type, new_reviews$room_type == "Entire home/apt", 2)
new_reviews$room_type <- replace(new_reviews$room_type, new_reviews$room_type == "Hotel room", 3)
new_reviews$room_type <- replace(new_reviews$room_type, new_reviews$room_type == "Shared room", 4)

## Create a dataset including data of the review per listing per day
### Create a column in reviews dataset to indicate the season
reviews_autumn21$season <- 1
reviews_summer21$season <- 2
reviews_spring21$season <- 3
reviews_winter2021$season <- 4

### Bind the seasonal data frames together
reviews_by_season <- rbind(reviews_autumn21, reviews_summer21, reviews_spring21, reviews_winter2021)

### Join the datasets with variables and dates together
reviews_by_day <- reviews_by_season %>%
  inner_join(new_reviews, by = c("listing_id" = "id"), c("season" = "season.y"))

### Filter the dataset for original reviews
reviews_by_day_origional <- filter(reviews_by_day, season == season.y)

### Turn the comments into a value (every comment=1)
reviews_by_day_origional$comments = 1 

### Filter out unnecessary columns
adam_reviews <- reviews_by_day_origional %>% 
  select(-freq, -season.y)

## Add week column
### Add a column for the weeknumber
adam_reviews$weeks <- format(as.Date(adam_reviews$date), "%W")

### Create a subset for all the weeks starting week 1 of 2021
adam_reviews_pw <- subset(adam_reviews, weeks!= "00" & weeks < "49")

### Change the class of weeks from character to integer
adam_reviews_pw$weeks <- as.integer(adam_reviews_pw$weeks)

# Create a set per neighbourhood for ADE vs year round
## Create a dataframe including only the ADE reviews
### Create a subset for the dates incl 2 weeks after ade
ade_all_reviews <- subset(reviews_cleaned, date> "2021-10-13" & date < "2021-10-31")

### Count amount reviews per listing ADE 2021
#### Detach dplyr and load plyr
detach(package:dplyr)
library(plyr)

### Count the number of reviews
ade_amount_reviews <- ade_all_reviews %>% count("listing_id")

#### Detach plyr and load dplyr
detach(package:plyr)
library(dplyr)

### Select the variables 
new_listings <- adam_listings %>% select(id, neighbourhood_cleansed)

### Joined the dataframes for listings and counted reviews together
ade_review_hood <- ade_amount_reviews %>%
  inner_join(new_listings, by = c("listing_id" = "id"))

#### Detach plyr and load dplyr
detach(package:dplyr)
library(plyr)

### Count reviews per neighbourhood during ADE
ade_count_review_hood <- ade_review_hood %>% count("neighbourhood_cleansed")

## Create a dataset for all the reviews of 2021 excluding ADE
### Create subsets of review data for all the days excluding ade + 2 weeks after the event
b_ade_reviews <- subset(reviews_cleaned, date> "2021-01-01" & date < "2021-10-12")
a_ade_reviews <- subset(reviews_cleaned, date> "2021-11-01" & date < "2021-12-31")

#### Bind the subsets together
not_ade_reviews <- rbind(b_ade_reviews, a_ade_reviews)

### Count amount reviews per listing for all of 2021 excluding ade + 2 weeks after the event
not_amount_reviews <- not_ade_reviews %>% count("listing_id")

#### Detach plyr and load dplyr
detach(package:plyr)
library(dplyr)

### Join the dataframes for listings and counted reviews together
not_review_hood <- not_amount_reviews %>%
  inner_join(new_listings, by = c("listing_id" = "id"))

#### Detach dplyr and load plyr
detach(package:dplyr)
library(plyr)

### Count reviews per neighbourhood for all of 2021 excluding ade + 2 weeks after the event
not_count_review_hood <- not_review_hood %>% count("neighbourhood_cleansed")

#### Detach plyr and load dplyr
detach(package:plyr)
library(dplyr)

## Join the datasets (ade vs not ade) together
reviews_event <- ade_count_review_hood %>%
  inner_join(not_count_review_hood, by = c("neighbourhood_cleansed" = "neighbourhood_cleansed"), suffix = c("_ade", "_year_round"))

### Add and mutate column for calculating the review per neighbourhood difference
reviews_event['ADE%'] <- NA

## Mutate extra columns
reviews_event <-reviews_event %>% mutate(ADE_reviews = freq_ade / freq_year_round)
reviews_event <-reviews_event %>% mutate(ADE_per_neigbbourhood = reviews_event$freq_ade/sum(reviews_event$freq_ade)*100)
reviews_event <-reviews_event %>% mutate(NOT_ADE_per_neigbbourhood = reviews_event$freq_year_round/sum(reviews_event$freq_year_round)*100)

## Create overviews of the data
### Create an overview for reviews per week
revperweek <- adam_reviews_pw  %>% group_by(weeks) %>% summarize(nr_comments = sum(comments, NA.rm=FALSE))

### Create an overview for reviews per day
revperday <-  adam_reviews_pw  %>% group_by(date) %>% summarize(nr_comments = sum(comments, NA.rm=FALSE))

### Create an overview for reviews by neighbourhood per day
revperday_neigbourhood <- adam_reviews %>% group_by(date, neighbourhood_cleansed) %>% summarize(nr_comments = sum(comments, na.rm=TRUE))

# Create an overview of the distribution of reviews per year
## Only select relevant columns for the dataset
reviews_cleaned <- reviews %>% 
  select(listing_id, date, comments) %>%
  mutate(comments = 1)  

## 2020
### Create a subset for the dates of 2020
reviews_2020 <- subset(reviews_cleaned, date> "2020-01-06" & date < "2021-01-01")

### Add a column spicifying weeknumbers
reviews_2020$weeks <- format(as.Date(reviews_2020$date), "%W")

### Alter the class of the weeks and comments columns
reviews_2020$weeks <- as.integer(reviews_2020$weeks)
reviews_2020$comments <- as.integer(reviews_2020$comments)

### Change the comments into one's
reviews_2020$comment <- 1

### Summarize the reviews per week in 2020
reviews_per_week20 <- reviews_2020 %>% group_by(weeks) %>% summarize(reviews = sum(comment, na.rm=TRUE))

## 2019
### Create a subset for the dates of 2019
reviews_2019 <- subset(reviews_cleaned, date> "2019-01-06" & date < "2020-01-01")
### Add a column spicifying weeknumbers
reviews_2019$weeks <- format(as.Date(reviews_2019$date), "%W")
### Alter the class of the weeks and comments columns
reviews_2019$weeks <- as.integer(reviews_2019$weeks)
reviews_2019$comments <- as.integer(reviews_2019$comments)
### Change the comments into one's
reviews_2019$comment <- 1
### Summarize the reviews per week in 2019
reviews_per_week19 <- reviews_2019 %>% group_by(weeks) %>% summarize(reviews = sum(comment, na.rm=TRUE))

## 2018
### Create a subset for the dates of 2018
reviews_2018 <- subset(reviews_cleaned, date> "2017-12-31" & date < "2019-01-01")
### Add a column spicifying weeknumbers
reviews_2018$weeks <- format(as.Date(reviews_2018$date), "%W")
### Alter the class of the weeks and comments columns
reviews_2018$weeks <- as.integer(reviews_2018$weeks)
reviews_2018$comments <- as.integer(reviews_2018$comments)
### Change the comments into one's
reviews_2018$comment <- 1
### Summarize the reviews per week in 2018
reviews_per_week18 <- reviews_2018 %>% group_by(weeks) %>% summarize(reviews = sum(comment, na.rm=TRUE))

# Summarize the dataset to create datapoints resembling a combination of the neigbhourhood and roomtype on a given day
adam_reviews_set <- adam_reviews %>% group_by(date, neighbourhood_cleansed, room_type) %>% summarize (reviews = sum(comments), avg_price = mean(price))

## Create dummy variables
### Create a dummy for ADE
#### Create subsets based on the day of the year
new_data_nade1 <- subset(adam_reviews_set, date> "2021-01-01" & date < "2021-10-12")
new_data_nade2 <- subset(adam_reviews_set, date> "2021-11-01" & date < "2021-12-31")  
new_data_ade <- subset(adam_reviews_set, date> "2021-10-12" & date < "2021-10-31")

#### Mutate the ADE columns of the subsets
new_data_nade1$ade <- "0"
new_data_nade2$ade <- "0"
new_data_ade$ade <- "1"

#### Bind the subsets together to complete the variable
new_reviews_ade <- rbind(new_data_nade1, new_data_nade2, new_data_ade)

### Create dummy variable for season
new_reviews$autumn <- new_reviews$season.y
new_reviews$autumn[new_reviews$autumn != 1] <- 0
new_reviews$summer <- new_reviews$season.y
new_reviews$summer[new_reviews$summer != 2] <- 0
new_reviews$summer[new_reviews$summer == 2] <- 1
new_reviews$spring <- new_reviews$season.y
new_reviews$spring[new_reviews$spring != 3] <- 0
new_reviews$spring[new_reviews$spring == 3] <- 1
new_reviews$winter <- new_reviews$season.y
new_reviews$winter[new_reviews$winter != 4] <- 0
new_reviews$winter[new_reviews$winter == 4] <- 1

### Create a dummy variable for neighbourhood
new_reviews_ade$centre <- new_reviews_ade$neighbourhood_cleansed
new_reviews_ade$centre[new_reviews_ade$centre != 1] <- 0
new_reviews_ade$north <- new_reviews_ade$neighbourhood_cleansed
new_reviews_ade$north[new_reviews_ade$north != 2] <- 0
new_reviews_ade$north[new_reviews_ade$north == 2] <- 1
new_reviews_ade$east <- new_reviews_ade$neighbourhood_cleansed
new_reviews_ade$east[new_reviews_ade$east != 3] <- 0
new_reviews_ade$east[new_reviews_ade$east == 3] <- 1
new_reviews_ade$south <- new_reviews_ade$neighbourhood_cleansed
new_reviews_ade$south[new_reviews_ade$south != 4] <- 0
new_reviews_ade$south[new_reviews_ade$south == 4] <- 1
new_reviews_ade$west <- new_reviews_ade$neighbourhood_cleansed
new_reviews_ade$west[new_reviews_ade$west != 5] <- 0
new_reviews_ade$west[new_reviews_ade$west == 5] <- 1
new_reviews_ade$new_west <- new_reviews_ade$neighbourhood_cleansed
new_reviews_ade$new_west[new_reviews_ade$new_west != 6] <- 0
new_reviews_ade$new_west[new_reviews_ade$new_west == 6] <- 1
new_reviews_ade$southeast <- new_reviews_ade$neighbourhood_cleansed
new_reviews_ade$southeast[new_reviews_ade$southeast != 7] <- 0
new_reviews_ade$southeast[new_reviews_ade$southeast == 7] <- 1

### Create dummy variable for room type
new_reviews_ade$private_room <- new_reviews_ade$room_type
new_reviews_ade$private_room[new_reviews_ade$private_room != 1] <- 0
new_reviews_ade$entire_home_apt <- new_reviews_ade$room_type
new_reviews_ade$entire_home_apt[new_reviews_ade$entire_home_apt != 2] <- 0
new_reviews_ade$entire_home_apt[new_reviews_ade$entire_home_apt == 2] <- 1
new_reviews_ade$hotel_room <- new_reviews_ade$room_type
new_reviews_ade$hotel_room[new_reviews_ade$hotel_room != 3] <- 0
new_reviews_ade$hotel_room[new_reviews_ade$hotel_room == 3] <- 1
new_reviews_ade$shared_room <- new_reviews_ade$room_type
new_reviews_ade$shared_room[new_reviews_ade$shared_room != 4] <- 0
new_reviews_ade$shared_room[new_reviews_ade$shared_room == 4] <- 1

## Adjust the scale of the dependent variable
new_reviews_ade_log <- new_reviews_ade %>% mutate(reviews_log = log(reviews))

## filter variables with a average price equal to 0
adam_reviews_ade_log <- new_reviews_ade_log %>% filter(avg_price != "0")