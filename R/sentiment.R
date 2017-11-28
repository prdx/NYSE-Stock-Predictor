# Get the sentiment analysis result for each company
getNewsSentimentAnalysis <- function(tickerSymbol) {
  sentiment_result <- sentiment_result %>%
    filter(ticker == tickerSymbol) %>%
    select(score)
  sentiment_result$score
}
