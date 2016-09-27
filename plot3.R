##################################################################
## Exploratory Data Analysis Course  from Coursera
## Week 1 Peer-reviewsd Assignment 1 PLOT 3 (out of 4)
## Author: Amitava G.
## R version: Rx64 3.3.1, Run on Windows 10
##################################################################

### Step 1. Install/load necessary packages, set working directory and 
### download the raw data from external source ###

install.package("downloader")
library(downloader)
library(data.table)
library(dplyr)

### Set File path for the working directory ##
setwd("C:/Users/amitava/Desktop/Coursera/01. Data Scientist/04. Exploratory Data Analysis/Week -1/Assignment"
      
      ### Upon download, unzip and unlink the temp file to save disk space
      sourceFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      targetFile <- "C:/Users/amitava/Desktop/Coursera/01. Data Scientist/04. Exploratory Data Analysis/Week -1/Assignment/hpc.txt"
      temp <- tempfile()
      download.file(sourceFile,temp)
      unz(temp, "targetFile")
      unlink(temp)
      
## Step 2. Read in the data and subset to only as much as relevant for analyses
downloadedData <- read.table("hpc.txt", 
                  sep=";",
                  na.string = "?",
                  stringsAsFactors=FALSE, 
                  dec=".",
                  header = TRUE,
                  fill=FALSE) # dim(downloadedData) : [1] 2075259 9
      
subsetData <- downloadedData %>%
filter(Date %in% c("1/2/2007","2/2/2007")) # dim(subsetData) : [1] 2880 9
      
## Step 3. Convert date and time to datetime and plot the data 
## to replicate the one given in the assignment
install.packages("lubridate")
library(lubridate)
# day <- wday(as.Date(subsetData$Date,'%d/%m/%Y'), label=TRUE, abbr = TRUE)
dateTime <- strptime(paste(subsetData$Date, subsetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

yrange<-range(c(subsetData$Sub_metering_1, subsetData$Sub_metering_2, subsetData$Sub_metering_3))
plot(dateTime, subsetData$Sub_metering_1,type="l", ylim=yrange, xlab = "", ylab="Energy sub metering")
lines(dateTime, subsetData$Sub_metering_2,type="l",col= "red")
lines(dateTime, subsetData$Sub_metering_3,type="l",col= "blue")
legend('topright', names(subsetData)[7:9], lty=1, col=c('black', 'red', 'blue'), bty='y', cex=.75)

dev.copy(png, file = "plot3.png")
dev.cur()
dev.off()
      
      