# Data Science Specialization - Exploratory Data Analysis
#
# Week 1: Course Project 1
#
# Plot 1: Frequency of Global Active Power

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

# Send the plot to the png device - first ensuring the layout is for a single plot
png("plot1.png", height = 480, width=480)
par(mfcol=c(1,1))

hist(plotData$Global_active_power,col = "red",main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()




