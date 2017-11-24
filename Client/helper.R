# Helper file:
# This file contains all of the general functions that does not belong
# to specific function

library(dplyr)

# This function will replace the ticker_symbol data with a link
changeTickerIntoLink <- function(data) {
  host <- "http://127.0.0.1:7311"
  data %>%
    mutate(
      ticker_symbol = paste0(
        "<a id='link_",
        ticker_symbol,
        "' href='",
        host,"'>",
        ticker_symbol,"</a>"
        ))
}

# To make it looks tidy, we rename the column names here
changeHeaderName <- function(data) {
  data %>%
    rename(
      `Ticker Symbol` = ticker_symbol,
      `Company Name` = name,
      `Sector` = sector,
      `Industry` = industry
      )
}