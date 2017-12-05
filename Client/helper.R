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
changeRecommendationIntoHTML <- function(data) {
  data %>%
    mutate(recommendation = map(recommendation, function(.recommendation) {
      if(is.na(.recommendation)) {
        "<p>UNKNOWN</p>"
      } else if(.recommendation < 0) {
        "<p style='color:red;'>SELL</p>"
      }
      else if(.recommendation > 0) {
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
      `Industry` = industry,
      `Recommendation` = recommendation
      )
}

changeLogisticToCategory <- function(data) {
  data %>%
    mutate(predictorLog = map(.predictedLog, function() {
      if (.predictedLog == 0) {
        "<p>NEUTRAL</p>"
      } else if(.predictedLog < 0) {
        "<p style='color:red;'>DECREASE</p>"
      } else if(.predictedLog > 0) {
        "<p style='color:green;'>INCREASE</p>"
      }
    }))
}

# Make distinct
makeDistinct <- function(data) {
  data %>%
    distinct(ticker_symbol, name, sector, industry, recommendation)
}


