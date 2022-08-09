build_formulas <- function(
    response_variable,
    factors,
    minimum_factor_number = 1,
    maximum_factor_number = length(factors)) {
    result <- list()
    for (factor_number in (minimum_factor_number: maximum_factor_number)) {
        all_permutation <- combinat::combn(factors, factor_number)
        if (is.matrix(all_permutation)) {
        # For all the cases but the one with one permutation
            for (col_index in (1:dim(all_permutation)[2])) {
                permutation <- all_permutation[,col_index]
                result <- c(result,
                        as.formula(paste(
                        response_variable,
                        " ~ ",
                        paste(permutation, collapse = " + ")
                    ))
                )
            }
        } else { 
        # For the case with only one permutation
                result <- c(result,
                        as.formula(paste(
                        response_variable,
                        " ~ ",
                        paste(all_permutation, collapse = " + ")
                    ))
                )
        }
    }
    return(result)
}
