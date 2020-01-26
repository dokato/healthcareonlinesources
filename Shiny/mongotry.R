library(mongolite)

collection_name <- "health_responses"

save_data <- function(data) {
  db <- mongo(collection = collection_name,
              url = paste0("mongodb+srv://abc:",
                           options()$mongo_password,
                           "@cluster0-hzl4d.mongodb.net/test?retryWrites=true&w=majority")
  )
  data <- as.data.frame(t(data))
  db$insert(data)
}

load_data <- function() {
  db <- mongo(collection = collection_name,
              url = paste0("mongodb+srv://abc:",
                           options()$mongo_password,
                           "@cluster0-hzl4d.mongodb.net/test?retryWrites=true&w=majority")
  )
  data <- db$find()
  data
}
