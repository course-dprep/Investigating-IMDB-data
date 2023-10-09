# Makefile for importing IMDb datasets using R script

# Define variables
#RSCRIPT = Rscript
#RSCRIPT_FILE = import_imdb_data.R  
URL_BASICS = "https://datasets.imdbws.com/title.basics.tsv.gz"
URL_CREW = "https://datasets.imdbws.com/title.crew.tsv.gz"
URL_NAME_BASICS = "https://datasets.imdbws.com/name.basics.tsv.gz"
#openingweekend_unique = "openingweekend_unique.csv"

# Define targets and their dependencies
all: merged_dataset_unique.csv filtered_merged_dataset.csv

merged_dataset_unique.csv: download_and_merge_data.Rmd
	Rscript download_and_merge_data.Rmd

#Q2
INPUT_FILE = merged_dataset_unique.csv
OUTPUT_FILE = filtered_merged_dataset.csv

# Define the R script file
filtered_merged_dataset.csv: data_filter_and_merg.Rmd
	Rscript data_filter_and_merg.Rmd
	
#Q3
#INPUT_FILE = filtered_merged_dataset.csv


