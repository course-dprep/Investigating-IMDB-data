## IMPORT ALL DATSETS
#Load tidyverse
library(tidyverse)
# Define the URL of the Imdb dataset
url_basics <- "https://datasets.imdbws.com/title.basics.tsv.gz"
# Define the column types
col_types = cols(
  tconst = col_character(),
  titleType = col_character(),
  primaryTitle = col_character(),
  originalTitle = col_character(),
  startYear = col_double(),
  endYear = col_double(),
  runtimeMinutes = col_double(),
  genres = col_character(),
  isAdult = col_logical()
)
# Download and import the dataset
title_basics_data <- read_delim(url_basics, delim = "\t", col_names = TRUE, col_types = col_types)
# Look at the first few rows of the dataset
View(title_basics_data)

# Load dataset crew ---- 

# Define the URL of the Imdb dataset
url_crew <- "https://datasets.imdbws.com/title.crew.tsv.gz"
# Define the column types and download and import the dataset
imdb_crew_data <- read_delim(url_crew, delim = "\t", col_names = TRUE,
                             col_types = cols(
                               tconst = col_character(),
                               directors = col_character(),
                               writers = col_character()
                             )
)
# Look at the first few rows of the dataset
head(imdb_crew_data)

#Load dataset name_basics 
# Define the URL of the Imdb dataset
url_name_basics <- "https://datasets.imdbws.com/name.basics.tsv.gz"
# Define the column types and download and import the dataset
col_types <- cols(
  nconst = col_character(),
  primaryName = col_character(),
  birthYear = col_integer(),
  deathYear = col_character(),
  primaryProfession = col_character(),
  knownForTitles = col_character()
)
# 
imdb_name_basics <- read_delim(url_name_basics, delim = "\t", col_types = col_types)
###
###Merging###
library(dplyr)
#Merge imdb_basics_data and imdb_crew_data based on the variable 'tconst'
imdb_basics_crew <- left_join(title_basics_data, imdb_crew_data, by="tconst")

#Rename the variable 'nconsts' to 'directors' since it's an array of nconsts
imdb_basics_crew <- imdb_basics_crew %>%
  rename(director_identifier = directors)

print(imdb_basics_crew)
#Merge the dataframe that was created above with the imdb_name_basics data
imdb_basics_crew_name <- left_join(imdb_basics_crew, imdb_name_basics, by = c ("director_identifier" = "nconst"))

#Delete all variables that won't be used in the project
imdb_basics_crew_name <- imdb_basics_crew_name %>%
  select(-endYear, -writers, -birthYear, -deathYear)

#See all unique values of the titleType
unique_values <- unique(imdb_basics_crew_name$titleType)

print(unique_values)

#Select only the data that contains titleType movie
filtered_data <- imdb_basics_crew_name %>% filter(titleType == "movie")

###second code

openingweekend_unique <- read.csv("weekend_data.csv")

merged_dataset <- openingweekend_unique %>% left_join(filtered_data, by = c("name" = "primaryTitle"))


# Find duplicated ride_ids
merged_dataset %>% 
  count(name) %>% 
  filter(n > 1)

# Remove full and partial duplicates
merged_dataset_unique <- merged_dataset %>%
  # Only based on ride_id instead of all cols
  distinct(name, .keep_all = TRUE)

# Find duplicated ride_ids in bike_share_rides_unique
merged_dataset_unique %>%
  # Count the number of occurrences of each ride_id
  count(name) %>%
  # Filter for rows with a count > 1
  filter(n > 1)


csv_bestand <- "merged_dataset_unique.csv"

write.csv2(merged_dataset_unique, file = csv_bestand, row.names = FALSE)

cat("Het dataframe is opgeslagen als", csv_bestand, "\n")

###New code
# Deleting and renaming variables
filtered_merged_dataset <- merged_dataset_unique %>%
  filter(titleType == "movie")

filtered_merged_dataset <- filtered_merged_dataset %>%
  select(-isAdult)
filtered_merged_dataset <- filtered_merged_dataset %>%
  select(-startYear)
filtered_merged_dataset <- filtered_merged_dataset %>%
  select(-tconst)

filtered_merged_dataset <- filtered_merged_dataset %>%
  select(-titleType)

filtered_merged_dataset <- filtered_merged_dataset %>%
  select(-originalTitle)

filtered_merged_dataset <- filtered_merged_dataset %>%
  select(-knownForTitles)


filtered_merged_dataset <- filtered_merged_dataset %>%
  select(-primaryProfession)


filtered_merged_dataset <- filtered_merged_dataset %>%
  select(-primaryName)

filtered_merged_dataset <- filtered_merged_dataset %>%
  rename(movie = name)

#Write csv
write.csv(filtered_merged_dataset, file = "movie_director_data.csv", row.names = FALSE)
