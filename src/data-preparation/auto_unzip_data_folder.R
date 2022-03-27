## Unzip data files

install.packages("here")
install.packages("plyr")

library(here)
library(plyr)
library(conflicted)

conflict_prefer("here", "here")

zip_file <- list.files(path = here("data/airbnb"), pattern = "*.zip",
                                    full.names = T)

ldply(.data = zip_file, .fun = unzip, exdir = here("gen/data-preparation/temp"))  

