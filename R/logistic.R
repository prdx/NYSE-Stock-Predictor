library(modelr)
library(tibble)
library(purrr)

# Prepare regression data
# Load fundamental data
logistic_train$status <- as.factor(logistic_train$status)

logisticModel <- glm(status ~ open + low + high,
                       family=binomial(link="logit"),
                       data = logistic_train)

# Predict the price
predictPriceByLogistic <- function(params) {
  predict(logisticModel, params)
}