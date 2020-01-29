library(mongolite)
library(tidyverse)
library(jsonlite)

collection_name <- "health_responses"

load_data <- function() {
  db <- mongo(collection = collection_name,
              url = paste0("mongodb+srv://abc:",
                           options()$mongo_password,
                           "@cluster0-hzl4d.mongodb.net/test?retryWrites=true&w=majority"))
  data <- db$find()
  data
}

# load uncleaned data
db_unclean<-load_data()

# remove early attempts for the moment (these were wrong from earlier version)
db_clean <- db_unclean[4:nrow(db_unclean),]

# Drop Healthcare column for the moment and make V2 nuemric
db_clean <- db_clean %>% select(-V3) %>%
  mutate(V2=as.numeric(V2))


# summarise if same website/V1 name
db_sum <- db_clean %>% mutate(V1=gsub("(^http://)|(^https://)|(/$)","",V1),
                              V1=ifelse(!grepl("^www\\.",V1),paste0("www.",V1),V1)) %>%
  group_by(V1) %>% summarise(V2median=median(V2),n=n(),V2sd=sd(V2)) %>%
  mutate(V2=V2median*10,V2median=ceiling(V2median)) %>% select(-V2median) %>%
  mutate(nsep=str_count(V1,"/")) %>%
  arrange(desc(nsep))

#Output
# alter to prep files in desired format
db_out <- db_sum %>% select(V1,V2)

# Creating info JSON
json_content <- paste0("{\n")
for (i in 1:length(db_out$V1)){
  cat(paste0("\"", db_out$V1[[i]], "\" : ", db_out$V2[[i]]), ",\n")
  json_content <- paste0(json_content, paste0("\"", db_out$V1[[i]], "\" : ", db_out$V2[[i]], ",\n"))
}
json_content <- paste0(json_content, "}\n")
fileConn <- file("info.json")
writeLines(json_content, fileConn)
close(fileConn)
