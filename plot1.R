data <- read.table("C:/vlad/household_power_consumption.txt", header=T, sep=";", 
                   col.names=c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                               "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
                               "Sub_metering_3"))

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

start_date <- as.Date("2007-02-01")
stop_date <- as.Date("2007-02-02")
data <- data[data$Date >= start_date & data$Date <= stop_date,]

data <- data[data$Global_active_power != "?",]
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

with(data, hist(Global_active_power, col="red", main="Global Active Power", 
                xlab="Global Active Power (kilowatts)"))

dev.copy(png, filename="plot1.png", width=480, height=480)
dev.off()