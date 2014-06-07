## Script to create plot of Global Active Power, and export it to a png file
## Read in source file.
## Nulls in the source are represented by "?".
epc <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

## Subset data to 1st and 2nd Feb 2007
data <- subset(epc, ((epc$Date %in% c("1/2/2007", "2/2/2007"))))

## Create a new column of concatenated Date and Time, with appropriate format
data$dandt <- with(data, as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

## Create a blank plot
with(data, plot(dandt, Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)"))

## Add a line plot
with(data, lines(dandt, Global_active_power, type="l"))

## Copy the plot to a png file
dev.copy(png, file="plot2.png", width=480, height=480)

## Close the png file
dev.off()

