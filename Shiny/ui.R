library(shiny)
library(shinythemes)
library(shinycssloaders)
library(httr)


options(shiny.sanitize.errors = FALSE)

shinyUI(
   # navbarPage(
    #    title="Medical Website Trust", theme = shinytheme("yeti"),
        fluidPage(
            uiOutput("home"),
            uiOutput("block_one"),
            uiOutput("block_two")
        )
    #)
)


# shinyUI(
#     navbarPage(
#         title="Medical Website Trust", theme = shinytheme("yeti"),
#         tabPanel("Website", fluidPage(
#             fluidRow(
#             column(6, textInput("website", "Website", placeholder="Enter a webpage")),
#             column(3, br(), actionButton("goButton", "Go!"))
#             ),
#             fluidRow(
#                 verbatimTextOutput("value"),
# 
#             htmlOutput("exist"), br(),
#             htmlOutput("secure"), br(),
#             htmlOutput("tld"), br(),
#             htmlOutput("update"), br(),
#             )
# 
# 
#         )
#         ),
#         
#         tabPanel("Clinicial Questions", fluidPage(
#             
#             fluidRow(
#                 column(6, textInput("clin_website", "Website", placeholder="Enter a webpage"))
#      
#             ),
#             fluidRow(
#                 radioButtons("aims", "1. Are the aims clear?",
#                              c("Yes" = "Yes",
#                                "Somewhat" = "Somewhat",
#                                "No" = "No",
#                                "Not Applicable/Don't Know" = "NA"), inline=TRUE, 
#                              selected = "NA"),
#                 
#                 radioButtons("achieve", "2. Does it achieve its aims?",
#                              c("Yes" = "Yes",
#                                "Somewhat" = "Somewhat",
#                                "No" = "No",
#                                "Not Applicable/Don't Know" = "NA"), inline=TRUE, 
#                              selected = "NA"), 
#                 selected = "Not Applicable/Don't Know",
#                 
#                 radioButtons("relevance", "3. Is it relevant?",
#                              c("Yes" = "Yes",
#                                "Somewhat" = "Somewhat",
#                                "No" = "No",
#                                "Not Applicable/Don't Know" = "NA"), inline=TRUE, 
#                              selected = "NA"),
#                 
#                 radioButtons("references", "4. Is it clear what sources of information were used to compile the publication (other than the author or producer)?",
#                              c("Yes" = "Yes",
#                                "Somewhat" = "Somewhat",
#                                "No" = "No",
#                                "Not Applicable/Don't Know" = "NA"), inline=TRUE, 
#                              selected = "NA"),
#                 
#                 radioButtons("when", "5. Is it clear when the information used or reported in the publication was produced?",
#                              c("Yes" = "Yes",
#                                "Somewhat" = "Somewhat",
#                                "No" = "No",
#                                "Not Applicable/Don't Know" = "NA"), inline=TRUE, 
#                              selected = "NA"),
#  
#                 radioButtons("biased", "6. Is it balanced and unbiased?",
#                              c("Yes" = "Yes",
#                                "Somewhat" = "Somewhat",
#                                "No" = "No",
#                                "Not Applicable/Don't Know" = "NA"), inline=TRUE, 
#                              selected = "NA"),
#                 
#                 
#                 radioButtons("sources", "7. Does it provide details of additional sources of support and information?",
#                              c("Yes" = "Yes",
#                                "Somewhat" = "Somewhat",
#                                "No" = "No",
#                                "Not Applicable/Don't Know" = "NA"), inline=TRUE, 
#                              selected = "NA"),
#                 
#                 
#                 radioButtons("uncertainty", "8. Does it refer to areas of uncertainty?",
#                              c("Yes" = "Yes",
#                                "Somewhat" = "Somewhat",
#                                "No" = "No",
#                                "Not Applicable/Don't Know" = "NA"), inline=TRUE, 
#                              selected = "NA"),
#                 
#                 
#                 column(3, br(), actionButton("submitButton", "Submit!"))
#             )
#             
#             
#         )),
#         
#         
#         tabPanel("Placeholder: Examples", fluidPage(
#             
#             HTML("Example non website: </br>hjfhajkdhasd</br></br>"),
#             HTML("Example secure and working: </br>www.bbc.co.uk</br></br>"),
#             HTML("Non standard: </br>https://www.bbc.co.uk/sport</br></br>"),
#             
#             HTML("Example non-secure website: </br>http://bitcoinist.com</br></br>"), 
#             
#             HTML("Example of an old website: </br>www.spacejam.com</br></br>")
#             
#             
#         ))
#         
#         
#         
#     )
# )
# 
