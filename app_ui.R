# the UI for the shiny app

library("shiny")
library("shinythemes")
library("leaflet")
library("ggplot2")
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
    p("Which cities have the largest correlation between weather and crime"),
    h2("Technical Report"), 
    a(href = "https://github.com/ashshah1/info201-project/wiki/Technical-Report", "click here")
  )
)

visualize_one <- tabPanel(
  "Weather and Crime Map",
  fluidRow(
    column(4,
      h2("What this means"),
      p("This map shows the chosen city and its geographical location. ",
        "In addition, the type of weather is selected (or a temperature). ",
        "Once the user toggles the preferences, a map showing infringements",
        "in the location is shown. The number of markers indicates how much ",
        "crime occurred under those conditions.")
    ),
    column(5,
      h2("Crime Hot Spots"),
      leafletOutput("leaf_map"),
    ),
    column(3,
      radioButtons(
        inputId = "city",
        label = "Select a City",
        choices = c("Denver", "Chicago", "Austin", "Boston")
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
           p("This visualization shows two plots. The first plot represents",
             "the average temperature in a chosen city in each month",
             "of the year. Directly below this graph is a plot representing",
             "the amount of infringements of a certain crime, in a specified",
             "month in a chosen city."),
           p(""),
           p("The user can visually identify the correlation between",
             "the amount of offenses with temperature increases and ",
             "decreases. Different crime types may reveal a worse or ",
             "stronger connection between the two factors.")
    ),
    column(5,
           h2("Temperature vs Crime"),
           plotOutput("temp_plot"),
           plotOutput("crime_plot")
    ),
    column(3,
           radioButtons(
             inputId = "city_two",
             label = "Select a City",
             choices = c("Denver", "Chicago", "Austin", "Boston")
           ),
           selectInput(
             inputId = "crime",
             label = "Select a crime type",
             choices = c("Aggravated Assault", "Burglary", "Drug Related")
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
  "The Data",
  titlePanel("About the Data"),
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