# Introduction {.tabset}

Navigating the path between graduate studies and an academic career is adiffucult task at the best of times. One of the key steps in becoming a setablish researcher in the current academic enviroment. To do this efficetifcely, time management is key, however when there are so many little projects running it can be hard to know what to work on. 

<img src="./img/TidyPipes-calenderJUL2020.png" width="640" />

This document is to record the method to proposing my 6month timeline for my PhD completion, as well as, showing the key aspects of the `tidyPipes` approach to research and the draft project plan for the inveribrate work I am proposing to do with Ben Kefford's lab.

## Data setup

Generally the concept is to create a baseline dataset of information and then extend this using `dataspice` to create a tidy format of data that can then be modelled and visualised using the `tidyverse` suite of tools.


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

## Visualisation

*Creating timeline charts in R (Generating Timeline charts)*

We will use *ggplot* function from *ggplot2* package to generate timeline charts. The following functions are used to add layers of details to the chart. Workout timeline with a heat-map of calories burnt with activity type

Timeline charts can be used in a lot of applications like tracking equipment or a process status changes, resource availability & scheduling, project timelines, documenting start and end times of events. The beauty of ggplot2 package is that the code can be easily customized, and more details can be added to the plots.

To do this I have created a calendar for each key project/impact/aspect of short-term timeline, objectives, as well as, my career and life projection. To begin with I need to create timelines and other project goals under covid19. I have put this into a single dataset called `dat` here.

## Feedback loop

To create the feedback loop (to get information back from supervisors) I have began to develop a interactive shiny app within the same structure as the baseline dataset so that there is limited coding needed to create the tidypipes "cycle" of community engagement.


```r
library(knitr)
knitr::include_graphics(path = "./img/preview.png")
```

<img src="./img/preview.png" width="650" />


