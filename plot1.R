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
filteredData <- filter(allData, Date %in% ymd(c("2007-02-01", "2007-02-02")))

# Generating #1 plot .. hist(global active power)
png("plot1.png", width = 480 , height = 480, units = "px", bg = "white")
hist(filteredData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.off()
