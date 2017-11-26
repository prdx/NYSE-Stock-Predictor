library("plumber")
library("readr")

# Load the data first, and make it global variable
path <- "data/"
fundamental_and_prices <<- read_csv(
  paste(path, "fundamental_and_prices.csv", sep = ""))

# When we run the script, it will also run tidy the fundamental_and_prices.
# That is why we put the fundamental_and_prices above
source("R/companies.R")

# Create an empty plumber instance
app <- plumber$new()

# For every endpoint add the file we want to mount
# Endpoint /companies
companies <- plumber$new("R/companies.R")
app$mount("/companies", companies)

app$run(host="0.0.0.0", port=8000)
