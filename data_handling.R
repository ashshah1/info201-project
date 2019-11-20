# Manipulating the raw data to get it in a readable format
# that we can use for our visualizations and conclusions.
library("dplyr")
library("tidyr")

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


# Cleaning up the Austin crime dataset

austin_crime_raw <- read.csv("austin.csv", stringsAsFactors = FALSE) 

austin_crime <- austin_crime_raw %>% 
  mutate(Date = format(as.Date(Occurred.Date, "%m/%d/%Y"))) %>% 
  select(Highest.Offense.Description, Incident.Number, Longitude, 
         Latitude, Date) %>% 
  rename(ID = Incident.Number, Offense_Type = Highest.Offense.Description)

write.csv(austin_crime, file = "datasets/austin_crime.csv")


# Cleaning up the Denver dataset

denver_crime_raw <- read.csv("denver.csv", stringsAsFactors = FALSE)

denver_crime <- denver_crime_raw %>% 
  mutate(occurred_on = FIRST_OCCURRENCE_DATE) %>% 
  separate(FIRST_OCCURRENCE_DATE, c("m", "d", "year")) %>% 
  filter(year == "18") %>% 
  filter(IS_CRIME == 1) %>% 
  mutate(Date = format(as.Date(occurred_on, "%m/%d/%y"))) %>% 
  select(INCIDENT_ID, OFFENSE_CATEGORY_ID, GEO_LON, GEO_LAT, Date) %>% 
  rename(ID = INCIDENT_ID, Offense_Type =  OFFENSE_CATEGORY_ID, 
         Longitude = GEO_LON, Latitude = GEO_LAT)

write.csv(denver_crime, file = "datasets/denver_crime.csv")

