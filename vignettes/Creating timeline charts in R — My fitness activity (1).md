Creating timeline charts in R — My fitness activity

[<img width="48" height="48" src="../_resources/8d9828df70824681bd51ee11c33e1489.jpg"/>](https://medium.com/@jeffgriesemer?source=post_page-----58eeb14af3df----------------------)

<img width="680" height="383" src="../_resources/e54f20dcac4e4e7287a0a6d0a66603d0.png"/>

![](../_resources/be2ce28275d64f39b1574975ea5c9bbb.png)

Timeline charts are powerful visual tools that display succession of events in chronological order. Several layers of detail can be added to these charts using shapes, labels, colors and shading. Depending on the timeframes, there charts can be designed to look at long term horizons (years) or drill down into an event to provide minute by minute details.

In this article, we will look at how to create timeline charts using R with a sample dataset from Fitbit activity tracking. Fitbit’s web dashboards provide a summary of one’s activity or details of a specific workout session. However, I was more interested in the intraday activity details. Over the course of a week, what are the times when I am active? Are there specific slots where I can be more active? This was the motivation behind my work with the timeline charts.

The finished chart looks like this —

<img width="680" height="449" src="../_resources/1456c5db27f943e0bccd926e9bea9268.png"/>

![](../_resources/12ed47bd07474f70b41b013d0df809c9.png)

Now, let’s dive into the details

1\. Getting the data

The activity history section on the Fitbit’s web page displays duration of activities with their start timestamps. This data can be copied from the webpage into an Excel file. The next step is to import this Excel file into R with the *read_xlsx* function. This will be stored as a data frame. **r*eadxl*** package is required to call this function.

<a id="45ed"></a>d2 <- read\_xlsx(“C:/TImelineCharts2/activityExport.xlsx”,col\_names = TRUE,sheet=2)

<img width="680" height="463" src="../_resources/f66dcb97ed9641839323e60f3fc0d858.png"/>

![](../_resources/142f7e230ad4427ab9e72cad6c44b49f.png)

2\. Data Transformation

The end goal of this step is to get a day of week, start time, end time, calories and activity type from our data frame. *lubridate* and *chron* packages are a great in dealing with timestamp conversations. Name of the day can be derived from the ‘date’ field. Time and duration give us the start and end times of activities.

\# Changing to appropriate data types

<a id="f6c4"></a>d2$Start_time <- chron(times. = format(strptime(d2$Time,”%I:%M %p”),format = “%H:%M:%S”))<a id="36b6"></a>d2$cals <- as.numeric(d2$cals)

\# Converting time to hours

<a id="c412"></a>d2$duration <- hours(d2$Duration)+(minutes(d2$Duration)/60)+(seconds(d2$Duration)/3600)<a id="051d"></a>d2$start\_time <- hours(d2$Start\_time)+(minutes(d2$Start\_time)/60)+(seconds(d2$Start\_time)/3600)

\# End time calculation from start time and duration of activity

<a id="c754"></a>d2$end\_time <- d2$start\_time+d2$duration

3\. Generating Timeline charts

We will use *ggplot* function from *ggplot2* package to generate timeline charts. The following functions are used to add layers of details to the chart -

geom_segment : creates each activity block

scale\_color\_manual : adds colors by activity type; color types have to be provided manually

scale\_color\_gradient2 : adds color gradient based on calories burnt; more the calories burnt, the darker the shade

geom\_label\_repel : adds labels to the plot

ggtitle : adds a title to the chart

<a id="13a5"></a>ggplot(d2) +   
geom\_segment(aes(x=start\_time,xend=end_time, y=Day, yend=Day, color=Activity),size=10)+   
scale\_color\_manual(values=colors)+labs(x = “Time (hrs)”)+  
labs(y = “Day of week”) +<a id="afc0"></a>geom\_text\_repel(aes(x=((d2$start_time)+(d2$duration/2)),y=d2$Day,label=round((d2$duration*60),digits=0)), box.padding=1, point.padding=1) +  
ggtitle(“Workout Activity Timeline”) +  
theme(plot.title=element\_text(hjust=0.5),text=element\_text(size=20)

<img width="680" height="195" src="../_resources/27003124fef04683978fc61b0f856537.png"/>

Zoomed view of a timeline with activity types and duration (min) as labels

<img width="680" height="357" src="../_resources/a89ff4ece8934d469fa5ce1436f8dc26.png"/>

Workout timeline with a heat-map of calories burnt with activity type

Timeline charts can be used in a lot of applications like tracking equipment or a process status changes, resource availability & scheduling, project timelines, documenting start and end times of events. The beauty of ggplot2 package is that the code can be easily customized, and more details can be added to the plots.