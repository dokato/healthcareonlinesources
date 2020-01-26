require(mongolite)
require(tidyverse)

loadData <- function() {
  # Connect to the database
  db <- mongo(collection = "health_responses",
              url = paste0("mongodb+srv://abc:",
                           options()$mongo_password,
                           "@cluster0-hzl4d.mongodb.net/test?retryWrites=true&w=majority"))
  # Read all the entries
  data <- db$find()
  data
}

# load uncleaned data
db_unclean<-loadData()

# remove early attempts for the moment (these were wrong from earlier version)
db_clean <- db_unclean[4:nrow(db_unclean),]

# Drop Healthcare column for the moment and make V2 nuemric
db_clean <- db_clean %>% select(-V3) %>%
  mutate(V2=as.numeric(V2))


# summarise if same website/V1 name
db_sum <- db_clean %>% mutate(V1=gsub("(^http://)|(^https://)|(/$)","",V1),
                              V1=ifelse(!grepl("^www\\.",V1),paste0("www.",V1),V1)) %>%
  group_by(V1) %>% summarise(V2median=median(V2),n=n(),V2sd=sd(V2)) %>%
  mutate(V2=V2median*10,V2median=ceiling(V2median)) %>% select(-V2median)

#Output
# alter to prep files in desired format
db_out<-db_sum %>% select(V1,V2)
n <- db_out$V1
db_out <- as.data.frame(t(db_out[,-1]))
colnames(db_out) <- n
str(db_out) # Check the column types
rownames(db_out) <- NULL

# save to json
library(jsonlite)
toJSON(db_out,pretty=TRUE)


