rm(list=ls())
library(readxl)
library(data.table)
library(dplyr)
library()

#############################################################################################################################
## Amsterdam (Crocket et al 2013 study 2)
## data from 22 subjects (6 less than reported in the paper)

# specifying the path name
path <- "D:/OneDrive - California Institute of Technology/PhD/Rangel Lab/2022-surprise-utility/task/Ratings_Amsterdam.xls"

read_excel_allsheets <- function(filename, tibble = FALSE) {
  # I prefer straight data.frames
  # but if you like tidyverse tibbles (the default with read_excel)
  # then just pass tibble = TRUE
  sheets <- readxl::excel_sheets(filename)
  x <- lapply(sheets, function(X) readxl::read_excel(filename, sheet = X, col_names=F))
  if(!tibble) x <- lapply(x, as.data.frame)
  names(x) <- sheets
  x
}

amsheets <- read_excel_allsheets(path)

amsterdam <- data.frame(
  stim = amsheets[[names(amsheets)[1]]][["...13"]],
  rating = amsheets[[names(amsheets)[1]]][["...11"]]
)

for (name in names(amsheets)[2:length(names(amsheets))]) {
  
  add <- data.frame(
    stim = amsheets[[name]][["...13"]],
    rating = amsheets[[name]][["...11"]]
  )  
  
  amsterdam <- rbind(amsterdam, add)
  
}

keys <- "stim"
amsterdam <- as.data.table(amsterdam)
amsterdam <- amsterdam[,list(rating=mean(rating, na.rm=T)),keys][1:403,]
amsterdam <- amsterdam[order(stim),]


#############################################################################################################################
## Cambridge (Crocket et al 2013 study 1)
## data from 69 subjects (16 less than reported in the paper)

# specifying the path name
path <- "D:/OneDrive - California Institute of Technology/PhD/Rangel Lab/2022-surprise-utility/task/Ratings.xls"

read_excel_allsheets <- function(filename, tibble = FALSE) {
  # I prefer straight data.frames
  # but if you like tidyverse tibbles (the default with read_excel)
  # then just pass tibble = TRUE
  sheets <- readxl::excel_sheets(filename)
  x <- lapply(sheets, function(X) readxl::read_excel(filename, sheet = X, skip=1))
  if(!tibble) x <- lapply(x, as.data.frame)
  names(x) <- sheets
  x
}

camsheets <- read_excel_allsheets(path)

drop <- c(
  "s01-2",
  "s02-2",
  "s03-2",
  "s04-2",
  "s05-2",
  "s06-2",
  "s07-2",
  "s08-2",
  "s09-2",
  "101",
  "Chart1",
  "SSLL",
  "Correlations"
)

camsheets <- camsheets[!names(camsheets) %in% drop] 

cambridge <- data.frame(
  stim = camsheets[[names(camsheets)[1]]][["Picture"]],
  rating2 = camsheets[[names(camsheets)[1]]][["Item.RESP"]] 
)

for (name in names(camsheets)[2:length(names(camsheets))]) {
  
  add <- data.frame(
    stim = camsheets[[name]][["Picture"]],
    rating2 = camsheets[[name]][["Item.RESP"]] 
  )  
  
  cambridge <- rbind(cambridge, add)
  
}

keys <- "stim"
cambridge <- as.data.table(cambridge)
cambridge <- cambridge[,list(rating2=mean(rating2, na.rm=T)),keys][1:404,]
cambridge <- cambridge[order(stim),] %>% na.omit()


#############################################################################################################################
## AVERAGE RATINGS, KEEP TOP 72

data <- merge(
  cambridge,
  amsterdam,
  by="stim"
)

data$finalRating <- (22/(22+69))*data$rating + (69/(22+69))*data$rating2

data <- data[order(-finalRating),]

top72 <- data[1:73, "stim"] # I say top 72, but I pull top 73. One of the stimuli names dont match, so I grab the next best instead.

write.csv(
  top72, 
  file = "D:/OneDrive - California Institute of Technology/PhD/Rangel Lab/2022-surprise-utility/task/top72stimuli.csv"
)

#############################################################################################################################
## ONLY KEEP TOP 72 STIMULI IN "REWARDS" FOLDER

rewardpath <- "D:/OneDrive - California Institute of Technology/PhD/Rangel Lab/2022-surprise-utility/task/rewards"

rewards <- data.frame(stim=list.files(rewardpath))

to_be_deleted <- subset(rewards, !(tolower(stim) %in% top72$stim))

setwd(rewardpath)
file.remove(to_be_deleted$stim)
