all: analysis data-preparation clean

data-preparation:
	make -C src/data_preparation

analysis: data-preparation
	make -C src/analysis

clean:
	make -C gen 
	
