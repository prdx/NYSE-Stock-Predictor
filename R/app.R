library("plumber")
source("R/companies.R")

app <- plumber$new()

# Endpoint /companies
companies <- plumber$new("R/companies.R")
app$mount("/companies", companies)

app$run(port=8000)
