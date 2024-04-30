# Imports the libraries used. These libraries must be installed prior to running
# the program.
library(tidyverse)
setwd("./") # Ensures the working directory is in the same file. 

# Reads the data set object.
dataset <- read_csv("Data/recent-grads.csv")

# This function below can remain commented, used for testing to ensure data is 
# loaded correctly.
# View(dataset)

# Creates a dataframe object that observes the 
modified <- data.frame(
  college = dataset$Major_category, 
  rate = dataset$Unemployment_rate
)

modified <- na.omit(modified) # Removes any NA data values

# Performs an ANOVA test on the large range of values in the dataframe. . 
anova_result <- aov(rate ~ college, data = modified)
summary(anova_result)

# Finds the first and 99th quadrant 
q1 <- quantile(modified$rate, 0.01)
q99 <- quantile(modified$rate, 0.99)

#Creates a new dataset with a filtered to remove outliers. 
filtered_outliers <- modified %>%
  filter(rate >= q1 & rate <= q99)

# performs the ANOVA test again but with outliers removed. 
anova_result_filtered <- aov(rate ~ college, data=filtered_outliers)
summary(anova_result_filtered)

# Used to find the high and low of the values. 
high_rate <- max(filtered_outliers$rate)
low_rate <- min(filtered_outliers$rate)

# Combines the repeated values into a single entry with a mean of all the values.
combined_majors <- aggregate(rate ~ college, data = filtered_outliers, FUN=mean)

# Displays an easier to see graph representing the college without repeat values.
barplot(combined_majors$rate, 
        names.arg = combined_majors$college, las = 2, 
        xlab = "Major", ylab = "Unemployment Rate")

# Finds the min and max indicies of the combined and filtered stats.
min_index <- which.min(combined_majors$rate)
max_index <- which.max(combined_majors$rate)

# Prints out the results.
cat("The lowest combined unemployment of a college is: ", 
    combined_majors$college[min_index], 
    " with a value of ", 
    combined_majors$rate[min_index], "\n")

cat("The highest combined unemployment of a college is: ", 
    combined_majors$college[max_index], 
    " with a value of ", 
    combined_majors$rate[max_index], "\n")



