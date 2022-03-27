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