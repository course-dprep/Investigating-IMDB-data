# import dataset
movie_director_data2 <- read_csv("data/movie_director_data.csv")
movie_director_data2 <- na.omit(movie_director_data2)

# make openninggross a numeric variable and remove dollar signs
movie_director_data2$openinggross <- as.numeric(gsub("[\\$,]", "", movie_director_data2$openinggross))

#Make runTimeMinutes a dummy variabele with median split
# Bereken de mediane waarde van de variabele 'runtimeMinutes'
median_runtime <- median(movie_director_data2$runtimeMinutes)

movie_director_data2$runtime_dummy <- ifelse(movie_director_data2$runtimeMinutes <= median_runtime, 0, 1)


#Count how many times a director has directed a movie that is in the dataset
movie_director_data2$director_count <- ave(movie_director_data2$director_identifier, movie_director_data2$director_identifier, FUN = length)

median_director_count <- median(movie_director_data2$director_count)
movie_director_data2$directed_above_median <- ifelse(movie_director_data2$director_count <= median_runtime, 0, 1)


str(movie_director_data2)
# make regression
openinggross_lm1 <- lm(openinggross ~ theathers + directed_above_median, movie_director_data2)
summary(openinggross_lm1)

#T-test + Barplot to make the t-test visual ----

#t-test with openinggross DV and director_above_median IV
t_test_result <- t.test(openinggross ~ directed_above_median, data = movie_director_data2)
print(t_test_result)

# Bereken de gemiddelde Opening Gross per groep
means <- tapply(movie_director_data2$openinggross / 1e6, movie_director_data2$directed_above_median, mean)

# Maak een staafdiagram
barplot(means, 
        names.arg = c("Directed Below Median", "Directed Above Median"),
        ylab = "Mean Opening Gross in Millions of dollars",
        xlab = "Directed Above Median Runtime",
        col = c("blue", "red"),
        main = "Mean Opening Gross by Directed Above Median Runtime",
        ylim = c(0, 70))  # Beperk de y-as tot 0-70

# Voeg een legenda toe
legend("topright", legend = c("Directed Below Median", "Directed Above Median"), fill = c("blue", "red"))

