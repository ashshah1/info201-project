# server for the shiny app
library("leaflet")
source("data_handling.R")

my_server <- function(input, output) {
  output$leaf_map <- renderLeaflet(crimemap(input$city,
                                        weather_data(input$city, input$weather,
                                        input$temperature)))

  output$temp_plot <- renderPlot(temp_plot(input$city_two, input$crime))
  output$crime_plot <- renderPlot(crime_plot(input$city_two, input$crime))
}