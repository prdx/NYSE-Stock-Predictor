library("plumber")
library("readr")
source("R/companies.R")

path <- "data/"
fundamental_and_prices <<- read_csv(
  paste(path, "fundamental_and_prices.csv", sep = ""))

app <- plumber$new()

# Endpoint /companies
companies <- plumber$new("R/companies.R")
app$mount("/companies", companies)

app$run(port=8000)
