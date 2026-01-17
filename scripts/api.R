library(plumber)
library(jsonlite)
library(here)

# Load monitoring
source(here("scripts", "monitor.R"))

# Load trained K-Means model
kmeans_model <- readRDS(here("outputs", "kmeans_artifact.rds"))

#* Health check
#* @get /health
function() {
  log_event("Health endpoint hit")
  list(status = "API running")
}

#* Assign cluster to new data
#* @post /cluster
function(req) {
  tryCatch({
    input <- fromJSON(req$postBody)
    
    log_event(paste("Input:", paste(input, collapse = ",")))
    
    df <- as.data.frame(input)
    
    cluster <- predict(kmeans_model, df)
    
    log_event(paste("Cluster assigned:", cluster))
    
    list(cluster = cluster)
    
  }, error = function(e) {
    log_event(paste("ERROR:", e$message))
    list(error = e$message)
  })
}
