PREP=../../gen/data-preparation
DATA=../../data/
SOURCE=../../src/data_preparation
ANALYZE=../../gen/analysis
PAPER=../../gen/paper

# Definieer doelen en hun afhankelijkheden

all: $(PAPER)/4_Analysis.pdf

$(PAPER)/4_Analysis.pdf: 4_Analysis.Rmd $(ANALYZE)
	R -e "rmarkdown::render('4_Analysis.Rmd', output_dir='$(PAPER)')"
