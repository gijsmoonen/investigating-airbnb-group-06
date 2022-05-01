
# removing outliers from model (avg_price is the reference)

nooutliers_nra <- new_reviews_ade_log %>%
  filter(avg_price != 112.2703, avg_price != 106.2157, avg_price != 249, avg_price != 114.2738, avg_price != 890.0000, avg_price != 325.0000, avg_price != 224.6087)

# removing outliers from model with logarithmic transformation 

nooutliers_nral <- new_reviews_ade_log %>%
  filter(avg_price != 112.2703, avg_price != 106.2157, avg_price != 249, avg_price != 114.2738, avg_price != 890.0000, avg_price != 325.0000, avg_price != 224.6087)

