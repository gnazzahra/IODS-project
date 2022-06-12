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

#read dataset
human <- read.csv("~/IODS-project/data/human.csv", header=TRUE)
dim(human)
str(human)
#- This data describes variables related to Human Development Index and Gender Inequality Index in various countries.
#- The variable X is the row names describing the country to which the data relates to.
#- edu2R is the ratio between proportion of females and males with at least secondary level of education. 
#- lprR is the ratio between proportion of females and males in the labor force.
#- eye: Expected Year of Education
#- leb: Life Expectancy at Birth
#- gni: Gross National Income 
#- mmr: Maternal Mortality Rate
#- abr: Adolescent Brith Rate
#- prp: persentage of female representatives in the parliament

#defining columns to keep
keep_columns <- c("Country", "edu2R", "lprR", "eye", "leb", "gni", "mmr", "abr", "prp")

# select the 'keep_columns' to modify dataset
human <- dplyr::select(human, one_of(keep_columns))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human <- filter(human, complete.cases(human))

# last indice we want to keep
last <- nrow(human) - 7

# choose everything until the last 7 observations
human <- human[1:last, ]

# add countries as rownames
rownames(human) <- human$Country

# remove the Country variable
human <- dplyr::select(human, -Country)

#write dataset
write.csv(human, file = "~/IODS-project/data/human.csv")
