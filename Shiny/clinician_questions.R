div(class = 'container',
    div(class = 'col-sm-2'),
    div(class = 'col-sm-8',
        radioButtons("bias", "1. Is there a conflict of interest that might bias the information provided?",
                     c("Yes" = "2",
                       "Somewhat" = "1",
                       "No" = "0",
                       "Not Applicable/Don't Know" = "NA"), inline=TRUE,
                     selected = "NA"),
        radioButtons("clear", "2. Is the health advice clear and easy to understand?",
                     c("Yes" = "2",
                       "Somewhat" = "1",
                       "No" = "0",
                       "Not Applicable/Don't Know" = "NA"), inline=TRUE,
                     selected = "NA"),
        radioButtons("evidence", "3. Is the information supported by relevant evidence?",
                     c("Yes" = "2",
                       "Somewhat" = "1",
                       "No" = "0",
                       "Not Applicable/Don't Know" = "NA"), inline=TRUE,
                     selected = "NA"),
        radioButtons("when", "4. Are the sources up-to-date?",
                     c("Yes" = "2",
                       "Somewhat" = "1",
                       "No" = "0",
                       "Not Applicable/Don't Know" = "NA"), inline=TRUE,
                     selected = "NA"),
        radioButtons("uncertainty", "7. Does it refer to areas of uncertainty?",
                     c("Yes" = "2",
                       "Somewhat" = "1",
                       "No" = "0",
                       "Not Applicable/Don't Know" = "NA"), inline=TRUE,
                     selected = "NA"),
        textInput("password",
                  "Medical experts must provide a password to submit."
        ),
        br()
    )
)