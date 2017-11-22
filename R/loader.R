library("readr")

path <- "data/"

loadFundamental <- function() {
  read_csv(paste(path, "fundamental_and_prices.csv", sep = ""))
} 
