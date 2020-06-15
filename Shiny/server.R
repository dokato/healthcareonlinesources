library(shiny)
library(shinythemes)
library(RCurl)
library(ggpubr)
library(glue)
library(mongolite)

options(shiny.sanitize.errors = FALSE)
############
# HERE SET ALL THE OPTIONS NEEDED FOR DEPLOY: mongo_password, what_password

############

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

submitted_modal <- function(){
  modalDialog(
    title = "Submitted!",
    "Thank you",
    easyClose = TRUE,
    footer = NULL
  )
}

verify_modal <- function(){
  modalDialog(
    title = "You need to verify!",
    p("You need to verify to be able to submit as a healthcare professional."),
    p("If you think you are eligible, please drop us an email:"),
    p(tags$b("WHAThealthonline@gmail.com")),
    p("asking for access."),
    easyClose = TRUE,
    footer = NULL
  )
}

shinyServer(function(input, output, session) {
    
    output$home <- renderUI({
        div(class = 'container', id = "home",
            div(class = 'col-sm-2'),
            div(class = 'col-sm-8',
                h1("Websites for Health Assessment Tool",
                   img(src="logo.png", height="32"))
            ), br(), br())
    })
    
    observeEvent(input$block_one, {
        output$block_one <- renderUI({
          source("questions1.R", local = TRUE)$value
        })
    })

    observeEvent(input$load_up, {
      if (input$professional == "Yes") {
        if (input$password != options()$what_password) {
          showModal(verify_modal())
        } else {
          save_data(c(input$website, input$slider, input$professional))
          showModal(submitted_modal())
        }
      } else {
        save_data(c(input$website, input$slider, input$professional))
        showModal(submitted_modal())
      }
    })
    
    webtext <- eventReactive(input$block_two, {
        req(input$website != "")
        input$website
    })
    
    output$exist = renderText({
        req(input$website != "")
        site = webtext()
        if(grepl("http", site)) site = gsub("https://|http://", "", site)
        if(url.exists(site)){
            out_text = glue("<font color=\"#0BB147\"><b>{site} website exists</b></font>")
        } else {
          out_text = glue("<font color=\"#DE4A2B\"><b>{site} does not appear to be a valid website!</b></font>")
        }
    })
    
    output$secure = renderText({
        site = webtext()
        req(url.exists(site))
        if(grepl("http", site))
          site = gsub("https://|http://", "", site)
        if(url.exists(paste0("https://", site))){
            out_text = glue("<font color=\"#0BB147\"><b>{site} is secure  (https available)</b></font>")
        } else {
          out_text = glue("<font color=\"#DE4A2B\"><b>{site} is not secure  (https unavailable)</b></font>")
        }
    })
    
    output$tld = renderText({
        site = webtext()
        req(url.exists(site))
        good_tlds = c("gov", "org", "edu")
        tld = strsplit(site, split="\\.")[[1]]
        tld = gsub("\\/.*", "", tld[length(tld)])
        if(tld %in% good_tlds){
            out_text = paste0(
                "<font color=\"#0BB147\"><b>",
                site,
                " has top domain level '.",
                tld,
                "' which is recommended", "</b></font>")
        } else{out_text = paste0(
            "<font color=\"#EFBD0D\"><b>",
            site,
            " has top domain level '.",
            tld)}
        
    })
    
    observeEvent(input$block_two, {
      req(url.exists(webtext()))
      file <- ifelse(as.character(input$professional) == "Yes",
                     "clinician_questions.R",
                     "patient_questions.R")
      output$block_two <- renderUI({ source(file, local = TRUE)$value })
    })
    
    
    output$score <- renderUI({
        req(webtext() != "")
        if(input$professional == "Yes"){
            score_list = c(as.numeric(input$aims) ,
                           as.numeric(as.character(input$achieve)) ,
                           as.numeric(input$references), 
                           as.numeric(input$when ) ,
                           as.numeric(input$biased), 
                           as.numeric(input$sources), 
                           as.numeric(input$uncertainty)
            )
            score_list = score_list[! is.na(score_list)]
            print(score_list)
            subjective_score = mean(score_list, na.rm=T)
        } else {    
            score_list = c(as.numeric(input$who) ,
                           as.numeric(input$current) ,
                           as.numeric(input$research))
            score_list = score_list[! is.na(score_list)]
            
            subjective_score = mean(score_list)
        }
        automatic_score = subjective_score/2
        
        if(is.na(automatic_score)) automatic_score = 0
        
        tagList(tags$p("Suggested score: "),
                tags$h4(format(automatic_score, digits=2)),
                tags$p("But you can use your own judgement!"),
                sliderInput("slider",
                            "Please give a rating from 0 to 1 (0 being unreliable and 1 being trustworthy)",
                            0, 1, automatic_score, width = "50%" ))
    })
    
})
