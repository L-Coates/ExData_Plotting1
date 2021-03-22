#This script describes the steps taken to generate plot 2

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

#Create date and time variable that can be converted to POSIXlt class
power.consumption.subset$Date_Time <- paste(power.consumption.subset$Date, power.consumption.subset$Time)

#Set the "Date_Time" variable to POSIXlt class
power.consumption.subset$Date_Time <- strptime(power.consumption.subset$Date_Time, format="%Y-%m-%d %H:%M:%S")

#Launch graphis device
quartz()

#Making a line graph of the global active power over the dates
plot(x=power.consumption.subset$Date_Time, y=power.consumption.subset$Global_active_power, xlab="Global Active Power (kilowatts)", type="l", ylab="Global Active Power (kilowatts)")

#Save the plot to a png file with a width of 480 pixels and height of 480 pixels
png(file="plot2.png", width=480, height=480, unit="px")
dev.off()
