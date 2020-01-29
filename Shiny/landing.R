div(class = 'container',
  div(class = 'col-sm-2'),
  div(class = 'col-sm-8',
    div(class="post-container",
      img(src="question.jpg"),
      h2("Motivation"),
      p("According to Office National Statistics 54% people in the UK are looking for health related information online."),
      p("The figures vary worldwide, but in USA it might be even 80% according to NBC."),
      p("Check this",
        tags$a(href="https://www.nature.com/news/2004/040802/full/040802-3.html",
        "Nature", target="_blank"), "article if you want to learn more."
      )
    ),
    br(),
    div(class="post-container-middle",
        img(src="medical.png"),
        h2("Trust"),
        p("Not all the medical information sources can be trusted!"),
        p(tags$b("This project aims to raise awareness of healthcare online safety.")),
        p("1) We create repository of trustful sources."),
        p(tags$b("!!! Help us by visiting 'Website annotation' panel")),
        p("2) We provide browser plug-in that warns against untrusted information sources.")
    ),
    br(),
    div(class="post-container",
        img(src="security.jpg"),
        h2("Implementation"),
        p("The project was made at NHS Hack Day in Cardiff in January 2020."),
        p("For more information visit this website:"),
        tags$a(href="https://nhshackday.com/projects/23-cardiff/what",
               "https://nhshackday.com/projects/23-cardiff/what",
               target="_blank")
    ), br(),br(),br(),br()
  )
)