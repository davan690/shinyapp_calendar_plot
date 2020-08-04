---
alway_keep_html: true
---




# Visualisation {.tabset}

Generally the concept is to create a baseline dataset of information and then extend this using `dataspice` to create a tidy format of data that can then be modelled and visualised using the `tidyverse` suite of tools.

[*Creating timeline charts in R (Generating Timeline charts: Blog online)*]()

### Action tasks

Table by the group of project month or something else???

#### Table 1


```r
table(datBASE1$month, datBASE1$project)
```

```
##            
##             council finances invert PhD src
##   january         0        6      0   0   0
##   february        1        4      4   5   8
##   march           1        3      0   1   4
##   april           0        3      8   3   4
##   may             0        8      0   1   4
##   june            0        9      0   0   0
##   july            0        3      0   0   0
##   august          0        0      0   2   4
##   september       1        0      0   1   6
##   october         0        3      0   1  11
##   november        0        0      0   0   0
##   december        0        0      0   0   0
```
 
#### Table 2


```r
table(datBASE1$month, datBASE1$project, datBASE1$status)
```

```
## , ,  = At Risk
## 
##            
##             council finances invert PhD src
##   january         0        0      0   0   0
##   february        0        0      0   3   0
##   march           0        0      0   0   0
##   april           0        0      0   1   0
##   may             0        0      0   0   0
##   june            0        0      0   0   0
##   july            0        0      0   0   0
##   august          0        0      0   0   0
##   september       0        0      0   0   0
##   october         0        0      0   0   0
##   november        0        0      0   0   0
##   december        0        0      0   0   0
## 
## , ,  = Complete
## 
##            
##             council finances invert PhD src
##   january         0        0      0   0   0
##   february        0        0      0   0   0
##   march           0        0      0   0   0
##   april           0        0      3   1   4
##   may             0        0      0   1   4
##   june            0        0      0   0   0
##   july            0        0      0   0   0
##   august          0        0      0   2   0
##   september       0        0      0   0   0
##   october         0        0      0   0   0
##   november        0        0      0   0   0
##   december        0        0      0   0   0
## 
## , ,  = Critical
## 
##            
##             council finances invert PhD src
##   january         0        0      0   0   0
##   february        0        0      0   0   0
##   march           0        0      0   1   0
##   april           0        0      0   0   0
##   may             0        0      0   0   0
##   june            0        0      0   0   0
##   july            0        0      0   0   0
##   august          0        0      0   0   0
##   september       0        0      0   0   0
##   october         0        0      0   0   0
##   november        0        0      0   0   0
##   december        0        0      0   0   0
## 
## , ,  = Missed
## 
##            
##             council finances invert PhD src
##   january         0        0      0   0   0
##   february        0        0      0   0   0
##   march           0        0      0   0   0
##   april           0        0      1   0   0
##   may             0        0      0   0   0
##   june            0        0      0   0   0
##   july            0        0      0   0   0
##   august          0        0      0   0   0
##   september       0        0      0   0   0
##   october         0        0      0   0   0
##   november        0        0      0   0   0
##   december        0        0      0   0   0
## 
## , ,  = On Target
## 
##            
##             council finances invert PhD src
##   january         0        0      0   0   0
##   february        1        0      4   1   8
##   march           1        0      0   0   4
##   april           0        0      4   1   0
##   may             0        0      0   0   0
##   june            0        0      0   0   0
##   july            0        0      0   0   0
##   august          0        0      0   0   4
##   september       1        0      0   1   6
##   october         0        0      0   1  11
##   november        0        0      0   0   0
##   december        0        0      0   0   0
```

To do this I have created a calendar for each key project/impact/aspect of short-term timeline, objectives, as well as, my career and life projection. To begin with I need to create timelines and other project goals under covid19. I have put this into a single dataset called `dat` here.

These figures can be generated using `ggplot` and other `tidyverse` approaches due to the implantation of the `dataspice` packages above. We will use *ggplot* function from *ggplot2* package to generate timeline charts. The following plots can be created using layers to detail charts.

## `ggplot2` {.tabset}

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
library(lubridate)
df <- readr::read_csv(here::here('./data/milestones.csv'))
```

```
## Parsed with column specification:
## cols(
##   month = col_double(),
##   year = col_double(),
##   milestone = col_character(),
##   status = col_character()
## )
```

```r
df$date <- with(df, ymd(sprintf('%04d%02d%02d', year, month, 1)))
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
text_offset <- 0.2

df$text_position <- (df$month_count * text_offset * df$direction) + df$position
head(df)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["date"],"name":[1],"type":["date"],"align":["right"]},{"label":["month"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["year"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["milestone"],"name":[4],"type":["chr"],"align":["left"]},{"label":["status"],"name":[5],"type":["chr"],"align":["left"]},{"label":["position"],"name":[6],"type":["dbl"],"align":["right"]},{"label":["direction"],"name":[7],"type":["dbl"],"align":["right"]},{"label":["month_count"],"name":[8],"type":["int"],"align":["right"]},{"label":["text_position"],"name":[9],"type":["dbl"],"align":["right"]}],"data":[{"1":"2017-06-01","2":"6","3":"2017","4":"Milestone 1","5":"Complete","6":"0.5","7":"1","8":"1","9":"0.7","_rn_":"1"},{"1":"2017-07-01","2":"7","3":"2017","4":"Milestone 2","5":"Complete","6":"-0.5","7":"-1","8":"1","9":"-0.7","_rn_":"2"},{"1":"2017-10-01","2":"10","3":"2017","4":"Milestone 3","5":"Complete","6":"1.0","7":"1","8":"1","9":"1.2","_rn_":"3"},{"1":"2017-12-01","2":"12","3":"2017","4":"Milestone 4","5":"Complete","6":"-1.0","7":"-1","8":"1","9":"-1.2","_rn_":"4"},{"1":"2018-01-01","2":"1","3":"2018","4":"Milestone 5","5":"Complete","6":"1.5","7":"1","8":"1","9":"1.7","_rn_":"5"},{"1":"2018-01-01","2":"1","3":"2018","4":"Milestone 6","5":"Complete","6":"1.5","7":"1","8":"2","9":"1.9","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
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
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["date"],"name":[1],"type":["date"],"align":["right"]},{"label":["month"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["year"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["milestone"],"name":[4],"type":["chr"],"align":["left"]},{"label":["status"],"name":[5],"type":["chr"],"align":["left"]},{"label":["position"],"name":[6],"type":["dbl"],"align":["right"]},{"label":["direction"],"name":[7],"type":["dbl"],"align":["right"]},{"label":["month_count"],"name":[8],"type":["int"],"align":["right"]},{"label":["text_position"],"name":[9],"type":["dbl"],"align":["right"]}],"data":[{"1":"2017-06-01","2":"6","3":"2017","4":"Milestone 1","5":"Complete","6":"0.5","7":"1","8":"1","9":"0.7","_rn_":"1"},{"1":"2017-07-01","2":"7","3":"2017","4":"Milestone 2","5":"Complete","6":"-0.5","7":"-1","8":"1","9":"-0.7","_rn_":"2"},{"1":"2017-10-01","2":"10","3":"2017","4":"Milestone 3","5":"Complete","6":"1.0","7":"1","8":"1","9":"1.2","_rn_":"3"},{"1":"2017-12-01","2":"12","3":"2017","4":"Milestone 4","5":"Complete","6":"-1.0","7":"-1","8":"1","9":"-1.2","_rn_":"4"},{"1":"2018-01-01","2":"1","3":"2018","4":"Milestone 5","5":"Complete","6":"1.5","7":"1","8":"1","9":"1.7","_rn_":"5"},{"1":"2018-01-01","2":"1","3":"2018","4":"Milestone 6","5":"Complete","6":"1.5","7":"1","8":"2","9":"1.9","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
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


