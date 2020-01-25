div(class = 'container',
    div(class = 'col-sm-2'),
    div(class = 'col-sm-8',
        radioButtons("question1", "Are you a clinician or a patient?: ", choices = c("Clinicial", "Patient")),
        actionButton("block_two", "Next"),
        br()
    )
)

div(class = 'container',
    div(class = 'col-sm-2'),
    div(class = 'col-sm-8',
        radioButtons("question2", "Please select a color: ", choices = c("Blue", "Orange", "Red")),
        #actionButton("block_three", "Next"),
        br()
    )
)