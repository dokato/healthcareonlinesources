library(shiny)
library(RCurl)
library(ggpubr)

options(shiny.sanitize.errors = FALSE)

shinyServer(function(input, output, session) {
    
    output$home <- renderUI({
        div(class = 'container', id = "home",
            div(class = 'col-sm-2'),
            div(class = 'col-sm-8',
                h1("WHaT!"),
                p("Websites for Health Assesment Tool"),
                br(),
                textInput("website", "Website", placeholder="Enter a webpage"),
                actionButton("block_one", "Start")
            ))
    })
    
    observeEvent(input$block_one, {
        output$block_one <- renderUI({ source("questions1.R", local = TRUE)$value })
    })
    
    observeEvent(input$block_two, {
        output$block_two <- renderUI({ source("question1.R", local = TRUE)$value })
    })
    
    
    
    # webtext <- eventReactive(input$goButton, {
    #     input$website
    # })
    # 
    # output$exist = renderText({
    #     
    #     site = webtext()
    #     if(url.exists(site)){
    #         out_text = paste("<font color=\"#0BB147\"><b>", site, "website exists, hooray!", "</b></font>")
    #     } else{ out_text = paste("<font color=\"#DE4A2B\"><b>", site, "is not a valid website!", "</b></font>")}
    #     
    #     
    # })
})


# 
# shinyServer(function(input, output, session) {
# 
#     webtext <- eventReactive(input$goButton, {
#         input$website
#     })
# 
#     output$exist = renderText({
# 
#         site = webtext()
#         if(url.exists(site)){
#             out_text = paste("<font color=\"#0BB147\"><b>", site, "website exists, hooray!", "</b></font>")
#         } else{ out_text = paste("<font color=\"#DE4A2B\"><b>", site, "is not a valid website!", "</b></font>")}
# 
# 
#     })
# 
# 
#     output$secure = renderText({
# 
#         site = webtext()
#         if(url.exists(paste0("https://", site))){
#             out_text = paste("<font color=\"#0BB147\"><b>", site, "is secure  (https available)", "</b></font>")
#         } else{ out_text = paste("<font color=\"#DE4A2B\"><b>", site, "is not a secure  (https unavailable)", "</b></font>")}
# 
# 
#     })
# 
#     output$tld = renderText({
#         site = webtext()
#         good_tlds = c("uk", "gov", "org", "edu")
#         bad_tlds = c("com")
#         tld = strsplit(site, split="\\.")[[1]]
#         tld = gsub("\\/.*", "", tld[length(tld)])
#         if(tld %in% good_tlds){
#             out_text = paste0(
#                 "<font color=\"#0BB147\"><b>",
#                 site,
#                 " has top domain level '.",
#                 tld,
#                 "' thats good", "</b></font>")
#         } else if(tld %in% bad_tlds){out_text = paste0(
#             "<font color=\"#DE4A2B\"><b>",
#             site,
#             " has top domain level '.",
#             tld,
#             "' that is bad.", "</b></font>")
#         } else{out_text = paste0(
#             "<font color=\"#EFBD0D\"><b>",
#             site,
#             " has top domain level '.",
#             tld,
#             "' that is not ideal, we like uk, gov, org etc.", "</b></font>")}
# 
#     })
# 
# 
#     output$update = renderText({
# 
#         site = webtext()
#         header = HEAD(site)
#         cache = cache_info(header)
#         print(as.character(cache$modified) )
#         if(length(as.character(cache$modified)) > 0){
#             dat = unlist(strsplit(as.character(cache$modified), split=" "))
#             dat = strptime(dat[1], format = "%Y-%m-%d")
#             print(dat)
#             difft = abs(difftime(dat, Sys.Date(), units="weeks"))
# 
#             if(difft < 365.25){
#                 out_text = paste0("<font color=\"#0BB147\"><b>", site,
#                                   " has been updated in the last 12 months (last modified: ", d, ")", "</b></font>")
#             } else if(difft < 365.25*5){
#                 out_text = paste0("<font color=\"#EFBD0D\"><b>", site,
#                                   " has been updated in the last 5 years (last modified: ", d, ")", "</b></font>")
# 
#             } else{ out_text = paste("<font color=\"#DE4A2B\"><b>", site, "was last modified over 5 years ago", "</b></font>")}
# 
#         } else{out_text = paste("<font color=\"#DE4A2B\"><b>", site, "had no modification date in html header", "</b></font>")}
#     })
#     temp
# 
# 
# 
# 
# })
