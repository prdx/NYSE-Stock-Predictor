library(readr)

setwd("../..")
path <- paste0(getwd(), "/data/")

sentiment_result <<- read_csv(
  paste0(path, "sentiment_result.csv"))

source(paste0(getwd(), "/R/sentiment.R"))
context("Sentiment analysis model")

# sentiment analysis must return a value
test_that("getNewsSentimentAnalysis must return at least one value", {
  expect_type(getNewsSentimentAnalysis("AAPL"), "double")
})