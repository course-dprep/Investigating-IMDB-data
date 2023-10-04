# Makefile for importing IMDb datasets using R script

# Define variables
#RSCRIPT = Rscript
#RSCRIPT_FILE = import_imdb_data.R  
URL_BASICS = "https://datasets.imdbws.com/title.basics.tsv.gz"
URL_CREW = "https://datasets.imdbws.com/title.crew.tsv.gz"
URL_NAME_BASICS = "https://datasets.imdbws.com/name.basics.tsv.gz"
#openingweekend_unique = "openingweekend_unique.csv"

# Define targets and their dependencies
all: first_output.csv 

first_output.csv: import_imdb_data.R
	Rscript import_imdb_data.R



