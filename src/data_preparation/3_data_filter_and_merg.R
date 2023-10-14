#test
library(tidyverse)
# Read merged data csv file
# Import the dataset
csv_file <- "merged_dataset_unique.csv"
folder <- "../../gen/data-preparation"

folder_path <- file.path(folder, csv_file)

merged_dataset_unique <- read.csv2(folder_path)

# Data preparation 
## Renaming and deleting unnecessary variables

# Delete and rename variables
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
  select(-primaryName)
filtered_merged_dataset <- filtered_merged_dataset %>%
  rename(movie = name)
filtered_merged_dataset <- subset(filtered_merged_dataset, complete.cases(filtered_merged_dataset))


# Create new variables 
## RuntimeMinutes dummy

# Transform opening gross into a numeric variable and remove dollar signs
filtered_merged_dataset$openinggross <- as.numeric(gsub("[\\$,]", "", filtered_merged_dataset$openinggross))

# Make runTimeMinutes a dummy variable by using a median split
# Calculate median of variable 'runtimeMinutes'
filtered_merged_dataset$runtimeMinutes <- as.numeric(filtered_merged_dataset$runtimeMinutes)
median_runtime <- median(filtered_merged_dataset$runtimeMinutes)
# Construct a dummy variable for the runtime per minutes 
filtered_merged_dataset$runtime_dummy <- ifelse(filtered_merged_dataset$runtimeMinutes <= median_runtime, 0, 1)

## Director count

# Count how many times a director has directed a movie that is in the dataset
filtered_merged_dataset$director_count <- ave(filtered_merged_dataset$director_identifier, filtered_merged_dataset$director_identifier, FUN = length)
# Calculate the median of director_count
filtered_merged_dataset$director_count <- as.numeric(filtered_merged_dataset$director_count)
median_director_count <- median(filtered_merged_dataset$director_count)
filtered_merged_dataset$directed_above_median <- ifelse(filtered_merged_dataset$director_count <= median_director_count, 0, 1)

# Converting merged_dataset_unique into a csv file

# Define folder for CSV file
fileplace <- "../../gen/analysis/filtered_merged_dataset.csv"

# CSV to input folder for analysis
write_csv2(filtered_merged_dataset, file = fileplace)
