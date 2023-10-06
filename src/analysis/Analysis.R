# import dataset
movie_director_data <- read_csv("data/movie_director_data.csv")
movie_director_data <- na.omit(movie_director_data)

# make openninggross a numeric variable and remove dollar signs
movie_director_data$openinggross <- as.numeric(gsub("[\\$,]", "", movie_director_data$openinggross))

# Make runTimeMinutes a dummy variabele by using a median split
  # Calculate median of variable 'runtimeMinutes'
median_runtime <- median(movie_director_data$runtimeMinutes)

movie_director_data$runtime_dummy <- ifelse(movie_director_data$runtimeMinutes <= median_runtime, 0, 1)

# Count how many times a director has directed a movie that is in the dataset
movie_director_data$director_count <- ave(movie_director_data$director_identifier, movie_director_data$director_identifier, FUN = length)

median_director_count <- median(movie_director_data$director_count)
movie_director_data$directed_above_median <- ifelse(movie_director_data$director_count <= median_runtime, 0, 1)

# Regression analysis
openinggross_lm1 <- lm(openinggross ~ theathers + directed_above_median + runtime_dummy, movie_director_data)
summary(openinggross_lm1)
  # The amount of theaters and runtime have a significant effect on the openinggross 
# T-test + Barplot to make the t-test visual ----
  # T-test with openinggross DV and director_above_median IV
t_test_result <- t.test(openinggross ~ directed_above_median, data = movie_director_data)
print(t_test_result)

  # T-Test: The t-test indicates a significant difference in means between the two groups (directed_above_median 0 and 1) based on the opening gross.
  # Regression Analysis: The regression analysis, when considering theaters and runtime_dummy as well, does not find directed_above_median to be a significant predictor of opening gross.
  # The difference arises due to the additional predictors included in the regression analysis. When you include other predictors (like theathers and runtime_dummy), they might account for some of the variation in opening gross that was attributed to directed_above_median in the t-test. In other words, the effect of directed_above_median on opening gross might be explained by the other predictors in the regression model.

# Bereken de gemiddelde Opening Gross per groep
means <- tapply(movie_director_data$openinggross / 1e6, movie_director_data$directed_above_median, mean)

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

# DEZE REGRESSIE WEGHALEN
# Second regression with theaters as moderator
openinggross_lm2 <- lm(openinggross ~ theathers*directed_above_median + runtime_dummy, movie_director_data)
summary(openinggross_lm2)
  # All variables are significant, including the interaction term, as p-value is below alpha = 0.05
  # Significance of the interaction term indicates that the effect of  the effect of theaters on opening gross changes by 13,500 units for movies directed by someone above the median, compared to those below the median, assuming runtime is constant
