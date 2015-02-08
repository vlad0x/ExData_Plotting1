data <- read.table("C:/vlad/household_power_consumption.txt", header=T, sep=";", 
                   col.names=c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                               "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
                               "Sub_metering_3"))

data$DateTime <- paste(as.character(data$Date), as.character(data$Time), sep=" ")
data$DateTime <- strptime(data$DateTime, format="%d/%m/%Y %H:%M:%S")

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

start_date <- as.Date("2007-02-01")
stop_date <- as.Date("2007-02-02")
data <- data[data$Date >= start_date & data$Date <= stop_date,]

data$Sub_metering_1 <- as.character(data$Sub_metering_1)
data <- data[data$Sub_metering_1 != "?",]
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)

data$Sub_metering_2 <- as.character(data$Sub_metering_2)
data <- data[data$Sub_metering_2 != "?",]
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)

data$Sub_metering_3 <- as.character(data$Sub_metering_3)
data <- data[data$Sub_metering_3 != "?",]
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

with(data, plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering"))
with(data, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(data, lines(DateTime, Sub_metering_3, type="l", col="blue"))

legend("topright", pch="-", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, filename="plot3.png", width=480, height=480)
dev.off()