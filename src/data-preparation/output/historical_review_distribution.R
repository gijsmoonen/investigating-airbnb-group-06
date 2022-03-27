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
