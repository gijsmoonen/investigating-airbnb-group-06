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
listings_autumn <- read_csv("listings(autumn).csv")
listings_summer <- read_csv("listings(summer).csv") 
listings_spring <- read_csv("listings(spring).csv") 
listings_winter <- read_csv("listings(winter).csv")

### Download Airbnb reviews data
reviews <- read_csv("reviews.csv")

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

### Add week column
#### Add a column for the weeknumber
adam_reviews$weeks <- format(as.Date(adam_reviews$date), "%W")

#### Create a subset for all the weeks starting week 1 of 2021
adam_reviews_pw <- subset(adam_reviews, weeks!= "00" & weeks < "49")

#### Change the class of weeks from character to integer
adam_reviews_pw$weeks <- as.integer(adam_reviews_pw$weeks)