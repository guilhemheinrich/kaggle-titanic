source("./data_load.R")
source("./sampler.R")
source("./formula_builder.R")
library(dplyr)


FACTORS <- c("Pclass", "Sex", "Age", "SibSp", "Parch", "Fare", "Embarked")
RESPONSE_VARIABLE <- "Survived"

formula <- build_formulas(
    response_variable = RESPONSE_VARIABLE,
    factors = FACTORS,
    minimum_factor_number = length(factors)
)[[1]]

sample <- random_sampler(
    data = training,
    batch_predict_ratio = 2)


randomForest::randomForest(formula,
    data = sample$train_sample,
    na.action = na.roughfix)