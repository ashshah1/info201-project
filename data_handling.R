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


# Dataset Aggregation of Austin, Denver, Boston, Chicago, Seattle crime raw 
# datasets into 5 columns (ID, Date, Offense_Type, Longitude, Latitude) for 2018. 

# Cleaning up the Austin crime dataset. 

# Import .csv file of raw data. 
austin_crime_raw <- read.csv("austin.csv", stringsAsFactors = FALSE) 

# Filter data set and create new formatted 'Date' column. 
austin_crime <- austin_crime_raw %>% 
  mutate(Date = format(as.Date(Occurred.Date, "%m/%d/%Y"))) %>% 
  select(Highest.Offense.Description, Incident.Number, Longitude, 
         Latitude, Date) %>% 
  rename(ID = Incident.Number, Offense_Type = Highest.Offense.Description)

write.csv(austin_crime, file = "datasets/austin_crime.csv")


# Cleaning up the Denver dataset. 
# Import .csv file of raw data. 
denver_crime_raw <- read.csv("denver.csv", stringsAsFactors = FALSE)

# Filter data for 2018 and format new 'Date' column. 
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


# Cleaning up the Boston dataset. 

# Import .csv file of raw data. 
boston_data_raw <- read.csv("boston.csv", stringsAsFactors = FALSE)

# Select 5 columns. 
boston_new <- boston_data_raw %>%
  select(INCIDENT_NUMBER, Long, Lat, OCCURRED_ON_DATE, OFFENSE_DESCRIPTION) %>% 
  rename(ID = INCIDENT_NUMBER, Date = OCCURRED_ON_DATE,
         Offense_Type = OFFENSE_DESCRIPTION, Latitude = Lat, Longitude = Long) %>% 
  mutate(full_date = Date) %>% 
  separate(Date, c("year", "month", "d")) %>% 
  filter(year == "2018") %>% 
  mutate(Date = substr(full_date, 0, 10)) %>% 
  select(Date, Offense_Type, Longitude, Latitude, ID)

write.csv(boston_new, file = "datasets/boston_crime_2.csv")
  

# Format new 'Date' column and filter for 2018 data. 

# boston_df_new <- boston_new %>% 
#   mutate(full_date = Date) %>%
#   separate(Date, c("month", "date", "year")) %>% 
#   filter(year == "2018") %>% 
#   select(full_date, Offense_Type, Longitude, Latitude, ID) %>% 
#   mutate(Date = as.Date(full_date, format = "%m/%d/%Y")) %>%
#   select(Date, Offense_Type, Longitude, Latitude, ID)
# 

# Cleaning up the Chicago dataset. 

# Read .csv file of raw data. 
boston_data_raw <- read.csv("datasets/chicago_crime.csv", stringsAsFactors = FALSE)

# Select 5 columns. 
boston_new <- boston_data_raw %>%
  select(INCIDENT_NUMBER, Long, Lat, OCCURRED_ON_DATE, OFFENSE_DESCRIPTION) %>% 
  rename(ID = "INCIDENT_NUMBER", Date = "OCCURRED_ON_DATE",
         Offense_Type = "OFFENSE_DESCRIPTION", Latitude = "Lat", Longitude = "Long")

# Filter data for 2018 and format a new 'Date' column. 
boston_df_new <- boston_new %>% 
  mutate(full_date = Date) %>%
  separate(Date, c("month", "date", "year")) %>% 
  filter(year == "2018") %>% 
  select(full_date, Offense_Type, Longitude, Latitude, ID) %>% 
  mutate(Date = as.Date(full_date, format = "%m/%d/%Y")) %>%
  select(Date, Offense_Type, Longitude, Latitude, ID)

# Cleaning Seattle dataset. 

# seattle_crime_raw <- read.csv("Crime_Data.csv", stringsAsFactors = FALSE)
# 
# seattle_crime <- seattle_crime_raw %>% 
#   mutate(occurred_on = Occurred.Date) %>% 
#   separate(occurred_on, c("month", "day", "year")) %>% 
#   filter(year == "2018") %>% 
#   select(Report.Number, Occurred.Date, Crime.Subcategory)

