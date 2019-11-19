# server for the shiny app
source("data_handling.R")

my_server <- function(input, output) {
  output$date <- renderText(weather_data(input$city, input$weather,
                                         input$temperature))
}