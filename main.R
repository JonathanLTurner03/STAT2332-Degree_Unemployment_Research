# This class is used as the driver, in which it will hold the main functions 
# (data wise).

# I will be using the readxl library to read in the excel file to allow for
# Easier manipulation of the file. 

library(readxl) # Used for reading in excel files.
library(ggstatsplot) # Used for creating the box plot.
library(ggstatsplot)
library(paletteer)
library(ggplot2)
setwd("./") # Ensures the working directory is in the same file. 

# Reads the excel file in to the dataset object.
dataset <- read_excel("Data/recent-grads-excel.xlsx")

# This function below can remain commented, used for testing to ensure data is 
# loaded correctly.
# View(dataset)

# Creates a first barplot of the dataset to show the distribution of the majors.
barplot(table(dataset$Major_category), main="Distribution of Majors", 
        xlab="Major Category", ylab="Frequency", col="RED",)

# Finds the major with the highest unemployment rate.
highest_unemployment_rate <- dataset[which.max(dataset$Unemployment_rate),]

# Prints the major with the highest unemployment rate.
print(paste("The major with the highest unemployment rate is: ", 
            highest_unemployment_rate$Major))

boxplot(as.numeric(dataset$Unemployment_rate), xlab="Unemployment Rate", 
        ylab="Majors", horizontal = TRUE)


# Creates a copy of the dataset for maniupation without altering the original 
# set.
filter_set <- dataset
na.omit(filter_set$Unemployment_rate)

# Converts the rate to a 
filter_set$Unemployment_rate <- as.numeric(filter_set$Unemployment_rate)

df <- data.frame(
  college = filter_set$Major_category,
  rate = filter_set$rate
)

p1 <- ggbetweenstats(
  data = df,
  x = college,
  y = rate,
  pairwise.comparisons = FALSE,
  
)

p1
