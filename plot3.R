library(dplyr)
library(lubridate)

# << Check if there is a file for data, if not, create it >>
if(!file.exists("data")){dir.create("./data")}

# Specify data source, download and unzip it
filetodownload <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(filetodownload, destfile = "./data/entireDataSet.zip",method = "curl")
unzip("./data/entireDataSet.zip", exdir = "./data")

# read data and specify column classes
allData <- read.table("./data/household_power_consumption.txt", stringsAsFactors=FALSE , na.strings = "?", header=TRUE, sep=";" )

# filter data with dates 2007-02-01 and 2007-02-02
filteredData <- filter(allData, Date %in%  c("1/2/2007","2/2/2007"))

# format x-axis to get days of our data
dataDays <- strptime(paste(filteredData$Date, " " ,filteredData$Time), "%d/%m/%Y %H:%M:%S", tz ="GMT")

# Generating #3 plot ..
png("plot3.png", width = 480 , height = 480, units = "px", bg = "white")
plot(dataDays, filteredData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(dataDays, filteredData$Sub_metering_2, type = "l", col="red")
lines(dataDays, filteredData$Sub_metering_3, type = "l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
dev.off()