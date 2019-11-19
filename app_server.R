# server for the shiny app

my_server <- function(input, output) {
  output$city <- renderText(paste("The city of choice is: ", input$city))
  
  output$weather <- renderText(paste("The weather choice is: ", input$weather))
  
  output$temperature <- renderText(paste("The temp range is: ",
                                         input$temperature[[1]], " to ",
                                         input$temperature[[2]]))
  
}