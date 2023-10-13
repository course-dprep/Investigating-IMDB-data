all: analysis data-preparation

data-preparation:
	make -C src/data_preparation

analysis: data-preparation
	make -C src/analysis

	
