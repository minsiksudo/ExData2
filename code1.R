#Assignment 2
rm(list=ls())
getwd()
dir()
source<-readRDS("Source_Classification_Code.rds")
summary<-readRDS("summarySCC_PM25.rds")
head(source)
head(summary)

#q1-plotting 199 2002 2005 and 2008
png("plot1.png")
boxplot(summary$Emissions ~ summary$year)
dev.off()
