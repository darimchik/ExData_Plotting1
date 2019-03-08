png(file="plot2.png") # creating png file

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

data2$Global_active_power <- as.numeric(data2$Global_active_power) # converting to numeric 

data3 <- cbind(datetime, data2)

#PLOT 2
plot(data3$Global_active_power~data3$datetime, type="n", ylab="Global Active Power (kilowatts)", xlab="")
lines(data3$Global_active_power~data3$datetime)

dev.off() # closing