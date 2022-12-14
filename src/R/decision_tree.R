source("./data_load.R")
source("./sampler.R")
source("./formula_builder.R")
library(dplyr)


LOOP_NUMBER <- 100
FACTORS <- c("Pclass", "Sex", "Age", "SibSp", "Parch", "Fare", "Embarked")
RESPONSE_VARIABLE <- "Survived"
# Learn from half the data
batch_predict_ratio <- 2

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
            batch_predict_ratio = batch_predict_ratio)

        decision_tree <- party::ctree(
            formula,
            sample$train_sample
        )
        prediction <- predict(decision_tree, sample$pred_sample)
        result <- c(result, sum(prediction == sample$pred_sample[['Survived']]) / length(sample$pred_sample[['Survived']]))
    }
    all_result[[as.character(formula)[3]]] <- result
}

# Save the calculation
all_result_matrix <- sapply(all_result, function(vec) {
  return(vec)
})
all_result_mean <- colMeans(all_result_matrix)
ordering <- sort(all_result_mean, index.return = TRUE, decreasing = TRUE)
ordering$x

# # Plotting
# all_result_matrix[,ordering$ix][,(1:10)]
# heatmap(t(all_result_matrix[,ordering$ix][,(1:10)]))
# 
# # Using ggplot
# data <- data.frame(t(all_result_matrix[,ordering$ix]))
# 
# t(all_result_matrix[,ordering$ix]) %>% 
#   as.data.frame() %>%
#   rownames_to_column("f_id") %>%
#   pivot_longer(-c(f_id), names_to = "samples", values_to = "counts") %>%
#   ggplot(aes(x=samples, y=f_id, fill=counts)) + 
#   geom_raster() +
#   scale_fill_viridis_c()
