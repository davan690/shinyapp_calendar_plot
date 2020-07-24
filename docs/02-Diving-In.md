---
title: Methods
output: html_document
---


```r
library(readr)
```

```
## Warning: package 'readr' was built under R version 4.0.2
```

```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(ggplot2)
```

```
## Warning: package 'ggplot2' was built under R version 4.0.2
```

```r
library(scales)
```

```
## Warning: package 'scales' was built under R version 4.0.2
```

```
## 
## Attaching package: 'scales'
```

```
## The following object is masked from 'package:readr':
## 
##     col_factor
```

```r
library(lubridate)
```

```
## Warning: package 'lubridate' was built under R version 4.0.2
```

```
## 
## Attaching package: 'lubridate'
```

```
## The following objects are masked from 'package:base':
## 
##     date, intersect, setdiff, union
```

# Methods {#methods .tabset}




Generally the concept is to create a baseline dataset of information and then extend this using `dataspice` to create a tidy format of data that can then be modelled and visualised using the `tidyverse` suite of tools.


```r
library(lubridate)
# glimpse(datBASE)
# dt <- data.frame(mon = c(10, 4), day = c(10, 4), year = c(2017, 2018))

# with(dt, ymd(paste(year, mon, day, sep = "-")))
#> [1] "2017-10-10" "2018-04-04"


### to correct ggplot subset
datBASE1 <- datBASE  %>%
    dplyr::select(startDate,month, year, milestone, status, shortName, project) %>%
                 mutate(date = as.Date(startDate, "%d/%m/%y"))
# ,
#                        month = as.numeric(as.character(month)),
#                        year = as.numeric(year),
#                        milestone = as.factor(milestone),
#                        status = as.factor(status))
# glimpse(datBASE1)
# df$date <- with(df, ymd(sprintf('%04d%02d%02d', year, month, 1)))
df <- datBASE1

# library(lubridate)
# dt <- data.frame(mon = c(10, 4), day = c(10, 4), year = c(2017, 2018))
# with(dt, ymd(paste(year, mon, day, sep = "-")))
#> [1] "2017-10-10" "2018-04-04"

# datBASE1$date <- with(datBASE1, ymd(sprintf('%04d%02d%02d', year, month, 1)))
df <- df[with(df, order(date)), ]
# head(df)
text_offset <- 0.05
```


## Data setup 


```r
library(knitr)
```

```
## Warning: package 'knitr' was built under R version 4.0.2
```

```r
knitr::include_graphics(path = "./img/TidyPipes-calenderJUL2020v2.png")
```

<img src="./img/TidyPipes-calenderJUL2020v2.png" width="640" />

There are multiple difference sources of information for this calendar. To be able to keep this upto date and current I need to write scripts for each data-source to my database of events (here). These are the following importing scripts:

- Timeline figures:
  - Past
  - Future
  
- Actions and milestones

## Data/information

The purpose of this vignette is to show how, with reference to a real-world application: creating a timetable for a new module. It assumes you’ve installed the package following instructions in the README and have attached it as follows:

Overall this is time series data. A good general tutorial for this sort of data is here on [youtube]("https://www.youtube.com/watch?v=uenWg7ZSu4Y"). There are several ways to visualise this data, below are two selected bits of code that do this. Overall there are two generalised datasets that may be helpful to other individuals for each project or combination of projects (for the APR for example). The data for this collection of tasks associated with timelines and targets. The baseline dataset is found in the `.xlsx` file named "baseline-dataset-calender.xlsx". This is the base file I have been adding information to when I change the overall structure of the calendar projects.

## Manual data

To begin with I have collated and restructured the avaliable data from downloaded `.ics` data as a csv and the UCSRC council calendar. This sorted data was orginally saved as "baseline-dataset-calender.xlsx" but as I couldnt get the xcel package to work nicely I converted each project dataset into a csv file stored in the `./data/` folder.



## Baseline


```r
source("./R/importDATAscript.R", echo = FALSE)
```

```
## Warning: package 'readxl' was built under R version 4.0.2
```

```
## Parsed with column specification:
## cols(
##   eventCode = col_character(),
##   shortName = col_character(),
##   month = col_character(),
##   startDate = col_character(),
##   finishDate = col_character(),
##   startTime = col_time(format = ""),
##   endTime = col_time(format = ""),
##   description = col_character(),
##   project = col_character(),
##   individualsNEEDED = col_character(),
##   week = col_logical(),
##   year = col_double(),
##   milestone = col_character(),
##   status = col_character(),
##   PreCovidDATE = col_character(),
##   Tasks = col_character(),
##   Notes = col_character()
## )
```

```
## Parsed with column specification:
## cols(
##   eventCode = col_character(),
##   shortName = col_character(),
##   month = col_character(),
##   startDate = col_character(),
##   finishDate = col_character(),
##   startTime = col_time(format = ""),
##   endTime = col_time(format = ""),
##   description = col_character(),
##   project = col_character(),
##   individualsNEEDED = col_character(),
##   week = col_double(),
##   year = col_double(),
##   milestone = col_character(),
##   status = col_character()
## )
## Parsed with column specification:
## cols(
##   eventCode = col_character(),
##   shortName = col_character(),
##   month = col_character(),
##   startDate = col_character(),
##   finishDate = col_character(),
##   startTime = col_time(format = ""),
##   endTime = col_time(format = ""),
##   description = col_character(),
##   project = col_character(),
##   individualsNEEDED = col_character(),
##   week = col_double(),
##   year = col_double(),
##   milestone = col_character(),
##   status = col_character()
## )
```

```r
DT::datatable(head(datBASE))
```

<!--html_preserve--><div id="htmlwidget-d54c5d3621706115dff3" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-d54c5d3621706115dff3">{"x":{"filter":"none","data":[["1","2","3","4","5","6"],["phd20200701001","phd20200701013","phd20200701002","phd20200701003","phd20200701004","phd20200701005"],["FullPhDleft","ScholarShip_end","MethodsPhD","DiscussionPhDleft","tidyPipesPhD","natureMANUSCRIPT"],["july","june","august","september","october","july"],["1/07/2020","7/07/2020","1/08/2020","1/09/2020","23/07/2020","1/11/2020"],["31/12/2020","9/07/2020","3/08/2020","6/03/2020","8/10/2019","11/05/2019"],["09:00:00",null,"09:00:00","09:00:00","09:00:00","09:00:00"],["15:00:00",null,"15:00:00","15:00:00","15:00:00","15:00:00"],["Just the full length of time I think I will need to finish my PhD project","When my scholarship finished","The core methods papers in the final drafts ready for submission. Reproducibility framework (tidyPipes) and the invasive nz mamals database.","Building the wrapping publication on the application of the invasive species database for community groups and researchers.",null,"Rejected: submit 300 word comment."],["PhD","PhD","PhD","PhD","PhD","PhD"],["Anthony","Anthony","Anthony","Anthony","Anthony","Anthony"],[null,null,null,null,null,null],[2020,2020,2020,2020,2020,2020],["PhDmilestone 1","PhDmilestone 2","PhDmilestone 3","PhDmilestone 4","PhDmilestone 5","PhDmilestone 6"],["On Target","Complete","On Target","On Target","On Target","Complete"],["31/07/2020","2/11/2019","5/11/2019",null,null,"6/11/2019"],["Comments on reproducibility","finish beech draft","2020 draft MPD paper1 simulation and/or case study results?","Working on this in conjunction with first and final thesis chapters around the value of computational reproducibility at a national scale like PFNZ2050","draft MPD paper2 case study results?",null],["Comment to nature draft attached","Currently with Richard","This progress on this is underway",null,null,null]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>eventCode<\/th>\n      <th>shortName<\/th>\n      <th>month<\/th>\n      <th>startDate<\/th>\n      <th>finishDate<\/th>\n      <th>startTime<\/th>\n      <th>endTime<\/th>\n      <th>description<\/th>\n      <th>project<\/th>\n      <th>individualsNEEDED<\/th>\n      <th>week<\/th>\n      <th>year<\/th>\n      <th>milestone<\/th>\n      <th>status<\/th>\n      <th>PreCovidDATE<\/th>\n      <th>Tasks<\/th>\n      <th>Notes<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[11,12]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

```r
#incorperate milestones 
# source(here::here("./vignettes/milestonesfromdataframe.Rmd"), local = TRUE,opts_knit(rmarkdown.html_vignette.check_title = FALSE))
# vignette("./vignettes/milestones-from-dataframe.html")
```


## `.xlsx`

These are excel workbooks. For now this is very simple and works with the current version of excel files (2020). Each "sheet" of the excel file contains a single projects information. This is then converted to a csv file when needed. In the future each project will have its own file that can be added to or modified in a shiny interactive web app.


```r
#excel read

#number of sheets in project currently


## Saved as csv's and imported as so below...
```

> A key aspect of these R scripts is the date format. This has been challenging to work with but currently I have the following notes on the transformation of the date/time data from excel and manually (with csv file below).

## `.csv`

Generally the data can be imported as a csv, or other form. 


```r
library(readr)
emailsCalender1 <- read_csv("data/raw_data/anuemails.CSV")
```

```
## Parsed with column specification:
## cols(
##   .default = col_character(),
##   `Start Time` = col_time(format = ""),
##   `End Time` = col_time(format = ""),
##   `All day event` = col_logical(),
##   `Reminder on/off` = col_logical(),
##   `Reminder Time` = col_time(format = ""),
##   `Billing Information` = col_logical(),
##   Mileage = col_logical(),
##   Private = col_logical(),
##   `Show time as` = col_double()
## )
```

```
## See spec(...) for full column specifications.
```

```r
#str(emailsCalender1)
```

## `.iCal` data


```r
#this currently online
```

## Other data

Bernd and others have made timelines in R using the following R script:



Aspects of this simple timeline are incoperated as so:



### Action tasks

Table by the group of project month or something else???

#### Table 1


```r
table(datBASE1$month, datBASE1$project)
```

```
##            
##             council invert PhD src
##   june            1      4   4   8
##   july            1      0   1   4
##   august          0      8   3   4
##   september       0      0   1   4
##   october         0      0   2   4
##   november        1      0   1   6
##   december        0      0   1  11
```
 
#### Table 2


```r
table(datBASE1$month, datBASE1$project, datBASE1$status)
```

```
## , ,  = At Risk
## 
##            
##             council invert PhD src
##   june            0      0   3   0
##   july            0      0   0   0
##   august          0      0   1   0
##   september       0      0   0   0
##   october         0      0   0   0
##   november        0      0   0   0
##   december        0      0   0   0
## 
## , ,  = Complete
## 
##            
##             council invert PhD src
##   june            0      0   0   0
##   july            0      0   0   0
##   august          0      3   1   4
##   september       0      0   1   4
##   october         0      0   2   0
##   november        0      0   0   0
##   december        0      0   0   0
## 
## , ,  = Critical
## 
##            
##             council invert PhD src
##   june            0      0   0   0
##   july            0      0   1   0
##   august          0      0   0   0
##   september       0      0   0   0
##   october         0      0   0   0
##   november        0      0   0   0
##   december        0      0   0   0
## 
## , ,  = Missed
## 
##            
##             council invert PhD src
##   june            0      0   0   0
##   july            0      0   0   0
##   august          0      1   0   0
##   september       0      0   0   0
##   october         0      0   0   0
##   november        0      0   0   0
##   december        0      0   0   0
## 
## , ,  = On Target
## 
##            
##             council invert PhD src
##   june            1      4   1   8
##   july            1      0   0   4
##   august          0      4   1   0
##   september       0      0   0   0
##   october         0      0   0   4
##   november        1      0   1   6
##   december        0      0   1  11
```

### Milestones timeline

"Coverting a dataframe into a timeline"

### Factoring


```r
#factoring
status_levels <- c("Complete", "On Target", "At Risk", "Critical")

status_colors <- c("#0070C0", "#00B050", "#FFC000", "#C00000")

df$status <- factor(df$status, levels=status_levels, ordered=TRUE)
```



### Direction


```r
#direction
positions <- c(0.5, -0.5, 1.0, -1.0, 1.5, -1.5)
directions <- c(1, -1)

line_pos <- data.frame(
    "date"=unique(df$date),
    "position"=rep(positions, length.out=length(unique(df$date))),
    "direction"=rep(directions, length.out=length(unique(df$date)))
)

df <- merge(x=df, y=line_pos, by="date", all = TRUE)
df <- df[with(df, order(date, status)), ]

df$month_count <- ave(df$date==df$date, df$date, FUN=cumsum)
df$text_position <- (df$month_count * text_offset * df$direction) + df$position
head(df)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["date"],"name":[1],"type":["date"],"align":["right"]},{"label":["startDate"],"name":[2],"type":["chr"],"align":["left"]},{"label":["month"],"name":[3],"type":["fctr"],"align":["left"]},{"label":["year"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["milestone"],"name":[5],"type":["chr"],"align":["left"]},{"label":["status"],"name":[6],"type":["ord"],"align":["right"]},{"label":["shortName"],"name":[7],"type":["chr"],"align":["left"]},{"label":["project"],"name":[8],"type":["chr"],"align":["left"]},{"label":["position"],"name":[9],"type":["dbl"],"align":["right"]},{"label":["direction"],"name":[10],"type":["dbl"],"align":["right"]},{"label":["month_count"],"name":[11],"type":["int"],"align":["right"]},{"label":["text_position"],"name":[12],"type":["dbl"],"align":["right"]}],"data":[{"1":"2020-01-11","2":"11/01/2020","3":"october","4":"2020","5":"PhDmilestone 11","6":"Complete","7":"FINALseminar","8":"PhD","9":"0.5","10":"1","11":"1","12":"0.55","_rn_":"1"},{"1":"2020-03-12","2":"12/03/2020","3":"july","4":"2020","5":"srcmilestone18","6":"On Target","7":"disabilityDay","8":"src","9":"-0.5","10":"-1","11":"1","12":"-0.55","_rn_":"2"},{"1":"2020-06-01","2":"1/06/2020","3":"august","4":"2020","5":"PhDmilestone 10","6":"At Risk","7":"Repropaper","8":"PhD","9":"1.0","10":"1","11":"1","12":"1.05","_rn_":"3"},{"1":"2020-06-03","2":"3/06/2020","3":"september","4":"2020","5":"srcmilestone19","6":"Complete","7":"AcademicBoard","8":"src","9":"-1.0","10":"-1","11":"1","12":"-1.05","_rn_":"4"},{"1":"2020-06-04","2":"4/06/2020","3":"september","4":"2020","5":"srcmilestone20","6":"Complete","7":"AcademicIntegrity","8":"src","9":"1.5","10":"1","11":"1","12":"1.55","_rn_":"5"},{"1":"2020-06-17","2":"17/06/2020","3":"september","4":"2020","5":"srcmilestone21","6":"Complete","7":"GradesReleased","8":"src","9":"-1.5","10":"-1","11":"1","12":"-1.55","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


### Counts


```r
text_offset <- 0.2

df$month_count <- ave(df$date==df$date, df$date, FUN=cumsum)
df$text_position <- (df$month_count * text_offset * df$direction) + df$position
head(df)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["date"],"name":[1],"type":["date"],"align":["right"]},{"label":["startDate"],"name":[2],"type":["chr"],"align":["left"]},{"label":["month"],"name":[3],"type":["fctr"],"align":["left"]},{"label":["year"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["milestone"],"name":[5],"type":["chr"],"align":["left"]},{"label":["status"],"name":[6],"type":["ord"],"align":["right"]},{"label":["shortName"],"name":[7],"type":["chr"],"align":["left"]},{"label":["project"],"name":[8],"type":["chr"],"align":["left"]},{"label":["position"],"name":[9],"type":["dbl"],"align":["right"]},{"label":["direction"],"name":[10],"type":["dbl"],"align":["right"]},{"label":["month_count"],"name":[11],"type":["int"],"align":["right"]},{"label":["text_position"],"name":[12],"type":["dbl"],"align":["right"]}],"data":[{"1":"2020-01-11","2":"11/01/2020","3":"october","4":"2020","5":"PhDmilestone 11","6":"Complete","7":"FINALseminar","8":"PhD","9":"0.5","10":"1","11":"1","12":"0.7","_rn_":"1"},{"1":"2020-03-12","2":"12/03/2020","3":"july","4":"2020","5":"srcmilestone18","6":"On Target","7":"disabilityDay","8":"src","9":"-0.5","10":"-1","11":"1","12":"-0.7","_rn_":"2"},{"1":"2020-06-01","2":"1/06/2020","3":"august","4":"2020","5":"PhDmilestone 10","6":"At Risk","7":"Repropaper","8":"PhD","9":"1.0","10":"1","11":"1","12":"1.2","_rn_":"3"},{"1":"2020-06-03","2":"3/06/2020","3":"september","4":"2020","5":"srcmilestone19","6":"Complete","7":"AcademicBoard","8":"src","9":"-1.0","10":"-1","11":"1","12":"-1.2","_rn_":"4"},{"1":"2020-06-04","2":"4/06/2020","3":"september","4":"2020","5":"srcmilestone20","6":"Complete","7":"AcademicIntegrity","8":"src","9":"1.5","10":"1","11":"1","12":"1.7","_rn_":"5"},{"1":"2020-06-17","2":"17/06/2020","3":"september","4":"2020","5":"srcmilestone21","6":"Complete","7":"GradesReleased","8":"src","9":"-1.5","10":"-1","11":"1","12":"-1.7","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


### Buffering times



```r
month_buffer <- 2

month_date_range <- seq(min(df$date) - months(month_buffer), max(df$date) + months(month_buffer), by='month')
month_format <- format(month_date_range, '%b')
month_df <- data.frame(month_date_range, month_format)
```


### December/January only


```r
year_date_range <- seq(min(df$date) - months(month_buffer), max(df$date) + months(month_buffer), by='year')
year_date_range <- as.Date(
    intersect(
        ceiling_date(year_date_range, unit="year"),
        floor_date(year_date_range, unit="year")
    ),  origin = "1970-01-01"
)
year_format <- format(year_date_range, '%Y')
year_df <- data.frame(year_date_range, year_format)
```


### Interactivity

Shiny....


