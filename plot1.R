# PREREQUISITES: household_power_consumption.txt should be placed in the working directory
# from where this script is run.

library(data.table)
full_household <- read.table("household_power_consumption.txt", sep = ";",
                             header=TRUE, stringsAsFactors = FALSE)
feb_household <- full_household[grepl("^(1/2/2007|2/2/2007)", full_household$Date),]
feb_household$Global_active_power <- as.numeric(feb_household$Global_active_power)

png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(feb_household$Global_active_power, breaks = 12, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()
