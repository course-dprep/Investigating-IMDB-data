#test
# Importing all the raw data
## Import datasets from Imdb 

# Load library

library(dplyr)
library(tidyverse)
# Define the URL of the first Imdb dataset
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

# Define the URL of the second Imdb dataset
url_crew <- "https://datasets.imdbws.com/title.crew.tsv.gz"
# Define the column types and download and import the dataset
imdb_crew_data <- read_delim(url_crew, delim = "\t", col_names = TRUE,
                             col_types = cols(
                               tconst = col_character(),
                               directors = col_character(),
                               writers = col_character()
                             )
)

# Define the URL of the third Imdb dataset
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
# Download and import the dataset
imdb_name_basics <- read_delim(url_name_basics, delim = "\t", col_types = col_types)

# Merging Imbd datsets
# Merge imdb_basics_data and imdb_crew_data based on the variable 'tconst'
imdb_basics_crew <- left_join(title_basics_data, imdb_crew_data, by="tconst")

# Rename the variable 'nconsts' to 'directors' since it's an array of nconsts
imdb_basics_crew <- imdb_basics_crew %>%
  rename(director_identifier = directors)

# Merge the dataframe that was created above with the imdb_name_basics data
imdb_basics_crew_name <- left_join(imdb_basics_crew, imdb_name_basics, by = c ("director_identifier" = "nconst"))

# Delete all variables that we will not use in the project
imdb_basics_crew_name <- imdb_basics_crew_name %>%
  select(-endYear, -writers, -birthYear, -deathYear)

# See all unique values of the titleType
unique_values <- unique(imdb_basics_crew_name$titleType)
# Select only the data that contains titleType movie
filtered_data <- imdb_basics_crew_name %>% filter(titleType == "movie")

## Merging Imbd datasets with Boxofficemojo dataset

# Import Boxofficemojo data
openingweekend_unique <- read.csv("../../data/weekend_data.csv")

# Merge the datasets by using a left join 
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

# Converting merged_dataset_unique into a csv file

csv_bestand <- "merged_dataset_unique.csv"
folder <- "../../gen/data-preparation"

folder_path <- file.path(folder, csv_bestand)

write_csv2(merged_dataset_unique, file = folder_path)

cat("The dataframe has been saved as", folder_path, "\n")
