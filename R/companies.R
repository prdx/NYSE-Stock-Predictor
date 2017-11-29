library("readr")
library("dplyr")

source("R/lm.R")
source("R/sentiment.R")
source("R/lstm.R")

# This function will prepare the data needed for getting the information
prepareCompanyInfo <- function(data) {
  companies <- data %>%
    rename(
      ticker_symbol = `Ticker Symbol`,
      name = `Name`,
      sector = `Sector`,
      industry = `Industry`
    ) 
  
  companies
}

# Here is where the data tidying process begins
companies <- prepareCompanyInfo(fundamental_and_prices_2016)
lstm_result <- getAllLSTMValue()

companies <- companies %>%
  left_join(lstm_result, by=c("ticker_symbol" = "ticker"))

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
    filter(name == companyName) %>%
    select(ticker_symbol, name, sector, industry, recommendation)
}

# Get list of all companies by ticker symbol
#' @post /ticker
#' @json
getCompanyByTicker <- function(tickerSymbol) {
  companies %>%
    filter(ticker_symbol == tickerSymbol) %>%
    select(ticker_symbol, name, sector, industry, recommendation) 
}

# Get list of all companies by sector
#' @post /sector
#' @json
getCompanyBySector <- function(sectorName) {
  companies %>%
    filter(sector == sectorName) %>%
    select(ticker_symbol, name, sector, industry, recommendation)
}

# Get detais of a company
#' @post /details
#' @json
getCompanyDetailsByTicker <- function(tickerSymbol) {
  companies %>%
    filter(ticker_symbol == tickerSymbol) %>%
    mutate(predictedLm = predictPrice(
      tribble(
        ~"Book Value", ~"Earnings Per Share", ~"Profit Margin", ~"Operating Margin", ~"Total Debt To Equity",
        `Book Value`, `Earnings Per Share`, `Profit Margin`, `Operating Margin`, `Total Debt To Equity`
      )
    ), sentiment_result = getNewsSentimentAnalysis(tickerSymbol))
}

# Get list of available companies
#' @get /name
#' @json
getCompaniesName <- function() {
  companies %>%
    distinct(name)
}

# Get list of available companies ticker symbol
#' @get /ticker
#' @json
getCompaniesName <- function() {
  companies %>%
    distinct(ticker_symbol)
}

# Get list of available companies sector
#' @get /sector
#' @json
getCompaniesName <- function() {
  companies %>%
    distinct(sector)
}
