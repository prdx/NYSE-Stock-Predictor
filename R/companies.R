source("R/loader.R")

# This function will prepare the data needed for getting the information
prepareCompanyInfo <- function(fundamental_and_prices) {
  companies <- fundamental_and_prices %>%
    rename(
      ticker_symbol = `Ticker Symbol`,
      name = `Name`,
      sector = `Sector`,
      industry = `Industry`
    ) %>%
    distinct(ticker_symbol, name, sector, industry)
  
  companies
}

fundamental_and_prices <- loadFundamental()
companies <- prepareCompanyInfo(fundamental_and_prices)

#' @get /all
#' @json
getAllCompanyInfo <- function() {
  companies
}

#' @post /name
#' @json
getCompanyByName <- function(companyName) {
  companies %>%
    filter(name == paste(companyName))
}

#' @post /ticker
#' @json
getCompanyByTicker <- function(tickerSymbol) {
  companies %>%
    filter(ticker_symbol == paste(tickerSymbol))
}

#' @post /sector
#' @json
getCompanyBySector <- function(sector) {
  companies %>%
    filter(sector == paste(sector))
}
