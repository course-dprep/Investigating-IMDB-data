PREP=../../gen/data-preparation
DATA=../../data/
SOURCE=../../src/data_preparation
ANALYZE=../../gen/analysis
# Define targets and their dependencies



all: $(ANALYZE)/filtered_merged_dataset.csv $(PREP)/merged_dataset_unique.csv

$(PREP)/merged_dataset_unique.csv: $(SOURCE)/2_download_and_merge_data.Rmd
		Rscript -e 'rmarkdown::render("$(SOURCE)/2_download_and_merge_data.Rmd")'


$(ANALYZE)/filtered_merged_dataset.csv: $(SOURCE)/3_data_filter_and_merg.Rmd
		Rscript -e 'rmarkdown::render("$(SOURCE)/3_data_filter_and_merg.Rmd")