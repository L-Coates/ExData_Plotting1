#This script describes the steps taken to generate plot 1

#load needed libraries
library(lubridate)

#The zip file was downloaded from the coursera site and automatically unzipped
#Now reading in the data  
power.consumption<-read.table("household_power_consumption.txt", header=TRUE, sep=";")

#Change the Date variable from a character class to a date class
power.consumption$Date<-dmy(power.consumption$Date)

#Subset the data to just the dates 2007-02-01 and 2007-02-02
power.consumption.subset <- power.consumption[(power.consumption$Date=="2007-02-01" | power.consumption$Date=="2007-02-02"),]

#Make the global active power variable a numeric variable
power.consumption.subset$Global_active_power <- as.numeric(power.consumption.subset$Global_active_power)

#Launch graphis device
quartz()

#Making a histogram of the global active power
hist(power.consumption.subset$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Activie Power")

#Save the plot to a png file with a width of 480 pixels and height of 480 pixels
png(file="plot1.png", width=480, height=480, unit="px")
dev.off()
