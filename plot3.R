# Data Science Specialization - Exploratory Data Analysis
#
# Week 1: Course Project 1
#
# Plot 3: Energy sub metering trendlines

# If data is not in working directory (/data) it will be downloaded

inFile <-  "./data/household_power_consumption.txt"
zipFile <- "./data/HouseholdPowerConsumption.zip"

if (!file.exists(inFile)) {
    
    if (!file.exists(zipFile)) {
        download.file ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                       zipFile)
    }
    unzip (zipFile)
}

# Read the first 5 lines to enable R to determine the classes of variables. This parameter will speed up the 
# read.table funtion
top5Data <- read.table(inFile, header = TRUE, sep = ";", nrows = 5,stringsAsFactors=FALSE)
classes <- sapply(top5Data, class)

# Now read in the data with an approximate over-estimation of number of rows (to ensure all rows are read)
# specifying the comment.char parameter also speeds up the read process
allData <- read.table(inFile, header = TRUE, sep = ";", nrows = 2075300, colClasses = classes, 
                      comment.char = "", na.strings = "?")

# The lubridate package provides great functions to work with date/time data. Use this to subset the 
# data for use in plots
require(lubridate)
plotData <- allData[dmy(allData$Date)==ymd("2007-02-01") | dmy(allData$Date)==ymd("2007-02-02"),]

# Use lubridate parsing function to create new DataTime column to be used in plots
plotData$DateTime <- dmy_hms(paste(plotData$Date,plotData$Time))

# Send the plot to the png device - first ensuring the layout is for a single plot
png("plot3.png", height = 480, width=480)
par(mfcol=c(1,1))

with(plotData, {
    plot(DateTime,Sub_metering_1,type="l",ylab = "Energy sub metering",xlab = "")
    lines(DateTime,Sub_metering_2,col="red")
    lines(DateTime,Sub_metering_3,col="blue")
    legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty = 1)
})

dev.off()

