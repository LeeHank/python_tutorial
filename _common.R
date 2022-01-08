# example R options set globally
options(width = 60)

# example chunk options set globally
knitr::opts_chunk$set(echo = TRUE,
                      warning = FALSE,
                      message = FALSE,
                      tidy = TRUE,
                      collapse = TRUE,
                      comment = "#>")
# always library reticulate package
library(reticulate)
