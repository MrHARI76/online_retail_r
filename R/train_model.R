library(readr)

data <- read_csv("data/processed/cleaned_online_retail.csv")

scaled_data <- scale(data[, -1])  # remove CustomerID

set.seed(123)

kmeans_model <- kmeans(scaled_data, centers = 4, nstart = 25)

data$Cluster <- kmeans_model$cluster

write_csv(data, "outputs/model_output.csv")

