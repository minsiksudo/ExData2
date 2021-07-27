#Assignment 2
rm(list=ls())
getwd()
dir()
source<-readRDS("Source_Classification_Code.rds")
summary<-readRDS("summarySCC_PM25.rds")
head(source)
head(summary)


#q2-subsetting the Baltimore data
balt<-subset(summary, summary$fips == "24510")

#q3
library(ggplot2)

p<-ggplot(balt, aes(x = year, y = Emissions))
p<-p+geom_point(aes(color = type))
png("plot3.png")
p+ geom_smooth(aes(color=type),
               method = "nls", formula = y ~ a * x + b, se = FALSE,
               method.args = list(start = list(a = 0.1, b = 0.1)))
dev.off()
