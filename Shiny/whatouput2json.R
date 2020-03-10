library(mongolite)
library(tidyverse)
library(jsonlite)

collection_name <- "health_responses"  # "test" #health_responses

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
db_clean <- db_unclean

# TEMP #remove early attempts for the moment (these were wrong from earlier version)
db_clean <- db_clean[4:nrow(db_clean),] 

# DEPENDS ON COLS PROVIDED
newcolnames<-c("website", # website being searched
               "score", # score they provide
               "prof", # are they a professional
               "aims", # 1. Does the website have a clear focus?
               "achieve", # 2. Is the information provided clear and aligned to that focus? 
               "reference", # 3. Is it clear what sources of information were used to compile the website (other than the author or producer)?
               "when", # 4. Is it clear when the sources of information used on the website were produced?
               "unbiased", # 5. Is it balanced and unbiased?
               "sources", # 6. Does it provide details of additional sources of support and information?
               "uncertainty", # 7. Does it refer to areas of uncertainty? 
               "Date", #date of input
               "Time") # time of input 
colnames(db_clean) <- newcolnames

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

#Output for json
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
