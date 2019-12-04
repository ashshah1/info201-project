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
    p("We intend to study crime patterns in large cities and see if there
      is a correlation between crime statistics and weather patterns. 
      Both crime and weather are broad, umbrella terms encompassing
      a large array of items, we want to narrow down on these and focus 
      on specific crimes and their frequencies in harsher weather conditions, 
      such as storms and heavy snowfall, as opposed to their rates during 
      other seasons."),
    p(""),
    p("1. At what temperature does crime rise and fall?"),
    p("2. Which types of crimes are most impacted by weather?"),
    p("3. Which cities have the largest correlation between weather and crime?"),
    h2("Technical Report"),
    a(href =
        "https://github.com/ashshah1/info201-project/wiki/Technical-Report",
      "click here")
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
      leafletOutput("leaf_map")
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
  p("We intended to study this concepts by analyzing the data through 
    two visualizations."),
  p(""),
  p("The first was a heat map. It was harder to analyze 
    this one and identify clear differences because of the 
    sheer amount of crime so it seemed to be about the same 
    despite filtering for different weather conditions. There are
    some visible differences in density, while these may be smaller, 
    they are still there."),
  p(""),
  p("For example, this is a map of Chicago’s crime at 10 degrees Fahrenheit.
    And to contrast it, to the right is a map of Chicago at 90 degrees 
    Fahrenheit"),
  p(""),
  tags$img(src = 'chicago-cold.png', height = "50%", width = "50%", 
           align = "left"),
  tags$img(src = 'chicago-hot.png', height = "50%", width = "50%",
           align = "right"),
  p(""),
  p("While the difference are less obvious, they still exist."),
  p("For the most part, the heat maps proved to be a good way to analyze
    the data and look at it through a different lens but made it harder
    to draw concrete conclusions and only let us look at correlational data."),
  p(""),
  p("The second set of visualizations, compared crime in each 
    of the cities with the month of the year."),
  p(""),
  p("This let us clearly visualize a seasonal rise and fall 
    in the crime levels, which could be attributed to the weather."),
  p("While we cannot make a causal connection between the two, we noticed
    strong connections and similarities between graphs that compared crime
    and time, and time and weather. "),
  p("One of the graphs we analyzed had a clear rise in crime rates
    in the months May to July in Boston, a significant jump 
    from previous months. The average temperatures during those months
    was about 85 degrees."),
  p(""),
  p("This tells us that crime rates tend to spike during times of warmer weather
    and fall during times of colder weather. This answers our first research
    question, to an extent. We wanted to study at what temperature crime rises
    and falls. While it was hard, impossible even, to pinpoint the exact
    temperature, we were able to get an idea that crime tended to spike
    during the summer months. "),
  p(""),
  p("In conclusion, while we were not able to concretely answer our 
    original questions, we explored each of them through data manipulation and
    visualization and were able to see correlational relationships between
    weather and crime.")
)

tech <- tabPanel(
  "The Tech",
  titlePanel("About the Tech and Data"),
  h3("The Data"),
  p("We used 8 different data sets in this project. 4 contained data
    about the crime levels, prevalance, location, and time of various reported
    crime incidents in the four chosen cities. We also had 4 different weather data
    sets that contained temperature, date, and information about specific weather
    conditions such as precipitation and snow."),
  p(""),
  h3("The Tech"),
  p("To complete this project we used both RStudio (incorporating the 
    use of various libariries such a dplyr and leaflet) 
    and the Shiny application. ")
)

about_us <- tabPanel(
  "About Us",
  h3("Bradley Wilson"),
  p("Statistics: Data Science '22"),
  p("In this project I have been working on the shiny app and developing
    visualizations for the project. The hardest part is learning as I go,
    and developing new ways to visualize data. Shiny can be difficult to
    understand without prior knowledge, but it became understandable as 
    I worked on it more and more. A struggle was making the visualizations
    easy to understand from a user’s perspective. This was overcome by
    getting an outsider perspective and developing for a user with limited 
    knowledge. Working within a team on a coding project is a new experience,
    but I am definitely ready for the challenge. We have worked well 
    and divided up the work efficiently and I feel comfortable with how 
    this project went. Everyone did their fair share and 
    communicated effectively."),
  h3("Ash Shah"),
  p("Psychology & Intended Informatics '21"),
  p("When we first started this project, I imagined the design and coding 
    itself to be the hardest part. I learned along the way that almost 
    every small step contributes to the final piece and carries with it
    its own unique challenges. This project forced me to think a little 
    more creatively about how I solve problems since one single line of
    code affects more than just the output to a console and has a larger 
    impact on the overall project. I worked primarily on data wrangling since
    we had four very large crime datasets that had to be cleaned and 
    standardized to be plotted. Additionally, I worked on the technical 
    report and addressing the research questions. Overall, this assignment
    did well in having us work a little more cohesively since each subsequent 
    section only worked if the last part was functional and that comes 
    from learning to work together."),
  h3("Allesandra Quevedo"),
  p("Intended Informatics HCI '21"),
  p("In this project I have learned that creating data visualizations with 
    R is not as hard as I initially thought. The only part that was the
    most challenging initially, was the data wrangling portion of the 
    raw data sets. Once we learned how to push the data up to GitHub, 
    working with the consolidated data sets was much easier. This project
    has stretched my identity, and I find myself identifying as a coder 
    and an innovator, whereas in other projects I have mostly been a
    leader or designer. This project has taught me what problem-solving
    processes developers and coders undergo in tackling an ambiguous 
    problem to solve. In the future, I would love to explore more cities
    around the United States, and to compare that by region and/or state. ")
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