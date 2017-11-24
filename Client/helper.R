library(dplyr)

changeTickerIntoLink <- function(data) {
  host <- "http://127.0.0.1:7311"
  data %>%
    mutate(ticker_symbol = paste0("<a id='link_", ticker_symbol, "' href='", host,"'>", ticker_symbol,"</a>"))
}

changeHeaderName <- function(data) {
  data %>%
    rename(
      `Ticker Symbol` = ticker_symbol,
      `Company Name` = name,
      `Sector` = sector,
      `Industry` = industry
      )
}