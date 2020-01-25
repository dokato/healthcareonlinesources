div(class = 'container',
   # div(class = 'col-sm-2'),
    div(#class = 'col-sm-8',
        radioButtons("who", "1. Do you know who wrote this?",
                     c("Yes" = "Yes",
                       "Somewhat" = "Somewhat",
                       "No" = "No",
                       "Not Applicable/Don't Know" = "NA"), inline=TRUE,
                     selected = "NA"),
        
        
        radioButtons("current", "2. Is this current?",
                     c("Yes" = "Yes",
                       "Somewhat" = "Somewhat",
                       "No" = "No",
                       "Not Applicable/Don't Know" = "NA"), inline=TRUE,
                     selected = "NA"), 
        
        radioButtons("research", "3. Is this information backed up by research?",
                     c("Yes" = "Yes",
                       "Somewhat" = "Somewhat",
                       "No" = "No",
                       "Not Applicable/Don't Know" = "NA"), inline=TRUE,
                     selected = "NA"), 
        
        actionButton("block_two", "Next"),
        br()
    )
)