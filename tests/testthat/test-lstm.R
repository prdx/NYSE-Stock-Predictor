library(readr)

setwd("../..")
path <- paste0(getwd(), "/data/")

lstm_result <<- read_csv(
  paste0(path, "lstm_result.csv"))

source(paste0(getwd(), "/R/lstm.R"))
context("LSTM model")

# sentiment analysis must return a value
test_that("getAllLSTMValue must return at least one value", {
  expect_gt(nrow(getAllLSTMValue()), 0)
  expect_true("recommendation" %in% attributes(getAllLSTMValue())$names)
  expect_s3_class(getAllLSTMValue(), "tbl")
})