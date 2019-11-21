# Manipulating the raw data to get it in a readable format
# that we can use for our visualizations and conclusions.
library("dplyr")
library("tidyr")
library("leaflet")
library("ggplot2")

#------------------------------------------------------------------------------
# Retrieve dates under the correct conditions of: 
# City, Weather type, and the max temperature.
# Returns string of dates.
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
      mutate(close = abs(temp - TMAX)) %>%
      filter(close == min(close, na.rm = TRUE)) %>%
      filter(PRCP == min(PRCP, na.rm = TRUE)) %>%
      slice(1) %>%
      pull(DATE)
  }
  weather_find
}

# Returns a leaflet map of a specified city, showing crime on the
# specified date.
crimemap <- function(city, date) {
  if (identical(substr(city, 1, 3), "Sea")) {
    lng = -122.3321
    lat = 47.6062
  } else if (identical(substr(city, 1, 3), "Chi")) {
    lng = -87.6298
    lat = 41.8781
  } else if (identical(substr(city, 1, 3), "Den")) {
    lng = -104.9903
    lat = 39.7392
  } else if (identical(substr(city, 1, 3), "Bos")) {
    lng = -71.0589
    lat = 42.3601
  } else if (identical(substr(city, 1, 3), "Aus")) {
    lng = -97.7431
    lat = 30.2672
  }
  crime_data <- read.csv(paste("datasets/", tolower(city), "_crime.csv", sep = ""),
                         stringsAsFactors = FALSE)
  crime_data <- na.omit(crime_data)
  crime_data <- crime_data %>%
    filter(Date == date)
  map <- leaflet(data = crime_data) %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(lng = lng, lat = lat, zoom = 10) %>%
    addCircles(
      lng = crime_data$Longitude,
      lat = crime_data$Latitude,
      stroke = FALSE,
      popup = paste(
        crime_data$Offense_Type, "<br>", crime_data$Date
        ),
      fillOpacity = 0.5,
      radius = 500
    )
  return(map)
}

# Returns a plot representing the temperature and specific crime type rates
# over a year long period (2018).
temp_plot <- function(city, crime) {
  query <- paste("datasets/WeatherData_", city, ".csv", sep = "")
  weather_raw <- read.csv(query, stringsAsFactors = FALSE)
  weather <- weather_raw %>%
    filter(!is.na(TMAX) & !is.na(TMIN)) %>%
    filter(substr(NAME, 1, 3) == toupper(substr(city, 1, 3))) %>%
    distinct(DATE, .keep_all = TRUE) %>%
    mutate(month_col = months(as.Date(DATE))) %>%
    group_by(month_col) %>%
    summarize(avg_temp = mean(TMAX))
  temps <- ggplot(data = weather) +
    geom_point(mapping = aes(x = substr(month_col, 1, 3), y = avg_temp)) +
    scale_x_discrete(limits = month.abb) +
    labs(x = "Month", y = "Avg Temperature")
  return(temps)
}
