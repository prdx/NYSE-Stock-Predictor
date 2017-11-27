library("plumber")
library("readr")

# Load the data first, and make it global variable
data_path <<- "data/"
fundamental_and_prices_2015 <<- read_csv(
  paste0(data_path, "fundamental_and_prices_2015.csv"))

fundamental_and_prices_2016 <<- read_csv(
  paste0(data_path, "fundamental_and_prices_2016.csv"))

sentiment_result <<- read_csv(
  paste0(data_path, "sentiment_result.csv"))

# When we run the script, it will also run tidy the fundamental_and_prices.
# That is why we put the fundamental_and_prices above
source("R/companies.R")
source("R/sentiment.R")

# Create an empty plumber instance
app <- plumber$new()

# For every endpoint add the file we want to mount
# Endpoint /companies
companies <- plumber$new("R/companies.R")
app$mount("/companies", companies)

# Endpoint /lm
linearModel <- plumber$new("R/lm.R")
app$mount("/lm", linearModel)

# Endpoint /sentiment
sentiment <- plumber$new("R/sentiment.R")
app$mount("/lm", sentiment)

app$run(host="0.0.0.0", port=8000)
