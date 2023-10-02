[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-718a45dd9cf7e7f842a935f5ebbe5719a5e09af4491e668f4dbf3b35d5cca122.svg)](https://classroom.github.com/online_ide?assignment_repo_id=11726002&assignment_repo_type=AssignmentRepo)

# IMDB- the unfluence of a director on the movies openinggross

This project estimates how much influence the director of a movie has on the money the movies makes in its opening weekend. We have created an analyzation of the connection between director and opening gross, taking in to account the; amount of theaters the movie is shown in, the genre of the movie and also the runtime of the movie (length of the movie in minutes.). this tool helps to create an insight into the amount of influence a director has on the success of a movie.

# Research motivation

Every year around 500 movies gets released into the cinema’s, more than 60 percent of these movies do not make back the money that is invested in them. For the investors behind those movies making money is the most important part of investing, therefore it is important for the movie industry to get more profitable. When this is the case a logical effect is that more money will be invested and movies will go up in quality. Directors of movies have a key role in choosing cast members, production design and the complete creative aspect of filmmaking. The impact of a director on the end product of a movie is big as you can see, there this project is dedicated to finding out the direct impact of the director on the success of the movie. This tool can be used for choosing the right director for the right genre and therefore maximizing the profits of the movie.

# Research question
How much does the director of the movie influence the opening gross of the movie, taking into account the impact of the amount of theatres the movies is shown in, the genre of the movie and the runtime of the movie? 

# Research method
To collect the data a web scraper was built to collect the data from developer IMDB and Box Office Mojo. Several data sets were collector from developer IMDB such as; title.basics.tsv.gz, title.crew.tsv.gz, name.basics.tsv.gz. From Box Office Mojo a web scraper was build to collect the following data; opening gross and amount of theaters. For the opening gross of a movie only the data for the top 1000 movies were available, for that reason the data from Box Office Mojo has been merged with the data of IMDB. The result were 992 observations out of 1000. The data had the be merged three several times to link all the different data sets with each other. 

How do we justify our moderators?


# Example of reproducible research workflow 

This is a basic example repository using Gnu make for a reproducible research workflow, as described in detail here: [tilburgsciencehub.com](http://tilburgsciencehub.com/). 

The main aim of this to have a basic structure, which can be easily adjusted to use in an actual project.  In this example project, the following is done: 
1. Download and prepare data
2. Run some analysis
3. Present results in a final pdf generated using LaTeX

## Dependencies
- R 
- R packages: `install.packages("stargazer")`
- [Gnu Make](https://tilburgsciencehub.com/get/make) 
- [TeX distribution](https://tilburgsciencehub.com/get/latex/?utm_campaign=referral-short)
- For the `makefile` to work, R, Gnu make and the TeX distribution (specifically `pdflatex`) need to be made available in the system path 
- Detailed installation instructions can be found here: [tilburgsciencehub.com](http://tilburgsciencehub.com/)


## Notes
- `make clean` removes all unncessary temporary files. 
- Tested under Linux Mint (should work in any linux distro, as well as on Windows and Mac) 
- IMPORTANT: In `makefile`, when using `\` to split code into multiple lines, no space should follow `\`. Otherwise Gnu make aborts with error 193. 
- Many possible improvements remain. Comments and contributions are welcome!
