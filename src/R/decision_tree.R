source("./data_load.R")
source("./sampler.R")
source("./formula_builder.R")
library(dplyr)


# Learn from half the data
LOOP_NUMBER <- 100
FACTORS <- c("Pclass", "Sex", "Age", "SibSp", "Parch", "Fare", "Embarked")
RESPONSE_VARIABLE <- "Survived"

# Build all formulas
all_formulas <- build_formulas(
    response_variable = RESPONSE_VARIABLE,
    factors = FACTORS
)

all_result <- list()
for (formula in all_formulas) {
    print(as.character(formula)[3])
    result <- c()
    for (loop_index in (1:LOOP_NUMBER)) {
        sample <- random_sampler(
            data = training,
            batch_predict_ratio = 2)

        decision_tree <- party::ctree(
            formula,
            sample$train_sample
        )
        prediction <- predict(decision_tree, sample$pred_sample)
        result <- c(result, sum(prediction == sample$pred_sample[['Survived']]) / length(sample$pred_sample[['Survived']]))
    }
    all_result[[as.character(formula)[3]]] <- mean(result)
}

best_indexes <- which(unlist(all_result) == max(unlist(all_result)))
all_result[best_indexes]