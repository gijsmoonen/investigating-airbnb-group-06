#Run the correct library functions

install.packages("haven") # import SPSS data
install.packages("dplyr") # data management
install.packages("ggplot2") # produce different types of plots
install.packages("cluster") # cluster analysis
install.packages("factoextra") # visualizes output of cluster analysis
install.packages("car") # for assessing significance of cluster differences (ANOVA)

library(haven)
library(dplyr)
library(ggplot2)
library(cluster)
library(factoextra)
library(car)
library(tidyverse)
library(ggplot2)
library(readr)

#Download file
listings <- read_csv("http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-12-05/data/listings.csv.gz")
listings3 <- read_csv("http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-09-07/data/listings.csv.gz") 
listings4 <- read_csv("http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-06-03/data/listings.csv.gz")
listings5 <- read_csv("http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-03-04/data/listings.csv.gz")

calendar <- read_csv("http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-12-05/data/calendar.csv.gz")
reviews <- read_csv("http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2021-12-05/data/reviews.csv.gz")

listings$season <- c("autumn")
listings3$season <- c("summer")
listings4$season <- c("spring")
listings5$season <- c("winter")

# combining all listings 2021
adam_listings <- rbind(listings, listings3, listings4, listings5)
all_listings <- adam_listings %>% distinct(id, .keep_all = TRUE)

###### during ADE
# filtered neighbourhood data set
new_listings <- all_listings %>%
  select(id, neighbourhood_cleansed)

#filter price
new_listings_price <- adam_listings %>%
  select(id, neighbourhood_cleansed, room_type, price, season)

# remove the dollar sign and commas (for prices above thousand)
new_listings_price$price <- gsub('[$,]', '', new_listings_price$price)
# changing price variable from character to numeric
new_listings_price$price <- as.numeric(new_listings_price$price)
# check for the results
class(new_listings_price$price)
# filtered review data set
new_reviews <- reviews %>% 
  select(listing_id, date, comments)

#filter reviews based on the season
reviews_autumn21 <- subset(new_reviews, date> "2021-09-07" & date < "2021-12-05")
reviews_summer21 <- subset(new_reviews, date> "2021-06-03" & date < "2021-09-07")
reviews_spring21 <- subset(new_reviews, date> "2021-03-04" & date < "2021-06-03")
reviews_winter2021 <- subset(new_reviews, date> "2020-12-06" & date < "2021-03-04")

#switch to plyr
detach(package:dplyr)
library(plyr)

#count the number of reviews per season
amount_reviews_aut <- reviews_autumn21 %>% count("listing_id")
amount_reviews_aut$season <- c("autumn")
amount_reviews_sum <- reviews_summer21 %>% count("listing_id")
amount_reviews_sum$season <- c("summer")
amount_reviews_spr <- reviews_spring21 %>% count("listing_id")
amount_reviews_spr$season <- c("spring")
amount_reviews_win <- reviews_winter2021 %>% count("listing_id")
amount_reviews_win$season <- c("winter")
reviews2021 <- rbind(amount_reviews_aut, amount_reviews_sum, amount_reviews_spr, amount_reviews_win)

#switch back to dplyr
detach(package:plyr)
library(dplyr)

#join both datasets together (listings and reviews)
consolidated <- new_listings_price %>%
  inner_join(reviews2021, by = c("id" = "listing_id"), c("season" = "season"))

consolidated1 <- consolidated[!duplicated(consolidated[c("season.x", "id", "freq")]),]

#filter only for observations with reviews
seasonal_reviews <- filter(consolidated, season.x == season.y)
new_reviews <- seasonal_reviews %>% 
  select(id, neighbourhood_cleansed, room_type, price, freq, season.y)

#create dummy variables
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

new_reviews$centre <- new_reviews$neighbourhood_cleansed
new_reviews$centre[new_reviews$centre != 1] <- 0
new_reviews$north <- new_reviews$neighbourhood_cleansed
new_reviews$north[new_reviews$north != 2] <- 0
new_reviews$north[new_reviews$north == 2] <- 1
new_reviews$east <- new_reviews$neighbourhood_cleansed
new_reviews$east[new_reviews$east != 3] <- 0
new_reviews$east[new_reviews$east == 3] <- 1
new_reviews$south <- new_reviews$neighbourhood_cleansed
new_reviews$south[new_reviews$south != 4] <- 0
new_reviews$south[new_reviews$south == 4] <- 1
new_reviews$west <- new_reviews$neighbourhood_cleansed
new_reviews$west[new_reviews$west != 5] <- 0
new_reviews$west[new_reviews$west == 5] <- 1
new_reviews$new_west <- new_reviews$neighbourhood_cleansed
new_reviews$new_west[new_reviews$new_west != 6] <- 0
new_reviews$new_west[new_reviews$new_west == 6] <- 1
new_reviews$southeast <- new_reviews$neighbourhood_cleansed
new_reviews$southeast[new_reviews$southeast != 7] <- 0
new_reviews$southeast[new_reviews$southeast == 7] <- 1

new_reviews$season.y <- replace(new_reviews$season.y, new_reviews$season.y == "autumn", 1)
new_reviews$season.y <- replace(new_reviews$season.y, new_reviews$season.y == "summer", 2)
new_reviews$season.y <- replace(new_reviews$season.y, new_reviews$season.y == "spring", 3)
new_reviews$season.y <- replace(new_reviews$season.y, new_reviews$season.y == "winter", 4)

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

new_reviews$room_type <- replace(new_reviews$room_type, new_reviews$room_type == "Private room", 1)
new_reviews$room_type <- replace(new_reviews$room_type, new_reviews$room_type == "Entire home/apt", 2)
new_reviews$room_type <- replace(new_reviews$room_type, new_reviews$room_type == "Hotel room", 3)
new_reviews$room_type <- replace(new_reviews$room_type, new_reviews$room_type == "Shared room", 4)

new_reviews$private_room <- new_reviews$room_type
new_reviews$private_room[new_reviews$private_room != 1] <- 0
new_reviews$entire_home_apt <- new_reviews$room_type
new_reviews$entire_home_apt[new_reviews$entire_home_apt != 2] <- 0
new_reviews$entire_home_apt[new_reviews$entire_home_apt == 2] <- 1
new_reviews$hotel_room <- new_reviews$room_type
new_reviews$hotel_room[new_reviews$hotel_room != 3] <- 0
new_reviews$hotel_room[new_reviews$hotel_room == 3] <- 1
new_reviews$shared_room <- new_reviews$room_type
new_reviews$shared_room[new_reviews$shared_room != 4] <- 0
new_reviews$shared_room[new_reviews$shared_room == 4] <- 1
View(new_reviews)

# filtered review data set ADE
new_reviews1 <- reviews %>% 
  select(listing_id, date, comments)

ade_all_reviews <- subset(new_reviews1, date> "2021-10-13" & date < "2021-10-31")

# count amount reviews per listing ADE 2021
detach(package:dplyr)
library(plyr)

ade_amount_reviews <- ade_all_reviews %>% count("listing_id")

detach(package:plyr)
library(dplyr)

# joined amount reviews and new listings
ade_review_hood <- ade_amount_reviews %>%
  inner_join(new_listings, by = c("listing_id" = "id"))


# count reviews per neighbourhood during ADE
detach(package:dplyr)
library(plyr)
ade_count_review_hood <- ade_review_hood %>% count("neighbourhood_cleansed")

##### not during ADE
# filtered review data set not ADE
b_ade_reviews <- subset(new_reviews1, date> "2021-01-01" & date < "2021-10-12")
a_ade_reviews <- subset(new_reviews1, date> "2021-11-01" & date < "2021-12-31")
not_ade_reviews <- rbind(b_ade_reviews, a_ade_reviews)

# count amount reviews per listing not ADE 2021
not_amount_reviews <- not_ade_reviews %>% count("listing_id")

# joined amount reviews and new listings
detach(package:plyr)
library(dplyr)

not_review_hood <- not_amount_reviews %>%
  inner_join(new_listings, by = c("listing_id" = "id"))

# count reviews per neighbourhood during ADE
detach(package:dplyr)
library(plyr)

not_count_review_hood <- not_review_hood %>% count("neighbourhood_cleansed")

detach(package:plyr)
library(dplyr)

#join together
reviews_event <- ade_count_review_hood %>%
  inner_join(not_count_review_hood, by = c("neighbourhood_cleansed" = "neighbourhood_cleansed"), suffix = c("_ade", "_year_round"))
View(reviews_event)


#analyses
Overview_prices <- new_reviews %>% group_by(neighbourhood_cleansed, room_type) %>% summarize(mean_price = mean(price, na.rm=TRUE))
View(Overview_prices)

ggplot(new_reviews, aes(x = as.factor(season.y), y = freq)) + geom_point()
summarize(regres)                                       

regression <- lm(price~freq+centre+north+east+south+west+new_west+southeast+private_room+entire_home_apt+hotel_room+shared_room+autumn+summer+spring+winter, new_reviews)
summary(regression)