#Assignment 2
rm(list=ls())
getwd()
dir()
source<-readRDS("Source_Classification_Code.rds")
summary<-readRDS("summarySCC_PM25.rds")
head(source)
head(summary)

#q1-plotting 199 2002 2005 and 2008
boxplot(summary$Emissions ~ summary$year)

#q2-subsetting the Baltimore data
balt<-subset(summary, summary$fips == "24510")
boxplot(balt$Emissions~balt$year)
#data without outliars
boxplot(balt$Emissions~balt$year, ylim = c(0, 10))
plot(balt$year, balt$Emissions)
abline(lm(balt$Emissions~balt$year), col=(1))

#q3
library(ggplot2)
p<-ggplot(balt, aes(x = year, y = Emissions))
p<-p+geom_point(aes(color = type))
p+ geom_smooth(aes(color=type),
                 method = "nls", formula = y ~ a * x + b, se = FALSE,
                 method.args = list(start = list(a = 0.1, b = 0.1)))

#q4 match both data files into one file
merged<-merge(summary, source, by = "SCC")
table(merged$EI.Sector)
#Fule comb
coal<-subset(merged, merged$EI.Sector == "Fuel Comb - Comm/Institutional - Coal")
coal<-coal[,1:6]
coal
boxplot(coal$Emissions~coal$year)
boxplot(coal$Emissions~coal$year, ylim = c(0,2))

#q5
balt<-merge(balt, source, by = "SCC")
balt
summary(balt$SCC.Level.Two)
# 5 sources are vehicles
balt$SCC.Level.Two
sum(grepl("vehicles" , balt$SCC.Level.Two, ignore.case = T))
vehicle_balt<-subset(balt, grepl("vehicles" , balt$SCC.Level.Two, ignore.case = T))
vehicle_balt
boxplot(vehicle_balt$Emissions~vehicle_balt$year)
plot(vehicle_balt$year, vehicle_balt$Emissions, col = 2)
abline(lm(vehicle_balt$Emissions~vehicle_balt$year), col = 2)

#q6
vehicle_la<-subset(summary, summary$fips == "06037")
vehicle_la<-merge(vehicle_la, source, by = "SCC")
vehicle_la$SCC.Level.Two
sum(grepl("vehicles" , vehicle_la$SCC.Level.Two, ignore.case = T))
vehicle_la<-subset(vehicle_la, grepl("vehicles" , vehicle_la$SCC.Level.Two, ignore.case = T))
vehicle_la$location<-"LA"
vehicle_balt$location<-"Baltimore"
#balt_la<-rbind(vehicle_balt, vehicle_la)
par(mfrow=c(1,2))
plot(vehicle_balt$year, vehicle_balt$Emissions, col = 2)
abline(lm(vehicle_balt$Emissions~vehicle_balt$year), col = 2)
plot(vehicle_la$year, vehicle_la$Emissions, col = 3)
abline(lm(vehicle_la$Emissions~vehicle_la$year), col = 3)
