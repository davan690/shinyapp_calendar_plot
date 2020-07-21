# Methods {.tabset}

As computational work takes over our regular management of time over the tradional hard copy "diary". I like this because important information can not be left in the "local cafe" however as I have used "gmail", "outlook" and there suites of applications and tools for calenders I have muddled everything up and missed appointments etc. 

To try and counter this I have developed a `tidypipes` workflow for my tasks, projects and other collarorations. See presentation [here](./assets/TidyPipes-calenderJUL2020.pptx).



### Data/information {.tabset}



Overall this is time series data. A good general tutorial for this sort of data is here on [youtube]("https://www.youtube.com/watch?v=uenWg7ZSu4Y"). There are several ways to visualise this data, below are two selected bits of code that do this. Overall there are two generalised datasets that may be helpful to other individuals for each project or combination of projects (for the APR for example).

#### Plot 1



#### Plot 2



### Baseline dataset

The data for this collection of tasks associated with timelines and targets. The baseline dataset is found in the `.xlsx` file named "baseline-dataset-calender.xlsx". This is the base file I have been adding information to when I change the overall structure of the calendar projects.

#### `.xlsx`

These are excel workbooks. For now this is very simple and works with the current version of excel files (2020). 

Each "sheet" of the excel file contains a single projects information. This is then converted to a csv file when needed. In the future each project will have its own file that can be added to or modified in a shiny interactive web app.


```r
#excel read

#number of sheets in project currently


## Saved as csv's and imported as so below...
```

#### `.csv`

Generally the data can be imported as a csv, or other form. 


```r
library(readr)
```

```
## Warning: package 'readr' was built under R version 4.0.2
```

```r
emailsCalender1 <- read_csv("data/anuemails.CSV")
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

#### `.iCal`

For calendars in Outlook the file type is `iCal`. There are packages that deal with these files in R. There is alot of my development work in this section because I need a way to document all the council emails and other work that I have undertaken as part of the `COVID19` pandemic in Australia.


```r
#ical data
#export 
```

##### `ical` documentation [Robin Lovelace] calendar allows you to read-in `ical files` (which typically have the `.ics` filetype) with `ic_read()`. 

However, often it’s useful to create your own `ical` object from scratch. The purpose of this vignette is to show how, with reference to a real-world application: creating a timetable for a new module.

It assumes you’ve installed the package following instructions in the README and have attached it as follows:


```r
library(calendar)
```

```
## Warning: package 'calendar' was built under R version 4.0.2
```

```r
#> Warning: package 'calendar' was built under R version 4.0.2
```

###### Creating events

The building blocks of most calendars the event. All events have a start point and an end point (unless they are an all day event) and a summary description. As shown in the example below, they also tend to contain other fields.


```r
# key:value pairs in an ical example:
ic_list(ical_example)[[1]]
```

```
##  [1] "DTSTART:20180809T160000Z"                 
##  [2] "DTEND:20180809T163000Z"                   
##  [3] "DTSTAMP:20180810T094100Z"                 
##  [4] "UID:1119ejg4vug5758527atjcrqj3@google.com"
##  [5] "CREATED:20180807T133712Z"                 
##  [6] "DESCRIPTION:\\n"                          
##  [7] "LAST-MODIFIED:20180807T133712Z"           
##  [8] "LOCATION:"                                
##  [9] "SEQUENCE:0"                               
## [10] "STATUS:CONFIRMED"                         
## [11] "SUMMARY:ical programming mission"         
## [12] "TRANSP:OPAQUE"
```

```r
#>  [1] "DTSTART:20180809T160000Z"                 
#>  [2] "DTEND:20180809T163000Z"                   
#>  [3] "DTSTAMP:20180810T094100Z"                 
#>  [4] "UID:1119ejg4vug5758527atjcrqj3@google.com"
#>  [5] "CREATED:20180807T133712Z"                 
#>  [6] "DESCRIPTION:\\n"                          
#>  [7] "LAST-MODIFIED:20180807T133712Z"           
#>  [8] "LOCATION:"                                
#>  [9] "SEQUENCE:0"                               
#> [10] "STATUS:CONFIRMED"                         
#> [11] "SUMMARY:ical programming mission"         
#> [12] "TRANSP:OPAQUE"
```

Fortunately you don’t need to specify all of these when creating events because some will be created manually and some are not necessary. Events can be created as follows (this one creates a 5 day trip):


```r
library(calendar)
s = as.POSIXct("2019-01-12")
e = s + 60^2 * 24 *5
event = ic_event(start = s, end = e , summary = "Research trip")
event
```

```
## # A tibble: 1 x 4
##   UID                         DTSTART             DTEND               SUMMARY   
##   <chr>                       <dttm>              <dttm>              <chr>     
## 1 ical-0a7e1478-d6e4-44ed-8b~ 2019-01-12 00:00:00 2019-01-17 00:00:00 Research ~
```

```r
#> # A tibble: 1 x 4
#>   UID                         DTSTART             DTEND               SUMMARY   
#>   <chr>                       <dttm>              <dttm>              <chr>     
#> 1 ical-6742dca9-cef7-4377-9c~ 2019-01-12 00:00:00 2019-01-17 00:00:00 Research ~
class(event)
```

```
## [1] "ical"       "tbl_df"     "tbl"        "data.frame"
```

```r
#> [1] "ical"       "tbl_df"     "tbl"        "data.frame"
ic_character(event)
```

```
##  [1] "BEGIN:VCALENDAR"                              
##  [2] "PRODID:-//ATFutures/ical //EN"                
##  [3] "VERSION:2.0"                                  
##  [4] "CALSCALE:GREGORIAN"                           
##  [5] "METHOD:PUBLISH"                               
##  [6] "BEGIN:VEVENT"                                 
##  [7] "UID:ical-0a7e1478-d6e4-44ed-8bc1-ebd7b0d6bc1d"
##  [8] "DTSTART:20190112T000000"                      
##  [9] "DTEND:20190117T000000"                        
## [10] "SUMMARY:Research trip"                        
## [11] "END:VEVENT"                                   
## [12] "END:VCALENDAR"
```

```r
#>  [1] "BEGIN:VCALENDAR"                              
#>  [2] "PRODID:-//ATFutures/ical //EN"                
#>  [3] "VERSION:2.0"                                  
#>  [4] "CALSCALE:GREGORIAN"                           
#>  [5] "METHOD:PUBLISH"                               
#>  [6] "BEGIN:VEVENT"                                 
#>  [7] "UID:ical-6742dca9-cef7-4377-9c05-7bc4913eaacb"
#>  [8] "DTSTART:20190112T000000"                      
#>  [9] "DTEND:20190117T000000"                        
#> [10] "SUMMARY:Research trip"                        
#> [11] "END:VEVENT"                                   
#> [12] "END:VCALENDAR"
```

### Summarised actions

These sources of data are combined for my general timeline below.


```r
# DT::datatable(emailsCalender1)
## handmade data
DT::datatable(data_actions)
```

<!--html_preserve--><div id="htmlwidget-593da69fd3b6c22cb207" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-593da69fd3b6c22cb207">{"x":{"filter":"none","data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","151","152","153","154","155","156","157","158","159","160","161","162","163","164","165","166","167","168","169","170","171","172","173","174","175","176","177","178","179","180","181","182","183","184","185","186","187","188","189","190","191","192","193","194","195","196","197","198","199","200","201","202","203","204","205","206","207","208","209","210","211","212","213","214","215","216","217","218","219","220","221","222","223","224","225","226","227","228","229","230","231","232","233","234","235","236","237","238","239","240","241","242","243","244","245","246","247","248"],[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31],[null,null,"Academic Board (Majid/Josh)","Academic Integrity Mtg (Lola/Hamish/Nick)                               Student Equity &amp; Advisory Group (TBD)",null,null,null,null,null,null,"Grades Released","WT Census",null,null,null,null,"UEC (Josephine)",null,null,"World Refugee Day",null,null,null,null,null,"Council (Emma/Anthony)",null,null,null,null,null,null,null,null,null,null,null,null,null,"URC",null,null,null,null,null,"UEC (Josephine)","UAC (Josephine)",null,null,null,null,null,null,null,null,null,null,"Orientation Sem 2",null,null,null,null,null,null,"Wk 1",null,"Academic Board (Majid/Josh)",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,"Council (Emma/Anthony)",null,null,null,null,null,"URC","Census Date",null,null,null,null,"UEC (Josephine)","UAC (Josephine) RUOK Day",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,"Academic Board (Josh/Majid)",null,null,null,null,null,null,null,null,null,null,"Mental Health Day",null,null,null,null,null,null,null,null,null,null,null,"URC","Council (Emma/Anthony)",null,null,null,null,"UEC (Josephine)","UAC (Josephine)",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,"NAIDOC WEEK",null,null,null,null,null,null,null,null,null,"Academic Board (Josh/Majid)",null,null,null,null,null,null,null,null,null,null,null,null,null,null,"UEC (Josephine)",null,null,null,null,null,null,null,null,"Council (Emma/Anthony)",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],["june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","june","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","july","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","august","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","september","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","october","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","november","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december","december"],[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],[null,null,null,"z",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>Day<\/th>\n      <th>action<\/th>\n      <th>month<\/th>\n      <th>notes<\/th>\n      <th>eventCode<\/th>\n      <th>...6<\/th>\n      <th>...7<\/th>\n      <th>...8<\/th>\n      <th>...9<\/th>\n      <th>...10<\/th>\n      <th>...11<\/th>\n      <th>...12<\/th>\n      <th>...13<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":1},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

## Timeline {.tabset}

One of the tricky bits about timelines is the format of the date and time of each event. This is different for each event so therefore we have four columns to incorporate this information in the following from for this repository and database. This will also mean that some of the information in other formats will have to be converted into these dimension and any other elements defined in each dataset I am combining to make a overall timeline.

### Overall timeline

By integrating these stage with some `dataspice` code/approach's allows for me to generate metadata from each sheet of the excel file quickly using R. Here are the steps to do this.


```r
#dataspice from github
library(dataspice)

#each project needs to be imported and then saved as csv in raw_data file to document variable names etc correctly into the json dataset.
# raw_data <- 
project2 <- readxl::read_excel("./data/Sem two planning.xlsx", sheet = 4)
project2
```

```
## # A tibble: 22 x 9
##    eventCode  shortName month startDate finishDate description src   ucX   week 
##    <chr>      <chr>     <chr> <chr>     <chr>      <chr>       <lgl> <lgl> <lgl>
##  1 scr202007~ WorldRef~ june  20/06/20~ 20/06/2020 World Refu~ NA    NA    NA   
##  2 scr202007~ Oweek     july  <NA>      <NA>       O week for~ NA    NA    NA   
##  3 scr202007~ ReasonSt~ augu~ <NA>      <NA>       Statement ~ NA    NA    NA   
##  4 scr202007~ SSAFsurv~ augu~ <NA>      <NA>       SSAF Survey NA    NA    NA   
##  5 scr202007~ TownHall2 augu~ <NA>      <NA>       Town HAll   NA    NA    NA   
##  6 scr202007~ openDay   augu~ <NA>      <NA>       Open Day 2~ NA    NA    NA   
##  7 scr202007~ nic21st   augu~ <NA>      <NA>       Nicks 21st~ NA    NA    NA   
##  8 scr202007~ SSAFbids  sept~ <NA>      <NA>       SSAF Bids ~ NA    NA    NA   
##  9 scr202007~ Grad      sept~ <NA>      <NA>       Graduation  NA    NA    NA   
## 10 scr202007~ SSAFFunds sept~ <NA>      <NA>       SSAF Commi~ NA    NA    NA   
## # ... with 12 more rows
```

```r
#date

#time

#location
```

### Figures

These can be generated using `ggplot` and other `tidyverse` approaches due to the implantation of the `dataspice` packages above.


```r
library(ggplot2)
```

```
## Warning: package 'ggplot2' was built under R version 4.0.2
```

## Individual projects {.tabset}

Each of my tasks come from a collection of overall projects I collaborate on and develop code with on timeframes that range from monthly to undefined. The current projects I have integrated into my timeline are:

### PhD

Over the duration of my PhD I have currently developed my thesis and publications to align with a 6 month hand-in date from the 1st July 2020.


```r
project1 <- readxl::read_excel("./data/Sem two planning.xlsx", sheet = 3)

DT::datatable(head(project1))
```

<!--html_preserve--><div id="htmlwidget-fa39fd415ffd86764484" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-fa39fd415ffd86764484">{"x":{"filter":"none","data":[["1","2","3","4","5","6"],["phd20200701001","phd20200701013","phd20200701002","phd20200701003","phd20200701004","phd20200701005"],["FullPhDleft",null,"MethodsPhD","DiscussionPhDleft","tidyPipesPhD","natureleft"],["july",null,"august","september","october","november"],["2020-07-01T00:00:00Z",null,"2020-08-01T00:00:00Z","2020-09-01T00:00:00Z","2020-10-01T00:00:00Z","2020-11-01T00:00:00Z"],["2020-12-31T00:00:00Z",null,"2020-08-03T00:00:00Z","2020-03-06T00:00:00Z","2019-10-08T00:00:00Z","2019-05-11T00:00:00Z"],["1899-12-31T09:00:00Z",null,"1899-12-31T09:00:00Z","1899-12-31T09:00:00Z","1899-12-31T09:00:00Z","1899-12-31T09:00:00Z"],["1899-12-31T15:00:00Z",null,"1899-12-31T15:00:00Z","1899-12-31T15:00:00Z","1899-12-31T15:00:00Z","1899-12-31T15:00:00Z"],["Just the full length of time I need to finish my PhD project",null,null,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>eventCode<\/th>\n      <th>shortName<\/th>\n      <th>month<\/th>\n      <th>startDate<\/th>\n      <th>finishDate<\/th>\n      <th>startTime<\/th>\n      <th>endTime<\/th>\n      <th>description<\/th>\n      <th>src<\/th>\n      <th>ucX<\/th>\n      <th>week<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"order":[],"autoWidth":false,"orderClasses":false,"columnDefs":[{"orderable":false,"targets":0}]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->



#### Introduction

#### Methods

#### Conclusion

#### Discussion



### Previous achievements and tasks





## Council tasks {.tabset}

Being nominated to represent the Graduate community on the University of Canberra Council in November 2019 was a great honour. At the time I did understand the impact of 


```r
project2 <- readxl::read_excel("./data/Sem two planning.xlsx", sheet = 4)

DT::datatable(head(project2))
```

<!--html_preserve--><div id="htmlwidget-874a6f934fa7db2d0d3a" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-874a6f934fa7db2d0d3a">{"x":{"filter":"none","data":[["1","2","3","4","5","6"],["scr20200701001","scr20200701002","scr20200701003","scr20200701004","scr20200701005","scr20200701006"],["WorldRefDay","Oweek","ReasonStatement","SSAFsurvey","TownHall2","openDay"],["june","july","august","august","august","august"],["20/06/2020",null,null,null,null,null],["20/06/2020",null,null,null,null,null],["World Refugee Day","O week for semester two","Statement of reasons due (late Aug)","SSAF Survey","Town HAll","Open Day 22nd"],[null,null,null,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>eventCode<\/th>\n      <th>shortName<\/th>\n      <th>month<\/th>\n      <th>startDate<\/th>\n      <th>finishDate<\/th>\n      <th>description<\/th>\n      <th>src<\/th>\n      <th>ucX<\/th>\n      <th>week<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"order":[],"autoWidth":false,"orderClasses":false,"columnDefs":[{"orderable":false,"targets":0}]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

### UC-Council

Generally it is regarded that there will be about a week (40hrs) of background reading and investigation before each council meeting. Under covid19 conditions I think this may be much greater.

Here are the general tasks and overall timetable of the Council obligations in 2020:


```r
dataCouncil <- readxl::read_excel("./data/Sem two planning.xlsx", sheet = 3)

DT::datatable(head(dataCouncil))
```

<!--html_preserve--><div id="htmlwidget-cf0f84de3f0750a8039d" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-cf0f84de3f0750a8039d">{"x":{"filter":"none","data":[["1","2","3","4","5","6"],["phd20200701001","phd20200701013","phd20200701002","phd20200701003","phd20200701004","phd20200701005"],["FullPhDleft",null,"MethodsPhD","DiscussionPhDleft","tidyPipesPhD","natureleft"],["july",null,"august","september","october","november"],["2020-07-01T00:00:00Z",null,"2020-08-01T00:00:00Z","2020-09-01T00:00:00Z","2020-10-01T00:00:00Z","2020-11-01T00:00:00Z"],["2020-12-31T00:00:00Z",null,"2020-08-03T00:00:00Z","2020-03-06T00:00:00Z","2019-10-08T00:00:00Z","2019-05-11T00:00:00Z"],["1899-12-31T09:00:00Z",null,"1899-12-31T09:00:00Z","1899-12-31T09:00:00Z","1899-12-31T09:00:00Z","1899-12-31T09:00:00Z"],["1899-12-31T15:00:00Z",null,"1899-12-31T15:00:00Z","1899-12-31T15:00:00Z","1899-12-31T15:00:00Z","1899-12-31T15:00:00Z"],["Just the full length of time I need to finish my PhD project",null,null,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>eventCode<\/th>\n      <th>shortName<\/th>\n      <th>month<\/th>\n      <th>startDate<\/th>\n      <th>finishDate<\/th>\n      <th>startTime<\/th>\n      <th>endTime<\/th>\n      <th>description<\/th>\n      <th>src<\/th>\n      <th>ucX<\/th>\n      <th>week<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"order":[],"autoWidth":false,"orderClasses":false,"columnDefs":[{"orderable":false,"targets":0}]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

### UC-SRC

This is a short demo site to help with planning for the SRC for semester 2 2020.



### Supporting Reproducibility at UC

My Phd studies put me in a unique situation where I can apply the tools and computational development I have done with my PhD and conceptually test the framework for the application in the education sector. 

- `UCdown`
- `councilCOMOS`
- `UCSRC covid support`

## UC-Invertebrates

This work has its own repository so far.



```r
project3 <- readxl::read_excel("./data/Sem two planning.xlsx", sheet = 5)

DT::datatable(head(project3))
```

<!--html_preserve--><div id="htmlwidget-d8cbd41bf46668708a4a" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-d8cbd41bf46668708a4a">{"x":{"filter":"none","data":[["1","2","3","4","5","6"],["invert20200701001","invert20200701002","invert20200701003","invert20200701004","invert20200701005","invert20200701006"],["firstMEET","secondMEET",null,null,null,null],["july","july",null,null,null,null],["2020-07-01T00:00:00Z","2020-07-01T00:00:00Z",null,null,null,null],["2020-07-01T00:00:00Z","2020-08-03T00:00:00Z",null,null,null,null],["1899-12-31T09:00:00Z","1899-12-31T09:00:00Z",null,null,null,null],["1899-12-31T15:00:00Z","1899-12-31T15:00:00Z",null,null,null,null],["Just the full length of time I need to finish my invert project",null,null,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null],[null,null,null,null,null,null]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>eventCode<\/th>\n      <th>shortName<\/th>\n      <th>month<\/th>\n      <th>startDate<\/th>\n      <th>finishDate<\/th>\n      <th>startTime<\/th>\n      <th>endTime<\/th>\n      <th>description<\/th>\n      <th>src<\/th>\n      <th>ucX<\/th>\n      <th>week<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"order":[],"autoWidth":false,"orderClasses":false,"columnDefs":[{"orderable":false,"targets":0}]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
