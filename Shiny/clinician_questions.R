div(class = 'container',
    div(class = 'col-sm-2'),
    div(class = 'col-sm-8',
        radioButtons("aims", "1. Are the aims clear?",
                     c("Yes" = "2",
                       "Somewhat" = "1",
                       "No" = "0",
                       "Not Applicable/Don't Know" = "NA"), inline=TRUE,
                     selected = "NA"),
        
        radioButtons("achieve", "2. Does it achieve its aims??",
                     c("Yes" = "2",
                       "Somewhat" = "1",
                       "No" = "0",
                       "Not Applicable/Don't Know" = "NA"), inline=TRUE,
                     selected = "NA"),
        
        radioButtons("relevance", "3. Is it relevant?",
                     c("Yes" = "2",
                       "Somewhat" = "1",
                       "No" = "0",
                       "Not Applicable/Don't Know" = "NA"), inline=TRUE,
                     selected = "NA"),
        
        radioButtons("references", "4. Is it clear what sources of information were used to compile the publication (other than the author or producer)?",
                     c("Yes" = "2",
                       "Somewhat" = "1",
                       "No" = "0",
                       "Not Applicable/Don't Know" = "NA"), inline=TRUE,
                     selected = "NA"),
        
        radioButtons("when", "5. Is it clear when the information used or reported in the publication was produced?",
                     c("Yes" = "2",
                       "Somewhat" = "1",
                       "No" = "0",
                       "Not Applicable/Don't Know" = "NA"), inline=TRUE,
                     selected = "NA"),
        
        radioButtons("biased", "6. Is it balanced and unbiased?",
                     c("Yes" = "2",
                       "Somewhat" = "1",
                       "No" = "0",
                       "Not Applicable/Don't Know" = "NA"), inline=TRUE,
                     selected = "NA"),
        
        
        radioButtons("sources", "7. Does it provide details of additional sources of support and information?",
                     c("Yes" = "2",
                       "Somewhat" = "1",
                       "No" = "0",
                       "Not Applicable/Don't Know" = "NA"), inline=TRUE,
                     selected = "NA"),
        
        
        radioButtons("uncertainty", "8. Does it refer to areas of uncertainty?",
                     c("Yes" = "2",
                       "Somewhat" = "1",
                       "No" = "0",
                       "Not Applicable/Don't Know" = "NA"), inline=TRUE,
                     selected = "NA"), 
        br()
    )
)