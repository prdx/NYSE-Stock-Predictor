library(readr)

setwd("../..")
path <- paste0(getwd(), "/data/")
fundamental_and_prices_2016 <<- read_csv(
  paste0(path, "fundamental_and_prices_2016.csv"))

fundamental_and_prices_2015 <<- read_csv(
  paste0(path, "fundamental_and_prices_2015.csv"))

sentiment_result <<- read_csv(
  paste0(path, "sentiment_result.csv"))

source(paste0(getwd(), "/R/companies.R"))
context("Companies API")

# prepareCompanyInfo must return a value
test_that("prepareCompanyInfo must return at least one value", {
  expect_gt(nrow(prepareCompanyInfo(fundamental_and_prices_2016)), 0)
  expect_s3_class(getAllCompanyInfo(), "tbl")
})

# getAllCompanyInfo must return at least one value
test_that("getAllCompanyInfo returns DF object", {
  expect_gt(nrow(getAllCompanyInfo()), 0)
  expect_s3_class(getAllCompanyInfo(), "tbl")
})

# getCompanyByName returns at least one element if found
test_that("getCompanyByName returns DF object", {
  expect_gt(nrow(getCompanyByName("Apple Inc.")), 0)
  expect_s3_class(getCompanyByName("Apple Inc."), "tbl")
})

# getCompanyByTicker returns at least one element if found
test_that("getCompanyByTicker returns DF object", {
  expect_gt(nrow(getCompanyByTicker("AAPL")), 0)
  expect_s3_class(getCompanyByTicker("AAPL"), "tbl")
})

# getCompanyBySector returns at least one element if found
test_that("getCompanyBySector returns DF object", {
  expect_gt(nrow(getCompanyBySector("Technology")), 0)
  expect_s3_class(getCompanyBySector("Technology"), "tbl")
})

# getCompanyDetailsByTicker returns exactly one row, with predictedLm column
test_that("getCompanyDetailsByTicker returns correctly", {
  expect_equal(nrow(getCompanyDetailsByTicker("AAPL")), 1)
  expect_true("predictedLm" %in% attributes(getCompanyDetailsByTicker("AAPL"))$names)
  expect_s3_class(getCompanyDetailsByTicker("AAPL"), "tbl")
})