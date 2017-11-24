library(httr)
library(jsonlite)

source("Client/helper.R")

host <- 'http://localhost:8000'

# GET /companies/sector
getSectorList <- function() {
  endpoint <- '/companies/sector'
  raw.result <- GET(url = paste(host, endpoint, sep = ""))
  this.raw.content <- rawToChar(raw.result$content)
  this.content <- fromJSON(this.raw.content)
  as.list(this.content)
}

# POST /companies/name
postName <- function(name) {
  endpoint <- '/companies/name'
  raw.result <- POST(url = paste(host, endpoint, sep = ""), body = paste("companyName=", name, sep=""))
  
  this.raw.content <- rawToChar(raw.result$content)
  this.content <- fromJSON(this.raw.content)
  changeHeaderName(
    changeTickerIntoLink(this.content)
  )
}

# POST /companies/ticker
postTicker <- function(ticker) {
  endpoint <- '/companies/ticker'
  raw.result <- POST(url = paste(host, endpoint, sep = ""), body = paste("tickerSymbol=", ticker, sep=""))
  
  this.raw.content <- rawToChar(raw.result$content)
  this.content <- fromJSON(this.raw.content)
  changeHeaderName(
    changeTickerIntoLink(this.content)
  )
}

# POST /companies/sector
postSector <- function(sector) {
  endpoint <- '/companies/sector'
  raw.result <- POST(url = paste(host, endpoint, sep = ""), body = paste("sectorName=", sector, sep=""))
  
  this.raw.content <- rawToChar(raw.result$content)
  this.content <- fromJSON(this.raw.content)
  changeHeaderName(
    changeTickerIntoLink(this.content)
  )
}
