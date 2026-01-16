library(caret)
library(readr)

data <- read_csv("data/processed/retail_cleaned.csv")

set.seed(123)

split <- createDataPartition(data$TotalPrice, p = 0.8, list = FALSE)
train <- data[split, ]
test  <- data[-split, ]

model <- train(
  TotalPrice ~ Quantity + UnitPrice,
  data = train,
  method = "lm"
)

saveRDS(model, "outputs/model.rds")
