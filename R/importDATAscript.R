# R import individual data into subsets of plots etc

library(ggplot2)
library(readxl)
library(dplyr)

#I have tried to do this using excel but it is way too hard.
# datBASE1 <- readxl::read_excel("./data/raw_data/Sem two planning.xlsx", sheet = c(3))
# datBASE2 <- readxl::read_excel("./data/raw_data/Sem two planning.xlsx", sheet = c(4))
# datBASE3 <- readxl::read_excel("./data/raw_data/Sem two planning.xlsx", sheet = c(5))
# read.csv("./data/")
# names(datBASE1)==names(datBASE2)
# names(datBASE2)==names(datBASE3)
# names(datBASE1)==names(datBASE3)
# str(datBASE1)
# str(datBASE2)
# str(datBASE1)
#### these are now as csv files for each datasheet entry
#orginal excel in Raw_data file...
#no conversion to csv to aviod same data issues...

datPhD <- readr::read_csv("./data/PhDProjects.csv") 
datCouncil <- readr::read_csv("./data/CouncilProjects.csv")
datInvert <- readr::read_csv("./data/InvertProjects.csv")

## Full tasks database
datBASE <- bind_rows(datPhD, datCouncil, datInvert) %>%
  filter(project != "NA")

# %>%
#               remove_missing()

# dplyr::bind_rows(datBASE1,datBASE2)

# DT::datatable(datBASE)
# 
# datBASE$startDate
# 
# names(datBASE)