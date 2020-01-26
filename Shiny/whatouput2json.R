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
db_out <- db_clean %>% mutate(V1=gsub("(^http://)|(^https://)|(/$)","",V1),
                              V1=ifelse(!grepl("^www\\.",V1),paste0("www.",V1),V1)) %>%
  group_by(V1) %>% summarise(V2=median(V2),n=n(),sd=sd(V2)) %>%
  mutate(V2=V2*10,V2=ceiling(V2))

#Output
library(jsonlite)
toJSON(db_out %>% select(V1,V2), pretty=TRUE)

