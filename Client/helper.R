# Helper file:
# This file contains all of the general functions that does not belong
# to specific function

library(dplyr)

# This function will replace the ticker_symbol data with a link
changeTickerIntoLink <- function(data) {
  host <- "#"
  data %>%
    mutate(
      ticker_symbol = paste0(
        "<a id='link_",
        ticker_symbol,
        "' onClick='tickerClicked(this.id)' class='ticker-symbol' href='",
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

# Make distinct
makeDistinct <- function(data) {
  data %>%
    distinct(ticker_symbol, name, sector, industry)
}