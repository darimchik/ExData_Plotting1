png(file="plot1.png") # creating png file

# Reading in the data
data <- read.table("household_power_consumption.txt", sep=";", skip=grep("1/2/2007", readLines("household_power_consumption.txt")), nrows=2879, stringsAsFactors = FALSE) # read in data
        addrow <- c("1/2/2007", "00:00:00", 0.326, 0.128, 243.150, 1.400, 0.000, 0.000, 0.000) # add one missed row 
                data2 <- rbind(addrow, data)   # update data by adding first row
                colnames(data2) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#PLOT 1
data2$Global_active_power <- as.numeric(data2$Global_active_power) # converting to numeric 
hist(data2$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power(kilowatts)") # first plot

dev.off() # closing