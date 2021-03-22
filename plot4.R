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

#Create date and time variable that can be converted to POSIXlt class
power.consumption.subset$Date_Time <- paste(power.consumption.subset$Date, power.consumption.subset$Time)

#Set the "Date_Time" variable to POSIXlt class
power.consumption.subset$Date_Time <- strptime(power.consumption.subset$Date_Time, format="%Y-%m-%d %H:%M:%S")

#Make the global active power variable a numeric variable
power.consumption.subset$Global_active_power <- as.numeric(power.consumption.subset$Global_active_power)

#Change the voltage variable to numeric class
power.consumption.subset$Voltage <- as.numeric(power.consumption.subset$Voltage)

#Change the global reactive power variable to numeric class
power.consumption.subset$Global_reactive_power <- as.numeric(power.consumption.subset$Global_reactive_power)

#Change the sub metering variables to numeric class
power.consumption.subset$Sub_metering_1 <- as.numeric(power.consumption.subset$Sub_metering_1)
power.consumption.subset$Sub_metering_2 <- as.numeric(power.consumption.subset$Sub_metering_2)
power.consumption.subset$Sub_metering_3 <- as.numeric(power.consumption.subset$Sub_metering_3)

#Turn the sub metering columns into long format
subset.metering1 <- power.consumption.subset$Sub_metering_1
subset.metering1 <- cbind(subset.metering1, 1)
colnames(subset.metering1)=c("sub.metering", "meter.number")
subset.metering1 <- cbind(power.consumption.subset, subset.metering1)

subset.metering2 <- power.consumption.subset$Sub_metering_2
subset.metering2 <- cbind(subset.metering2, 2)
colnames(subset.metering2)=c("sub.metering", "meter.number")
subset.metering2 <- cbind(power.consumption.subset, subset.metering2)

subset.metering3 <- power.consumption.subset$Sub_metering_3
subset.metering3 <- cbind(subset.metering3, 3)
colnames(subset.metering3)=c("sub.metering", "meter.number")
subset.metering3 <- cbind(power.consumption.subset, subset.metering3)

subset.metering.1_2 <- rbind(subset.metering1, subset.metering2)
subset.metering.1_2_3 <- rbind(subset.metering.1_2, subset.metering3)

#Create date and time variable that can be converted to POSIXlt class
subset.metering.1_2_3$Date_Time <- paste(subset.metering.1_2_3$Date, subset.metering.1_2_3$Time)

#Set the "Date_Time" variable to POSIXlt class
subset.metering.1_2_3$Date_Time <- strptime(subset.metering.1_2_3$Date_Time, format="%Y-%m-%d %H:%M:%S")


#Launch graphics device in mac
quartz()

#Make a series of graphs in one image
par(mfcol=c(2,2))

#Making a line graph of the global active power over the dates
plot(x=power.consumption.subset$Date_T, y=power.consumption.subset$Global_active_power, xlab="Global Active Power (kilowatts)", type="l", ylab="Global Active Power (kilowatts)")

#Making a graph of the sub metering over time in which each sub metering variable is shown as a different line color
plot(x=subset.metering.1_2_3$Date_Time, y=subset.metering.1_2_3$sub.metering, type="n" , xlab="Time", ylab="Energy sub metering" )
lines(subset.metering.1_2_3$Date_Time[subset.metering.1_2_3$meter.number=="1"], subset.metering.1_2_3$sub.metering[subset.metering.1_2_3$meter.number=="1"])
lines(subset.metering.1_2_3$Date_Time[subset.metering.1_2_3$meter.number=="2"], subset.metering.1_2_3$sub.metering[subset.metering.1_2_3$meter.number=="2"], col="red")
lines(subset.metering.1_2_3$Date_Time[subset.metering.1_2_3$meter.number=="3"], subset.metering.1_2_3$sub.metering[subset.metering.1_2_3$meter.number=="3"], col="blue")
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)

#Make graph of date/time versus voltage
plot(x=power.consumption.subset$Date_Time, y=power.consumption.subset$Voltage, type="l", xlab="datetime", ylab="Voltage")

#Make graph of date/time versus global reactive power
plot(x=power.consumption.subset$Date_Time, y=power.consumption.subset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

#Save the plot to a png file with a width of 480 pixels and height of 480 pixels
png(file="plot4.png", width=480, height=480, unit="px")
dev.off()
