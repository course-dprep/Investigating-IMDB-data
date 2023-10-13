PREP=../../gen/data-preparation
DATA=../../data/
SOURCE=../../src/data_preparation
ANALYZE=../../gen/analysis

# Definieer doelen en hun afhankelijkheden

all: $(ANALYZE)/filtered_merged_dataset.csv $(PREP)/merged_dataset_unique.csv

$(PREP)/merged_dataset_unique.csv: 2_download_and_merge_data.R
		R --vanilla < 2_download_and_merge_data.R

$(ANALYZE)/filtered_merged_dataset.csv: $(PREP)/merged_dataset_unique.csv 3_data_filter_and_merg.R
		R --vanilla < 3_data_filter_and_merg.R
