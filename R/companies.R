library("readr")
library("dplyr")

# This function will prepare the data needed for getting the information
prepareCompanyInfo <- function(data) {
  companies <- data %>%
    rename(
      ticker_symbol = `Ticker Symbol`,
      name = `Name`,
      sector = `Sector`,
      industry = `Industry`
    ) %>%
    distinct(ticker_symbol, name, sector, industry)
  
  companies
}

companies <- prepareCompanyInfo(fundamental_and_prices)

# Get list of all companies
#' @get /all
#' @json
getAllCompanyInfo <- function() {
  companies
}

# Get list of all companies by name
#' @post /name
#' @json
getCompanyByName <- function(companyName) {
  companies %>%
    filter(name == companyName)
}

# Get list of all companies by ticker symbol
#' @post /ticker
#' @json
getCompanyByTicker <- function(tickerSymbol) {
  companies %>%
    filter(ticker_symbol == paste(tickerSymbol))
}

# Get list of all companies by sector
#' @post /sector
#' @json
getCompanyBySector <- function(sector) {
  companies %>%
    filter(sector == paste(sector))
}
