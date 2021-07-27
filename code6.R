#Assignment 2
rm(list=ls())
getwd()
dir()
source<-readRDS("Source_Classification_Code.rds")
summary<-readRDS("summarySCC_PM25.rds")
head(source)
head(summary)




#q6
balt<-subset(summary, summary$fips == "24510")
vehicle_balt<-subset(balt, grepl("vehicles" , balt$SCC.Level.Two, ignore.case = T))
vehicle_balt<-merge(vehicle_balt, source, by = "SCC")
vehicle_la<-subset(summary, summary$fips == "06037")
vehicle_la<-merge(vehicle_la, source, by = "SCC")
vehicle_la$SCC.Level.Two
sum(grepl("vehicles" , vehicle_la$SCC.Level.Two, ignore.case = T))
vehicle_la<-subset(vehicle_la, grepl("vehicles" , vehicle_la$SCC.Level.Two, ignore.case = T))
vehicle_la$location<-"LA"
vehicle_balt$location<-"Baltimore"
#balt_la<-rbind(vehicle_balt, vehicle_la)

png("plot6.png")
par(mfrow=c(1,2))
plot(vehicle_balt$year, vehicle_balt$Emissions, col = 2)
abline(lm(vehicle_balt$Emissions~vehicle_balt$year), col = 2)
plot(vehicle_la$year, vehicle_la$Emissions, col = 3)
abline(lm(vehicle_la$Emissions~vehicle_la$year), col = 3)
dev.off()
