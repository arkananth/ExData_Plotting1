### This code is for Plot 2 of project 1 for the Coursera course "Exploratory Data Analysis"


# Set working directory and library. Alter dir structure if required 

setwd("C:/Users/admin/Desktop/Exploratory Data Analysis/exdata-data-household_power_consumption")


library(data.table)

# Read the zip file already downloaded in the dir 

data <- fread("household_power_consumption.txt")

# Clean data 

#class(data$Date)
#class(data$Time)
# Data and time variables are characters

# Change the format of Date variable
data$Date <- as.Date(data$Date, format="%d/%m/%Y")


# Subset the data for the two dates of interest
data_subset <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02"]

# Convert data subset to a data frame
# class(data_subset)
data_subset <- data.frame(data_subset)

# Convert columns to numeric
for(i in c(3:9)) {data_subset[,i] <- as.numeric(as.character(data_subset[,i]))}

# Create Date_Time variable
data_subset$Date_Time <- paste(data_subset$Date, data_subset$Time)

# Convert Date_Time variable to proper format
data_subset$Date_Time <- strptime(data_subset$Date_Time, format="%Y-%m-%d %H:%M:%S")
# class(data_subset$Date_Time)

# Draw Plot 2 #

png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")

par(mar = c(6, 6, 5, 4))

plot(data_subset$Date_Time, data_subset$Global_active_power, xaxt=NULL, xlab = "", ylab = "Global Active Power (kilowatts)", type="n")
# type = "n" builds plots without points
# xaxt = NULL suppresses x axis
# xlab = "" removes the label from the x axis
# otherwise, the axis is the name of the x variable, which is date_time

lines(data_subset$Date_Time, data_subset$Global_active_power, type="S")

dev.off()