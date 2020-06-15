library(shiny)
library(shinythemes)
library(shinycssloaders)
library(httr)


options(shiny.sanitize.errors = FALSE)

credits <- "Created by Nia Campbell, Tom Chambers, Alisha Davies, Katriona Goldmann, Mark James, Dominik Krzemiński @ NHSHackDay Cardiff 2020"

content_of_info <- source("landing.R", local = TRUE)$value

shinyUI(tagList(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  ),
  navbarPage(title = "WHAT",
   tabPanel("Info",
      fluidPage(
        content_of_info
      )
   ),
   tabPanel("Website annotation",
            tagList(
              fluidPage(
                div(align = "center",
                    p("Thank you for helping us to score websites for medical advice!"),
                    actionButton("block_one", "START SCORING")
                ),
                uiOutput("block_one"),
                div(class = 'col-sm-2'),
                div(align = "center", class = 'col-sm-8',
                    tagList(
                      withSpinner(
                        htmlOutput("exist")
                      ), br(),
                      htmlOutput("secure"), br(),
                      htmlOutput("tld"), br()
                    )
                ),
                uiOutput("block_two"),
                div(align = "center",
                    htmlOutput("score"), 
                    conditionalPanel(
                      condition = "input.block_two",
                      actionButton("load_up", "Submit")
                    )
                ),
                br(),br(),br(),br()
              )
            ), id = 'annotations'
   ),
   tabPanel("Plugin",
     fluidPage(
       div(align = "center",
           p("Download from Chrome Web Store"),
           tags$b(tags$a(href="https://chrome.google.com/webstore/detail/what/maoedkipekbhpphphjmnmoccdgkkahfn",
                  "+ Add WHAT to CHROME +",
                  target="_blank")),
           p("or from Firefox Add-ons market"),
           tags$b(tags$a(href="https://addons.mozilla.org/en-GB/firefox/addon/what/",
                         "+ Add WHAT to Firefox +",
                         target="_blank")),
              br(), br(), tags$img(src="plugin.png")
       )
     )
   ),
   header = uiOutput("home"),
   footer = tags$footer(credits, align = "center", style = "
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
))
