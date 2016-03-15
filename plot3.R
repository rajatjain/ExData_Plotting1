# PREREQUISITES: household_power_consumption.txt should be placed in the working directory
# from where this script is run.

library(dplyr)
full_household <- read.table("household_power_consumption.txt", sep = ";",
                             header=TRUE, stringsAsFactors = FALSE)
feb_household <- full_household[grepl("^(1/2/2007|2/2/2007)", full_household$Date),]
feb_household$DateTime <- as.POSIXct(paste(feb_household$Date, feb_household$Time, sep = " "),
                                     format = "%d/%m/%Y %H:%M:%S")
feb_household$Sub_metering_1 <- as.numeric(feb_household$Sub_metering_1)
feb_household$Sub_metering_2 <- as.numeric(feb_household$Sub_metering_2)
feb_household$Sub_metering_3 <- as.numeric(feb_household$Sub_metering_3)

png(file = "plot3.png", width = 480, height = 480, units = "px")

plot(feb_household$DateTime, feb_household$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(feb_household$DateTime, feb_household$Sub_metering_2, col = "red")
lines(feb_household$DateTime, feb_household$Sub_metering_3, col = "blue")

legend("topright", col = c("black", "blue", "red"),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1)
dev.off()
