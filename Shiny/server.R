library(shiny)
library(shinythemes)
library(RCurl)
library(ggpubr)
library(glue)
library(mongolite)

options(shiny.sanitize.errors = FALSE)

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

head_style <- "
   text-align: center;
   border-radius: 10px;
   background: black;
   color: burlywood;
   padding: 10px;
   margin: 4px;
   width: 100%;
   font-size: 4em;
   "
head_small_style <- "
   text-align: center;
   border-radius: 10px;
   background: #515151;
   color: white;
   padding: 4px;
   margin: 2px;
   width: 100%;
   font-size: 1em;
   "


shinyServer(function(input, output, session) {
    
    output$home <- renderUI({
        div(class = 'container', id = "home",
            div(class = 'col-sm-2'),
            div(class = 'col-sm-8',
                h1("W  H  A  T ?", style = head_style),
                p("Websites for Health Assesment Tool", style = head_small_style),
                br(),
                actionButton("block_one", "Start")
            ))
    })
    
    observeEvent(input$block_one, {
        output$block_one <- renderUI({ source("questions1.R", local = TRUE)$value })
    })

    
    observeEvent(input$load_up, {
        save_data(c(input$website, input$slider, input$question1))
        showModal(modalDialog(
            title = "Submitted!",
            "Thanks",
            easyClose = TRUE,
            footer = NULL
        ))

        
    })
    
    webtext <- eventReactive(input$block_two, {
        #raw_score(raw_score() + 1)
        req(input$website != "")
        input$website
    })
    
    output$exist = renderText({
        req(input$website != "")
        site = webtext()
        if(grepl("http", site)) site = gsub("https://|http://", "", site)
        if(url.exists(site)){
            out_text = glue("<font color=\"#0BB147\"><b>{site} website exists, hooray!</b></font>")
        } else{ out_text = glue("<font color=\"#DE4A2B\"><b>{site} is not a valid website!</b></font>")}
    })
    
    output$secure = renderText({
        site = webtext()
        req(url.exists(site))
        if(grepl("http", site)) site = gsub("https://|http://", "", site)
        if(url.exists(paste0("https://", site))){
            out_text = glue("<font color=\"#0BB147\"><b>{site} is secure  (https available)</b></font>")
        } else{ out_text = glue("<font color=\"#DE4A2B\"><b>{site} is not a secure  (https unavailable)</b></font>")}
    })
    
    output$tld = renderText({
        site = webtext()
        req(url.exists(site))
        good_tlds = c("uk", "gov", "org", "edu")
        bad_tlds = c("com")
        tld = strsplit(site, split="\\.")[[1]]
        tld = gsub("\\/.*", "", tld[length(tld)])
        if(tld %in% good_tlds){
            out_text = paste0(
                "<font color=\"#0BB147\"><b>",
                site,
                " has top domain level '.",
                tld,
                "' thats good", "</b></font>")
        } else if(tld %in% bad_tlds){out_text = paste0(
            "<font color=\"#DE4A2B\"><b>",
            site,
            " has top domain level '.",
            tld,
            "' that is bad.", "</b></font>")
        } else{out_text = paste0(
            "<font color=\"#EFBD0D\"><b>",
            site,
            " has top domain level '.",
            tld,
            "' that is not ideal, we like uk, gov, org etc.", "</b></font>")}
        
    })
    
    output$update = renderText({
        
        site = webtext()
        req(url.exists(site))
        header = HEAD(site)
        cache = cache_info(header)
        if(length(as.character(cache$modified)) > 0){
            dat = unlist(strsplit(as.character(cache$modified), split=" "))
            dat = strptime(dat[1], format = "%Y-%m-%d")
            difft = abs(difftime(dat, Sys.Date(), units="weeks"))
            
            if(difft < 365.25){
                out_text = glue("<font color=\"#0BB147\"><b>{site} has been updated in the last 12 months (last modified:  {d})</b></font>")
            } else if(difft < 365.25*5){
                out_text = glue("<font color=\"#EFBD0D\"><b>{site} has been updated in the last 5 years (last modified: {d})</b></font>")
                
            } else{ out_text = glue("<font color=\"#DE4A2B\"><b>{site} was last modified over 5 years ago</b></font>")}
            
        } else{out_text = glue("<font color=\"#DE4A2B\"><b>{site} had no modification date in html header</b></font>")}
    })
    
    observeEvent(input$block_two, {
        req(url.exists(webtext()))
        if(as.character(input$question1) == "Yes"){
            file = "clinician_questions.R"
        } else{file = "patient_questions.R"}
        output$block_two <- renderUI({ source(file, local = TRUE)$value })
    })
    
    
    output$score <- renderUI({
        req(webtext() != "")
        if(input$question1 == "Yes"){
            score_list = c(as.numeric(input$aims) ,
                           as.numeric(as.character(input$achieve)) ,
                           #as.numeric(input$relevance) ,
                           as.numeric(input$references), 
                           as.numeric(input$when ) ,
                           as.numeric(input$biased), 
                           as.numeric(input$sources), 
                           as.numeric(input$uncertainty)
            )
            score_list = score_list[! is.na(score_list)]
            print(score_list)
            subjective_score = mean(score_list, na.rm=T)#/length(score_list)# TODO divide by max
        } else {    
            score_list = c(as.numeric(input$who) ,
                           as.numeric(input$current) ,
                           as.numeric(input$research))
            score_list = score_list[! is.na(score_list)]
            
            subjective_score = mean(score_list)#/length(score_list)
        }
        automatic_score = subjective_score/2
        
        if(is.na(automatic_score)) automatic_score = 0
        
        tagList(tags$p("Suggested score: "),
                format(automatic_score, digits=2),
                sliderInput("slider", "Please give a rating from 0 to 1 (0 being trash and 1 being trustworthy)", 0, 1, automatic_score ))
    })
    
})
