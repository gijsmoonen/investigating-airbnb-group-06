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
