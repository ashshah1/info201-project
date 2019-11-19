# the UI for the shiny app

library("shiny")
library("shinythemes")

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

visualize_one <- tabPanel(
  "Weather and Crime Map",
  fluidRow(
    column(4,
      h2("What this means"),
      p("explanation of the visualization...")
    ),
    column(5,
      h2("Visualization One"),
      textOutput("date")
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
        choices = c("None", "Rain", "Thunder", "Wind", "Snow")
      ),
      sliderInput(
        inputId = "temperature",
        label = paste("Select the Max Temperature (only applies when ",
                      "\"None\" is selected)"),
        min = -10,
        max = 110,
        value = 60
      )
    )
  )
)

visualize_two <- tabPanel(
  "Correlations",
  fluidRow(
    column(4,
           h2("What this means"),
           p("explanation of the visualization...")
    ),
    column(5,
           h2("Visualization Two"),
           p("This is a visualization where the temperature is represented",
             "by a line and the crime rate is also represented by a line",
             "(plotted on a two-dimensional graph). Toggling the city will",
             "give you a new city's data and toggling the month will show",
             "the information for that specific time frame.")
    ),
    column(3,
           radioButtons(
             inputId = "city",
             label = "Select a City",
             choices = c("Seattle", "Denver", "Chicago", "Austin", "Boston")
           ),
           selectInput(
             inputId = "months",
             label = "Select a month",
             choices = c("January", "February", "March", "April", "May",
                         "June", "July", "August", "September", "October",
                         "November", "December")
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

my_ui <- navbarPage(theme = shinytheme("superhero"),
  "Skyfall",
  background,
  visualize_one,
  visualize_two,
  conclusion,
  tech,
  about_us
)