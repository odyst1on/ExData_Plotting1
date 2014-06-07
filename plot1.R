## Script to create histogram of Global Active Power, and export it to a png file
## Read in source file.
## Nulls in the source are represented by "?".
epc <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

## Subset data to 1st and 2nd Feb 2007
data <- subset(epc, ((epc$Date %in% c("1/2/2007", "2/2/2007"))))

## Create histogram of Global Active Power
hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

## Copy the histogram to a png file
dev.copy(png, file="plot1.png", width=480, height=480)

## Close the png file
dev.off()