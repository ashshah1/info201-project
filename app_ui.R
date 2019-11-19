# the UI for the shiny app

library("shiny")

background <- tabPanel(
  "Background",
  titlePanel("Project Information"),
  mainPanel(
    h2("Background Info"),
    p("Crime rate is not a constant, straight line. Just like most",
    " phenomena, crime fluctuates. One day may break record highs,",
    " the next may break record lows. Therefore, in an effort to",
    " minimize crime, one must understand the factors behind its rise",
    " and fall. Toning in on weather patterns and its effect on crime",
    " rate will provide more understanding behind crime deterrences.",
    " The more crime deterrences are understood, the more we can do to",
    " prevent crime from happening."),
    h2("Research Questions"),
    p("At what temperature does crime rise and fall?"),
    p("Which types of crimes are most impacted by weather?"),
    p("Which cities have the largest correlation between weather and crime")
  )
)

visualize <- tabPanel(
  "Visualizations",
  fluidRow(
    column(4,
      navlistPanel(
        tabPanel("Heat Map"),
        tabPanel("Graph")
      )
    ),
    column(5,
      h2("Visualization One"),
      textOutput("city"),
      textOutput("weather"),
      textOutput("temperature")
    ),
    column(3,
      radioButtons(
        inputId = "city",
        label = "Select a City",
        choices = c("Seattle", "Denver", "Chicago", "Austin", "Boston")
      ),
      radioButtons(
        inputId = "weather",
        label = "Type of Weather",
        choices = c("All Types", "Rain", "Sun", "Wind", "Snow")
      ),
      sliderInput(
        inputId = "temperature",
        label = "Select Temperature",
        min = -10,
        max = 110,
        value = c(50,70)
      )
    )
  )
)

conclusion <- tabPanel(
  "Conclusion",
  titlePanel("The Results"),
  p("Here is what we found...")
)

tech <- tabPanel(
  "The Tech",
  titlePanel("About the Tech"),
  p("Information about the tech that we used...")
)

about_us <- tabPanel(
  "About Us",
  h3("Bradley Wilson"),
  p("Bradley did this and this and this..."),
  h3("Ashni Shah"),
  p("Ash did this and this and this..."),
  h3("Allesandra Quevedo"),
  p("Allesandra did this and this and this...")
)

my_ui <- navbarPage(
  "Skyfall",
  background,
  visualize,
  conclusion,
  tech,
  about_us
)