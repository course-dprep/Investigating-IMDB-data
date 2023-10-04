# import dataset
movie_director_data2 <- read_csv("data/movie_director_data.csv")
movie_director_data2 <- na.omit(movie_director_data2)

# make openninggross a numeric variable and remove dollar signs
movie_director_data2$openinggross <- as.numeric(gsub("[\\$,]", "", movie_director_data2$openinggross))

str(movie_director_data2)
# make regression
openinggross_lm1 <- lm(openinggross ~ theathers + runtimeMinutes + genres + director_identifier, movie_director_data2)
summary(openinggross_lm1)
