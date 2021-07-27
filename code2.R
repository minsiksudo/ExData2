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
boxplot(balt$Emissions~balt$year)
#data without outliars
boxplot(balt$Emissions~balt$year, ylim = c(0, 10))
png("plot2.png")
plot(balt$year, balt$Emissions)
abline(lm(balt$Emissions~balt$year), col=(1))
dev.off()
