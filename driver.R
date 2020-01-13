library(plumber)
r <- plumb("predict.R")
r$run(port=8000)