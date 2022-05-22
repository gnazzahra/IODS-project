#Ghaida N. Azzahra
#21 May 2022
#2: Data Wrangling

#reading data
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#dimension
dim(lrn14)
#there are 183 observations in the data and 60 variables

#structure
str(lrn14)
#all variables are integers, except gender which is a character

#combining questions
library(dplyr)
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

#choosing columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

#filtering points=0
learning2014 <- filter(learning2014, Points > 0)

#confirming the dimension of the dataset
dim(learning2014)
#166 obs and 7 variables

#setting working directory
setwd("C:\Users\12715\OneDrive\Documents\IODS-project")
write.csv(learning2014, file="learning2014.csv")

#making sure the structure of the data is correct
data <- read.csv(file = "learning2014.csv")
str(data)
head(data)
