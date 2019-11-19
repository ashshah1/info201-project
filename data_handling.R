# Manipulating the raw data to get it in a readable format
# that we can use for our visualizations and conclusions.
library("dplyr")

weather_data <- function(city, weather, temp){
  query <- paste("datasets/WeatherData_", city, ".csv", sep = "")
  weather_raw <- read.csv(query, stringsAsFactors = FALSE)
  weather_raw <- within(weather_raw, rm(WT01, WT02, WT04))
  weather_result <- weather_raw %>%
    filter(!is.na(TMAX) & !is.na(TMIN)) %>%
    filter(substr(NAME, 1,3) == toupper(substr(city, 1, 3)))
  if (identical(weather, "Rain")) {
    weather_find <- weather_result %>%
      filter(PRCP == max(PRCP, na.rm = TRUE)) %>%
      pull(DATE)
  } else if (identical(weather, "Wind")) {
    weather_find <- weather_result %>%
      filter(AWND == max(AWND, na.rm = TRUE)) %>%
      pull(DATE)
  } else if (identical(weather, "Snow")) {
    weather_find <- weather_result %>%
      filter(SNOW == max(SNOW, na.rm = TRUE)) %>%
      pull(DATE)
  } else if (identical(weather, "Thunder")) {
    weather_find <- weather_result %>%
      filter(WT03 != 0) %>%
      filter(AWND == max(AWND, na.rm = TRUE)) %>%
      filter(PRCP == max(PRCP, na.rm = TRUE)) %>%
      pull(DATE)
  } else if (identical(weather, "None")) {
    weather_find <- weather_result %>%
      mutate(close = (temp - TMAX)) %>%
      filter(close == min(abs(close), na.rm = TRUE)) %>%
      filter(PRCP == min(PRCP, na.rm = TRUE)) %>%
      slice(1) %>%
      pull(DATE)
  }
  weather_find
}