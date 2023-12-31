[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-718a45dd9cf7e7f842a935f5ebbe5719a5e09af4491e668f4dbf3b35d5cca122.svg)](https://classroom.github.com/online_ide?assignment_repo_id=11726002&assignment_repo_type=AssignmentRepo)

![IMDb Logo](https://upload.wikimedia.org/wikipedia/commons/6/69/IMDB_Logo_2016.svg)

# IMDB- the influence of a director on the movies openinggross

This project estimates how much influence the director of a movie has on the money the movies makes in its opening weekend. We have created an analyzation of the connection between director and opening gross, taking in to account the; amount of theaters the movie is shown in, the genre of the movie and also the runtime of the movie (length of the movie in minutes.). this tool helps to create an insight into the amount of influence a director has on the success of a movie.

## Research motivation

Every year around 500 movies gets released into the cinema’s, more than 60 percent of these movies do not make back the money that is invested in them. For the investors behind those movies making money is the most important part of investing, therefore it is important for the movie industry to get more profitable. When this is the case a logical effect is that more money will be invested and movies will go up in quality. Directors of movies have a key role in choosing cast members, production design and the complete creative aspect of filmmaking. The impact of a director on the end product of a movie is big as you can see, there this project is dedicated to finding out the direct impact of the director on the success of the movie. This tool can be used for choosing the right director for the right genre and therefore maximizing the profits of the movie.

## Research question
How much does the director of the movie influence the opening gross of the movie, taking into account the impact of the amount of theatres the movies is shown in, the genre of the movie and the runtime of the movie? 

## Research method
To collect the data a web scraper was built to collect the data from Boxofficemojo. Several data sets were collector from developer IMDB such as; title.basics.tsv.gz, title.crew.tsv.gz, name.basics.tsv.gz. From Box Office Mojo a web scraper was build to collect the following data; title, opening gross and amount of theaters. For the opening gross of a movie only the data for the top 1000 movies were available, for that reason the data from Box Office Mojo has been merged with the data of IMDB. The result were 992 observations out of 1000. The data had the be merged three several times to link all the different data sets with each other. 

For our regression analysis, we will use director_count as the independent variable of interest in the regression of the opening gross of movies on Imdb. As covariables, we used runtime in minutes and amount of theaters that the film was played in, as we expected that these variables would affect the opening gross. Probably, the more theaters the movie is played in, the higher the opening gross would be. Thus, a positive relationship is expected. Additionally, some people do not like long movies / movies of 190 minutes. Therefore,  the runtime in minutes is also expected to affect the opening gross. Concluding, these are the covariables we used in our regression analysis. The director count is the number of movies a director has directed. When a director has directed a lot of movies, especially popular movies,  he/ she is expected to be known by name. Therefore, we are interested in researching whether this affects the opening gross.

## conclusion
Looking at the results, we clearly observe a difference in the two means between the opening gross of films directed by directors with higher recognition (directed_above_median = 1) against directors with a lower recognition (directed_above_median = 0), and this difference is statistically significant. However, upon reviewing the results of the linear regression, it becomes clear that this outcome is predominantly driven by other variables. By including the variables “theaters” and “runtime_dummy,” we observe that the p-value for the variable “directed_above_median” becomes insignificant. The remaining variables in this model maintain their significance. Therefore, based on this dataset, it cannot be concluded that the director of a film has a significant impact on the opening gross of a film.

## Variables 

| Number| Variable| Description| Type|
|:-|:-|:-|:-|
| 1 | movie| The title of the movie                                  | String  |
| 2 | openinggross| The opening gross of the first weekend the movie premiered | Numeric |
| 3 | Theaters| The amount of theaters that the movie premiered in    | Numeric |
| 4 | runtimeMinutes| The duration of the movie in minutes                   | Numeric |
| 5 | genres| The genre of the movie                                  | String  |
| 6 | director_identifier| The unique identifier to identify which director directed the movie | String  |
| 7 | primaryProfession| The professions that a director has (sometimes they also have other roles in the movies such as actor or writer) | String  |
| 8 | runtime_dummy| A dummy variable that measures if a movie has a high (runTimeminutes above median) or low (runTimeminutes below median) runtime in minutes | Logical |
| 9 | director_count| The number of movies that a director has directed that are in this dataset | Numeric |
| 10| directed_above_median| A dummy variable that measures if a director has a high (director_count above median) or low (director_count below median) number of movies directed | Logical |



## Repository structure
```
├── data
   ├── dataset1
├── gen
   ├── analysis
     ├── input
   ├── data-preparation
     ├── input_downloading_and_merging
     ├── input_filtering
   └── paper
     ├── input
     ├── ouput
└── src
   ├── analysis
   ├── data_preparation
     ├── 1_Python_source_code
     ├── 2_data_download_and_merg
     ├── 3_data_filter_and_variable_expansion
   └── paper
├── .gitignore
├── README.md
├── makefile
```
# Dependencies
## Software
In this research project, a diverse range of software applications were employed to gather and manipulate data effectively. Below, you will find a comprehensive list of the requisite software packages utilized throughout the course of this project: 
- R (Version 4.3.1) & RStudio (Version 2023.06.1)
- Python (Version 3.11.4)
- Make (Version 3.81)

## Packages
In the context of data preparation and analysis in R, various packages are employed. Below, you will find a categorized list of packages based on the specific purposes for which they are utilized:

Data preparation: 
- library(base)
- library(datasets)
- library(graphics)
- library(grDevices)
- library(methods)
- library(stats)
- library(utils)
- library(tidyverse)
- library(dplyr)   


Data analysis:
- library(base)
- library(datasets)
- library(graphics)
- library(grDevices)
- library(methods)
- library(stats)
- library(utils)
- library(readr)

# Recreating the Project: A Comprehensive Guide
For this project, ```make``` was used to automate the project. When running the makefile that is not put into a folder within this repository, all folder specific makefiles are controlled. With this, the project is run and therefore does not need to be done manually. Below is the order in which the project runs:
```
*src/python_source_code/1_boxofficemojo_openingweekendscraper.py
src/data-preparation/2_download_and_merge_data.R
src/data-preparation/3_data_filter_and_merge_data.R
src/analysis/4_Analysis.Rmd
**gen/clean.R
```
*This code is not run by make. Because this code is static and will not be modified much over time, it was chosen not to run this code through make. The dataset that comes out of this webscraper can be found in data/weekend_data.csv. If you want to run this scraper yourself, you can do so by running the file in Python. So the data from this scraper is extracted from a csv file and used as input for 2_download_and_merge_data.R.

The clean.R is not run manually and can be run to remove temporary generated files from the directory tree. It is not run right away because these files could be used to re-run results from a later stage in the project. This ensures that the large datasets do not always have to be loaded.

## Notes 
- gen/paper/clean.R removes all unncessary temporary files. 
- Tested under Windows and Mac.
- This project is free to make additions and therefore everyone is free to contribute to it.
