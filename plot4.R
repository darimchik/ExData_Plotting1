png(file="plot4.png") # creating png file

# Reading in the data
data <- read.table("household_power_consumption.txt", sep=";", skip=grep("1/2/2007", readLines("household_power_consumption.txt")), nrows=2879, stringsAsFactors = FALSE) # read in data
addrow <- c("1/2/2007", "00:00:00", 0.326, 0.128, 243.150, 1.400, 0.000, 0.000, 0.000) # add one missed row 
data2 <- rbind(addrow, data)   # update data by adding first row
colnames(data2) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Converting vectors to appropriate class
library(chron)
data2$Time <- chron(times=data2$Time) # converting to times class
data2$Date <- as.Date(data2$Date, format="%d/%m/%Y") #  converting to date class

data2$Global_active_power <- as.numeric(data2$Global_active_power) # converting to numeric 
data2$Global_reactive_power <- as.numeric(data2$Global_reactive_power)
data2$Voltage <- as.numeric(data2$Voltage)
data2$Global_intensity <- as.numeric(data2$Global_intensity)
data2$Sub_metering_1 <- as.numeric(data2$Sub_metering_1)
data2$Sub_metering_2 <- as.numeric(data2$Sub_metering_2)
data2$Sub_metering_3 <- as.numeric(data2$Sub_metering_3)

# Creating datetime variable and attaching to dataframe
library(lubridate)
datetime <- with(data2, ymd(data2$Date) + hms(data2$Time)) 
data3 <- cbind(datetime, data2)

#PLOT 4
par(mfrow = c(2, 2), mar = c(4, 4, 2, 2), oma = c(1, 1, 1, 1))
#1
plot(data3$Global_active_power~data3$datetime, type="n", ylab="Global Active Power (kilowatts)", xlab="")
lines(data3$Global_active_power~data3$datetime)

#2
plot(data3$Voltage~data3$datetime, type="n", ylab="Voltage", xlab="datatime")
lines(data3$Voltage~data3$datetime)


#3
plot(data3$datetime, data3$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(data3$datetime, data3$Sub_metering_1)
lines(data3$datetime, data3$Sub_metering_2, col="red")
lines(data3$datetime, data3$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

#4
plot(data3$Global_reactive_power~data3$datetime, type="n", ylab="Global_reactive_power", xlab="datatime")
lines(data3$Global_reactive_power~data3$datetime)

dev.off() # closing