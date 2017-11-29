# API file:
# This file contains all of the functions that connects to an external API

library(httr)
library(jsonlite)

source("helper.R")

host <- 'http://52.87.114.182:8000'

# GET /companies/sector
getSectorList <- function() {
  endpoint <- '/companies/sector'
  raw.result <- GET(url = paste0(host, endpoint))
  this.raw.content <- rawToChar(raw.result$content)
  this.content <- fromJSON(this.raw.content)
  as.list(this.content)
}

# GET /lm/rmse
getLmRmse <- function() {
  endpoint <- '/lm/rmse'
  raw.result <- GET(url = paste0(host, endpoint))
  this.raw.content <- rawToChar(raw.result$content)
  this.content <- fromJSON(this.raw.content)
  as.list(this.content)
}

# POST /companies/details
postDetails <- function(tickerLink) {
  # Get only the ticker symbol
  # Previous input: link_AAC
  # Expected: AAC 
  ticker <- strsplit(tickerLink, "_")[[1]][[2]]
  
  endpoint <- '/companies/details'
  raw.result <- POST(url = paste0(host, endpoint),
                     body = paste0("tickerSymbol=", ticker))
  this.raw.content <- rawToChar(raw.result$content)
  this.content <- fromJSON(this.raw.content)
  as.list(changeHeaderName(
    this.content
  ))
}

# POST /companies/name
postName <- function(name) {
  endpoint <- '/companies/name'
  raw.result <- POST(url = paste0(host, endpoint),
                     body = paste0("companyName=", name))
  
  this.raw.content <- rawToChar(raw.result$content)
  this.content <- fromJSON(this.raw.content)
  changeHeaderName(
    changeRecommendationIntoHTML(changeTickerIntoLink(makeDistinct(this.content)))
  )
}

# POST /companies/ticker
postTicker <- function(ticker) {
  endpoint <- '/companies/ticker'
  raw.result <- POST(url = paste0(host, endpoint),
                     body = paste0("tickerSymbol=", ticker))
  
  this.raw.content <- rawToChar(raw.result$content)
  this.content <- fromJSON(this.raw.content)
  changeHeaderName(
    changeRecommendationIntoHTML(changeTickerIntoLink(makeDistinct(this.content)))
  )
}

# POST /companies/sector
postSector <- function(sector) {
  endpoint <- '/companies/sector'
  raw.result <- POST(url = paste0(host, endpoint),
                     body = paste0("sectorName=", sector))
  
  this.raw.content <- rawToChar(raw.result$content)
  this.content <- fromJSON(this.raw.content)
  changeHeaderName(
    changeRecommendationIntoHTML(changeTickerIntoLink(makeDistinct(this.content)))
  )
}
