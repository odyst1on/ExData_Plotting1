## R script to create plot of sub-metering data, and export it to a png file

## Read in source file.
## Nulls in the source are represented by "?".
epc <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

## Subset data to 1st and 2nd Feb 2007
data <- subset(epc, ((epc$Date %in% c("1/2/2007", "2/2/2007"))))

## Create a new column of concatenated Date and Time, with appropriate format
data$dandt <- with(data, as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

## Create a blank plot
with(data, plot(dandt, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))

## Add the three line plots
with(data, lines(dandt, Sub_metering_1, type="l", col="black"))
with(data, lines(dandt, Sub_metering_2, type="l", col="red"))
with(data, lines(dandt, Sub_metering_3, type="l", col="blue"))

## Add a legend
legend("topright", lty=c(1,1), col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.5)

## Copy the plot to a png file
dev.copy(png, file="plot3.png", width=480, height=480)

## Close the png file
dev.off()