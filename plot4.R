# PREREQUISITES: household_power_consumption.txt should be placed in the working directory
# from where this script is run.

library(data.table)
full_household <- read.table("household_power_consumption.txt", sep = ";",
                             header=TRUE, stringsAsFactors = FALSE)
feb_household <- full_household[grepl("^(1/2/2007|2/2/2007)", full_household$Date),]
feb_household$DateTime <- as.POSIXct(paste(feb_household$Date, feb_household$Time, sep = " "),
                                     format = "%d/%m/%Y %H:%M:%S")
feb_household$Sub_metering_1 <- as.numeric(feb_household$Sub_metering_1)
feb_household$Sub_metering_2 <- as.numeric(feb_household$Sub_metering_2)
feb_household$Sub_metering_3 <- as.numeric(feb_household$Sub_metering_3)

png(file = "plot4.png", width = 480, height = 480, units = "px")

par(mfrow=c(2, 2))

plot(feb_household$DateTime, feb_household$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(feb_household$DateTime, feb_household$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(feb_household$DateTime, feb_household$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")

lines(feb_household$DateTime, feb_household$Sub_metering_2, col = "red")
lines(feb_household$DateTime, feb_household$Sub_metering_3, col = "blue")

legend("topright", col = c("black", "blue", "red"),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1, box.lwd=0)

plot(feb_household$DateTime, feb_household$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
