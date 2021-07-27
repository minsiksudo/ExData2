#Assignment 2
rm(list=ls())
getwd()
dir()
source<-readRDS("Source_Classification_Code.rds")
summary<-readRDS("summarySCC_PM25.rds")
head(source)
head(summary)

#q4 match both data files into one file
merged<-merge(summary, source, by = "SCC")
table(merged$EI.Sector)
#Fule comb
coal<-subset(merged, merged$EI.Sector == "Fuel Comb - Comm/Institutional - Coal")
coal<-coal[,1:6]
coal
boxplot(coal$Emissions~coal$year)
png("plot4.png")
boxplot(coal$Emissions~coal$year, ylim = c(0,2))
dev.off()
