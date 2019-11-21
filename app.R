# deploying the shiny app
library(shiny)
library(leaflet)
library(ggplot2)
source("app_ui.R")
source("app_server.R")
shinyApp(ui = my_ui, server = my_server)