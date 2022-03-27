library(haven)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(readr)

# Load data from data folder

listings_autumn <- read.csv("gen/data-preparation/temp/listings_2021-12-05.csv")
#listings_summer <- read.csv("gen/data-preparation/temp/listings_2021-09-07.csv")
#listings_spring <- read.csv("gen/data-preparation/temp/listings_2021-06-03.csv")
#listings_winter <- read.csv("gen/data-preparation/temp/listings_2021-03-04.csv")

listings_autumn$season <- c("autumn")
#listings_summer$season <- c("summer")
#listings_spring$season <- c("spring")
#listings_winter$season <- c("winter")

write.csv(listings_autumn, "gen/data-preparation/output/listings_autumn.csv")
