library(httr)
library(jsonlite)

host <- 'http://localhost:8000'

# GET /companies/sector
getSectorList <- function() {
  endpoint <- '/companies/sector'
  raw.result <- GET(url = paste(host, endpoint, sep = ""))
  this.raw.content <- rawToChar(raw.result$content)
  this.content <- fromJSON(this.raw.content)
  as.list(this.content)
}

# POST /companies/sector
postSector <- function(sector) {
  endpoint <- '/companies/sector'
  raw.result <- POST(url = paste(host, endpoint, sep = ""), body = paste("sectorName=", sector, sep=""))
  
  this.raw.content <- rawToChar(raw.result$content)
  this.content <- fromJSON(this.raw.content)
  as.list(this.content)
}

