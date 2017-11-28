# Get LSTM value for each company
getAllLSTMValue <- function() {
  lstm_result %>%
    mutate(recommendation = future_price - current_price)
}