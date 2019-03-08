png(file="plot3.png") # creating png file

# Reading in the data
data <- read.table("household_power_consumption.txt", sep=";", skip=grep("1/2/2007", readLines("household_power_consumption.txt")), nrows=2879, stringsAsFactors = FALSE) # read in data
addrow <- c("1/2/2007", "00:00:00", 0.326, 0.128, 243.150, 1.400, 0.000, 0.000, 0.000) # add one missed row 
data2 <- rbind(addrow, data)   # update data by adding first row
colnames(data2) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")


library(chron)
data2$Time <- chron(times=data2$Time) # converting to times class
data2$Date <- as.Date(data2$Date, format="%d/%m/%Y") #  converting to date class
# Creating datetime variable and attaching to dataframe
library(lubridate)
datetime <- with(data2, ymd(data2$Date) + hms(data2$Time))

data2$Sub_metering_1 <- as.numeric(data2$Sub_metering_1)
data2$Sub_metering_2 <- as.numeric(data2$Sub_metering_2)
data2$Sub_metering_3 <- as.numeric(data2$Sub_metering_3)

data3 <- cbind(datetime, data2)

#PLOT 3
plot(data3$datetime, data3$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(data3$datetime, data3$Sub_metering_1)
lines(data3$datetime, data3$Sub_metering_2, col="red")
lines(data3$datetime, data3$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

dev.off() # closing