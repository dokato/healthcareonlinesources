div(class = 'container',
    div(class = 'col-sm-2'),
    div(class = 'col-sm-8',
        radioButtons("web_question", "Are you a clinician or a patient?: ", choices = c("Clinicial", "Patient")),
        actionButton("web_block", "Next"),
        br()
        # textInput("website", "Website", placeholder="Enter a webpage"),
        # #output$block_one <- renderUI({ source("questions1.R", local = TRUE)$value })
        # actionButton("block", "Start"),
        # br()
    )
)