# server for the shiny app
source("data_handling.R")

my_server <- function(input, output) {
  output$leaf_map <- renderLeaflet(crimemap(input$city, 
                                        weather_data(input$city, input$weather,
                                        input$temperature)))
  
  output$temp_plot <- renderPlot(temp_plot(input$city_two, input$crime))
}