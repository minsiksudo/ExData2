#Assignment 2
rm(list=ls())
getwd()
dir()
source<-readRDS("Source_Classification_Code.rds")
summary<-readRDS("summarySCC_PM25.rds")
head(source)
head(summary)


#q5
balt<-subset(summary, summary$fips == "24510")
balt<-merge(balt, source, by = "SCC")
balt
summary(balt$SCC.Level.Two)
# 5 sources are vehicles
balt$SCC.Level.Two
sum(grepl("vehicles" , balt$SCC.Level.Two, ignore.case = T))
vehicle_balt<-subset(balt, grepl("vehicles" , balt$SCC.Level.Two, ignore.case = T))
vehicle_balt
boxplot(vehicle_balt$Emissions~vehicle_balt$year)
png("plot5.png")
plot(vehicle_balt$year, vehicle_balt$Emissions, col = 2)
abline(lm(vehicle_balt$Emissions~vehicle_balt$year), col = 2)
dev.off()
