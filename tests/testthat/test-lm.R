library(dplyr)

setwd("../..")
path <- paste0(getwd(), "/data/")

fundamental_and_prices_2015 <<- read_csv(
  paste0(path, "fundamental_and_prices_2015.csv"))

fundamental_and_prices_2016 <<- read_csv(
  paste0(path, "fundamental_and_prices_2015.csv"))

source(paste0(getwd(), "/R/lm.R"))
context("Linear regression model")

# predictPrice must return a value
test_that("predictPrice must return at least one value", {
  AAPL2016 <- fundamental_and_prices_2016 %>%
    filter(`Ticker Symbol` == "AAPL") %>%
    select(`Book Value`, 
           `Earnings Per Share`,
           `Profit Margin`,
           `Operating Margin`,
           `Total Debt To Equity`)
  expect_type(predictPrice(AAPL2016), "double")
})

# rmse must return a value
test_that("getRMSE must return at least one value", {
  expect_type(getRMSE(), "double")
})