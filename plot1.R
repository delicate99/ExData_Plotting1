#Download and reading 

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="./power.zip", method="curl")
unzip ("./power.zip")

household_power <- read.table("./household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE)
power_data  <- household_power[household_power$Date %in% c("1/2/2007","2/2/2007"),]


# change format and class.

power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")
power_data$Time <- format (power_data$Time, format="%H:%M:%S")

power_data[,c(3:9)] <- sapply(power_data[,c(3:9)], as.numeric)



png("plot1.png", width=480, height=480)
hist(power_data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power(kilowatts)",
     ylab="Frequency")         
     
dev.off()     
     
     
