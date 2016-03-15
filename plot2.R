# PREREQUISITES: household_power_consumption.txt should be placed in the working directory
# from where this script is run.

library(data.table)
full_household <- read.table("household_power_consumption.txt", sep = ";",
                                    header=TRUE, stringsAsFactors = FALSE)
feb_household <- full_household[grepl("^(1/2/2007|2/2/2007)", full_household$Date),]
feb_household$DateTime <- as.POSIXct(paste(feb_household$Date, feb_household$Time, sep = " "),
                                     format = "%d/%m/%Y %H:%M:%S")
feb_household$Global_active_power <- as.numeric(feb_household$Global_active_power)
png(file = "plot2.png", width = 480, height = 480, units = "px")
plot(feb_household$DateTime, feb_household$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
