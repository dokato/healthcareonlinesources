library(shiny)
library(shinythemes)
library(shinycssloaders)
library(httr)


options(shiny.sanitize.errors = FALSE)

credits <- "Created by ... @ NHSHackDay Cardiff 2020"

shinyUI(
  tagList(
        fluidPage(
            uiOutput("home"),
            uiOutput("block_one"),
            div(class = 'col-sm-2'),
            div(align = "center", class = 'col-sm-8',
              tagList(
                
                htmlOutput("exist"), br(),
                htmlOutput("secure"), br(),
                htmlOutput("tld"), br(),
                htmlOutput("update"), br()
              )
            ),
            uiOutput("block_two"),
            div(align = "center",
              htmlOutput("score"), 
              actionButton("load_up", "Submit")
            ),
            
            br(),br(),br(),br()
    ),
    tags$footer(credits, align = "center", style = "
      position:fixed;
      bottom:0;
      right:0;
      left:0;
      background:black;
      color: white;
      padding:10px;
      box-sizing:border-box;
      z-index: 1000;")
  )
)