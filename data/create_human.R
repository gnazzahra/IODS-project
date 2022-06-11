#read files
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#explore data
str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

#renaming variables
library(dplyr)
hd <- rename(hd, rank = HDI.Rank, hdi=Human.Development.Index..HDI., leb= Life.Expectancy.at.Birth, eye = Expected.Years.of.Education, mye = Mean.Years.of.Education, gni = Gross.National.Income..GNI..per.Capita, gni_hdi = GNI.per.Capita.Rank.Minus.HDI.Rank)
gii <- rename(gii, rank=GII.Rank, index=Gender.Inequality.Index..GII., mmr=Maternal.Mortality.Ratio , abr=Adolescent.Birth.Rate, prp= Percent.Representation.in.Parliament, se_f = Population.with.Secondary.Education..Female., se_m = Population.with.Secondary.Education..Male., lpr_f=Labour.Force.Participation.Rate..Female., lpr_m=Labour.Force.Participation.Rate..Male.)

#mutating gii
gii <- mutate(gii, edu2R = se_f/se_m, lprR= lpr_f/lpr_m)

#joining datasets
human <- inner_join(gii, hd, by = "Country", suffix = c(".gii", ".hd"))
dim(human)

#write dataset
write.csv(human, file = "human.csv")
