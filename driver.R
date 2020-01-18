library(plumber)
setwd("E:\\code\\R\\soccer_predict")
r <- plumb("predict.R")
r$run(port=8000)