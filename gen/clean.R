
# Define the file paths
file_to_delete_1 <- "analysis/filtered_merged_dataset.csv"
file_to_delete_2 <- "data-preparation/merged_dataset_unique.csv"

# Check and delete the first file
if (file.exists(file_to_delete_1)) {
  file.remove(file_to_delete_1)
  cat(paste("File", file_to_delete_1, "has been deleted.\n"))
} else {
  cat(paste("File", file_to_delete_1, "does not exist.\n"))
}

# Check and delete the second file
if (file.exists(file_to_delete_2)) {
  file.remove(file_to_delete_2)
  cat(paste("File", file_to_delete_2, "has been deleted.\n"))
} else {
  cat(paste("File", file_to_delete_2, "does not exist.\n"))
}

