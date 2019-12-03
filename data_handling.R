# Manipulating the raw data to get it in a readable format
# that we can use for our visualizations and conclusions.
library("dplyr")
library("tidyr")
library("leaflet")
library("ggplot2")
library("stringr")
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

# Returns a plot representing the average temperature each month over a 
# year-long period (2018) of time.
temp_plot <- function(city, crime) {
  queryw <- paste("datasets/WeatherData_", city, ".csv", sep = "")
  weather_raw <- read.csv(queryw, stringsAsFactors = FALSE)
  weather <- weather_raw %>%
    filter(!is.na(TMAX) & !is.na(TMIN)) %>%
    filter(substr(NAME, 1, 3) == toupper(substr(city, 1, 3))) %>%
    distinct(DATE, .keep_all = TRUE) %>%
    mutate(month_col = months(as.Date(DATE))) %>%
    group_by(month_col) %>%
    summarize(avg_temp = mean(TMAX))
  plot <- ggplot(data = weather, 
                  mapping = aes(x = substr(month_col, 1, 3),
                                y = avg_temp, group = 1)) +
    geom_point() +
    geom_line() +
    scale_x_discrete(limits = month.abb) +
    labs(x = "Month", y = "Avg Temperature")
  return(plot)
}

# Returns a plot of the frequency of a crime type in each month of a year
crime_plot <- function(city, crime) {
  f_one <- ""
  f_two <- ""
  if (identical(crime, "Aggravated Assault")) {
    if (!identical(city, "Chicago")) {
      f_one <- "agg"
    }
    f_two <- "as"
  } else if (identical(crime, "Burglary")) {
    f_two <- "burglary"
  } else if (identical(crime, "Drug Related")) {
    f_two <- "drug"
    if (identical(city, "Chicago")) {
      f_two <- "other"
    }
  }
  queryc <- paste("datasets/", city, "_crime.csv", sep = "")
  crime_raw <- read.csv(queryc, stringsAsFactors = FALSE)
  crime <- crime_raw %>%
    filter(str_detect(tolower(Offense_Type), f_one)) %>%
    filter(str_detect(tolower(Offense_Type), f_two)) %>%
    mutate(month_col = months(as.Date(Date))) %>%
    group_by(month_col) %>%
    summarize(count = n())
  plot <- ggplot(data = crime, mapping = aes(x = substr(month_col, 1, 3),
                                              y = count, group = 1)) +
    geom_point() +
    geom_line() +
    scale_x_discrete(limits = month.abb) +
    labs(x = "Month", y = "Crime Count")
  return(plot)
}

# Creates a bar chart with the frequency of each crime type at a temperature
crime_bar <- function(t_min, t_max) {
  min_min <- t_min[[1]]
  min_max <- t_max[[2]]
  max_min <- t_max[[1]]
  max_max <- t_max[[2]]
  f_one <- "ass"
  f_two <- "burg"
  f_three <- "agg"
  f_four <- "arson"
  queryc <- paste("datasets/", "Chicago", "_crime.csv", sep = "")
  crime_raw <- read.csv(queryc, stringsAsFactors = FALSE)
  queryw <- paste("datasets/WeatherData_", "Chicago", ".csv", sep = "")
  weather_raw <- read.csv(queryw, stringsAsFactors = FALSE)
  weather_days <- weather_raw %>%
    filter(!is.na(TMAX) & !is.na(TMIN)) %>%
    filter(TMAX > max_min & TMAX < max_max) %>%
    filter(TMIN < min_max & TMIN > min_min) %>%
    select(DATE)
  weather_date <- weather_days$DATE
  crime <- crime_raw %>%
    filter(Date %in% weather_date) %>%
    filter(str_detect(tolower(Offense_Type), f_one) |
            str_detect(tolower(Offense_Type), f_two) |
            str_detect(tolower(Offense_Type), f_three) |
            str_detect(tolower(Offense_Type), f_four)) %>%
    group_by(Offense_Type) %>%
    summarize(count = n())
  chart <- ggplot(data = crime) +
    geom_col(mapping = aes(x = Offense_Type, y = count)) +
    ggtitle("Crime Type Frequency") +
    xlab("Crime Type") + ylab("Occurences")
  chart
}
