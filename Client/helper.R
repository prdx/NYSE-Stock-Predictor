# Helper file:
# This file contains all of the general functions that does not belong
# to specific function

library(dplyr)
library(purrr)

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

# This function will format the recommendation to HTML format
changeRecommendationIntoLink <- function(data) {
  data %>%
    mutate(recommendation = map(recommendation, function(.recommendation) {
      if(.recommendation < 0) {
        "<p style='color:red;'>SELL</p>"
      }
      else if(.recommendation >0) {
        "<p style='color:green;'>BUY</p>"
      }
      else {
        "<p>NEUTRAL</p>"
      }
    }))
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