library(dplyr)

setwd("../..")
path <- paste0(getwd(), "/data/")

source(paste0(getwd(), "/R/sentiment.R"))
context("Sentiment analysis model")

# sentiment analysis must return a value
test_that("getNewsSentimentAnalysis must return at least one value", {
  expect_type(getNewsSentimentAnalysis("AAPL"), "double")
})