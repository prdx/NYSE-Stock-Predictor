library(modelr)
library(tibble)
library(purrr)

# Prepare regression data
# Load fundamental data
lm_model <- lm(close ~ `Book Value` +
                 `Earnings Per Share` +
                 `Profit Margin` +
                 `Operating Margin` +
                 `Total Debt To Equity`,
                  data = fundamental_and_prices_2015, na.action=na.omit)

# Predict the price
predictPrice <- function(params) {
  predict(lm_model, params)
}

# Cross validation
kfoldCv <- function(formula, data, folds = 0) {
  # Error handling
  if(!inherits(formula, "formula")) {
    stop("Not a formula")
  }
  
  # Convert to tibble
  data <- as.tibble(data)
  set.seed(1)
  
  message("Partitioning the data")
  data_cv <- crossv_kfold(data, folds)
  
  message("Fitting models for cross-validation on training sets")
  data_cv <- data_cv %>%
    mutate(fit  = map(train, ~ lm(formula, data = ., na.action=na.omit)))
  
  message("Getting the cross-validated prediction errors")
  data_cv <- data_cv %>%
    mutate(rmse_train = map2_dbl(fit, train, ~ rmse(.x, .y)),
           rmse_test = map2_dbl(fit, test, ~ rmse(.x, .y)))
  
  mean(data_cv$rmse_test)
}

# Get RMSE
#' @get /rmse
#' @json
getRMSE <- function() {
  kfoldCv(
    close ~ `Book Value` +
      `Earnings Per Share` +
      `Profit Margin` +
      `Operating Margin` +
      `Total Debt To Equity`,
    fundamental_and_prices_2015,
    folds = 10
  )
}
  

