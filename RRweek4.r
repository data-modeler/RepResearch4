


## Title that Summarizes the Data Analysis

## Abstract summary of the analysis

## Section called "Data Analysis" showing loading of data and processing
library(ggplot2)
library(scales)
Storm <- read.csv("StormData.csv.bz2")
str(Storm)
## Data Transformations
Storm$CASUALTIES <- Storm$FATALITIES + Storm$INJURIES
Storm$ECONDMG <- Storm$PROPDMG + Storm$CROPDMG

## Section called "Results"
econ.sum <- aggregate(Storm$ECONDMG, by=list(Storm$EVTYPE), FUN=sum, na.rm=T) 
econ.sum <- econ.sum[order(econ.sum$x,decreasing = TRUE),]
econ.sum$x <- econ.sum$x / 1000
econ.sum$Group.1 <- factor(econ.sum$Group.1, levels = econ.sum$Group.1[order(econ.sum$x, decreasing = TRUE)])

qplot(Group.1, data=econ.sum[1:10,],geom="bar", weight=x, fill=I("darkblue")) + 
  ggtitle("Top 10 Most Economically Damaging Event Types") +
  xlab("Event Type") +
  theme(axis.text.x=element_text(angle=45,hjust=1)) +
  scale_y_continuous("Economic Damage in USD",label=dollar_format(prefix="$",suffix="K"))

casl.sum <- aggregate(Storm$CASUALTIES, by=list(Storm$EVTYPE), FUN=sum, na.rm=T)
casl.sum <- casl.sum[order(casl.sum$x,decreasing = TRUE),]
casl.sum$x <- casl.sum$x / 1000
casl.sum$Group.1 <- factor(casl.sum$Group.1, levels=casl.sum$Group.1[order(casl.sum$x,decreasing = TRUE)])
qplot(Group.1, data=casl.sum[1:10,],geom="bar", weight=x, fill=I("darkblue")) + 
  ggtitle("Top 10 Most Harmful Event Types") +
  xlab("Event Type") +
  theme(axis.text.x=element_text(angle=45,hjust=1)) +
  scale_y_continuous("Total Number of Casualties",label=dollar_format(prefix="",suffix="K"))

## At least one plot (no more than 3) with Caption

## Which types of events are most harmful to population health?
Storm$EVTYPE

## Which types of events have the greatest economic consequences?


