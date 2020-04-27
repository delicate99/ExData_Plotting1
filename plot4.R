url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="./power.zip", method="curl")
unzip ("./power.zip")

household_power <- read.table("./household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE)
power_data  <- household_power[household_power$Date %in% c("1/2/2007","2/2/2007"),]


# change format and class.

power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")
power_data$Time <- format (power_data$Time, format="%H:%M:%S")

power_data[,c(3:9)] <- sapply(power_data[,c(3:9)], as.numeric)

datetime <- paste(power_data$Date, power_data$Time, sep=" ")
power_data$Datetime <- as.POSIXct(datetime)

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

# [1.1]
plot(power_data$Datetime, power_data$Global_active_power, type="l", xlab="",
     ylab="Global Active Power")

#[1.2]

with(power_data, plot(Datetime, Voltage, type="l", xlab="datetime", ylab="Voltage"))

#[2.1]

with(power_data,  plot(Datetime, Sub_metering_1, type="l", ylab="Energy Submetering", xlab=""))
with(power_data, lines(Datetime, Sub_metering_2, type="l", col="red"))
with(power_data, lines(Datetime, Sub_metering_3, type="l", col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red","blue"))

#[2.2]

with(power_data, plot(Datetime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))

dev.off()
