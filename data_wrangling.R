
# -----------------------------------------------------------------------------
# Dataset Aggregation of Austin, Denver, Boston, Chicago, Seattle crime raw 
# datasets into 5 columns (ID, Date, Offense_Type, Longitude, Latitude) 2018. 

# Cleaning up the Austin crime dataset. 

# Import .csv file of raw data. 
# austin_crime_raw <- read.csv("austin.csv", stringsAsFactors = FALSE) 

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
chicago_raw <- read.csv("chicago.csv", stringsAsFactors = FALSE)


chicago_new <- chicago_raw %>% 
  select(Case.Number, Latitude, Longitude, Date, Primary.Type) %>% 
  mutate(date_duplicate = Date) %>% 
  separate(Date, c("month", "date", "year")) %>% 
  filter(year == "2018") %>% 
  mutate(Date = as.Date(date_duplicate, format = "%m/%d/%Y")) %>% 
  select(Date, Case.Number, Latitude, Longitude, Primary.Type) %>% 
  rename(ID = Case.Number, Offense_Type = Primary.Type)

chicago_newer <- na.omit(chicago_new)

write.csv(chicago_newer, file = "datasets/chicago_crime_2.csv")

# boston_new <- boston_data_raw %>%
#   select(INCIDENT_NUMBER, Long, Lat, OCCURRED_ON_DATE, OFFENSE_DESCRIPTION) %>% 
#   rename(ID = "INCIDENT_NUMBER", Date = "OCCURRED_ON_DATE",
#          Offense_Type = "OFFENSE_DESCRIPTION", Latitude = "Lat", Longitude = "Long")

# Filter data for 2018 and format a new 'Date' column. 
# boston_df_new <- boston_new %>% 
#   mutate(full_date = Date) %>%
#   separate(Date, c("month", "date", "year")) %>% 
#   filter(year == "2018") %>% 
#   select(full_date, Offense_Type, Longitude, Latitude, ID) %>% 
#   mutate(Date = as.Date(full_date, format = "%m/%d/%Y")) %>%
#   select(Date, Offense_Type, Longitude, Latitude, ID)

# Cleaning Seattle dataset. 

# seattle_crime_raw <- read.csv("Crime_Data.csv", stringsAsFactors = FALSE)
# 
# seattle_crime <- seattle_crime_raw %>% 
#   mutate(occurred_on = Occurred.Date) %>% 
#   separate(occurred_on, c("month", "day", "year")) %>% 
#   filter(year == "2018") %>% 
#   select(Report.Number, Occurred.Date, Crime.Subcategory)
