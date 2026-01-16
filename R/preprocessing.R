library(dplyr)
library(readxl)
library(lubridate)
library(readr)

data <- read_excel("data/raw/Online Retail.xlsx")

clean_data <- data %>%
  filter(
    !is.na(CustomerID),
    Quantity > 0,
    UnitPrice > 0
  ) %>%
  mutate(
    InvoiceDate = as.POSIXct(InvoiceDate),
    TotalPrice = Quantity * UnitPrice
  ) %>%
  select(
    InvoiceNo,
    Quantity,
    UnitPrice,
    TotalPrice,
    CustomerID,
    Country
  )

write_csv(clean_data, "data/processed/retail_cleaned.csv")
