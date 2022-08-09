random_sampler <- function(
    data,
    batch_predict_ratio = 2
) {
    shuffled_data = data[sample(1:nrow(data)), ]
    row_number <- dim(shuffled_data)[1]
    batch_predict_size <- row_number %/% batch_predict_ratio
    train_sample <- shuffled_data[(1:(row_number - batch_predict_size - 1)),]
    predict_sample <- shuffled_data[((row_number - batch_predict_size): row_number),]
    return(list(
        train_sample = train_sample,
        pred_sample = predict_sample 
    ))
}