TEMP = = ../../gen/data-preparation/temp
OUTPUT = = ../../gen/data-preparation/ouput

all: $(TEMP)/listings_2021-12-05.csv $(OUTPUT)/listings_autumn.csv

#$(TEMP)/listings_2021-12-05.csv: auto_unzip_data_folder.R 
#	mkdir -p ../../gen/data-preparation/temp
#	R --vanilla < auto_unzip_data_folder.R
	
$(OUTPUT)/listings_autumn.csv: $(TEMP)/listings_2021-12-05.csv load_data.R
	mkdir -p ../../gen/data-preparation/ouput
	R --vanilla < load_data.R