library(caret)
library(readr)

model <- readRDS("outputs/model.rds")
data  <- read_csv("data/processed/retail_cleaned.csv")

predictions <- predict(model, data)

rmse <- RMSE(predictions, data$TotalPrice)
mae  <- MAE(predictions, data$TotalPrice)

results <- paste(
  "RMSE:", rmse,
  "\nMAE:", mae
)

writeLines(results, "outputs/metrics.txt")
print(results)