div(class = 'container',
    div(class = 'col-sm-2'),
    div(class = 'col-sm-8',
        textInput("website", "Website", placeholder="Enter a webpage"),
        radioButtons("professional", "Are you a Healthcare professional?: ",
                     choices = c("Yes", "No"), selected = "No",
                     inline=TRUE),
        actionButton("block_two", "Next / Refresh"),
        br()
    )
)
