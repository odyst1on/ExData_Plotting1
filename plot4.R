## R script to create set of plots of energy consumption, 
## and export them to png file

## Read in source file.
## Nulls in the source are represented by "?".
epc <- read.table("household_power_consumption.txt", sep=";", 
        header=TRUE, na.strings="?")

## Subset data to 1st and 2nd Feb 2007
data <- subset(epc, ((epc$Date %in% c("1/2/2007", "2/2/2007"))))

## Create a new column of concatenated Date and Time, with appropriate format
data$dandt <- with(data, as.POSIXct(paste(Date, Time), 
        format = "%d/%m/%Y %H:%M:%S"))

## Set the graphics device output to be a 2x2 frame.
## Also, reduce default font size.
par(mfcol=c(2,2), cex=0.5)

## Create the Global Active Power plot
with(data, plot(dandt, Global_active_power, type="n", xlab="", 
                ylab="Global Active Power"))
with(data, lines(dandt, Global_active_power, type="l"))

## Create the sub-metering plots
with(data, plot(dandt, Sub_metering_1, type="n", xlab="", 
                ylab="Energy sub metering"))
with(data, lines(dandt, Sub_metering_1, type="l", col="black"));
with(data, lines(dandt, Sub_metering_2, type="l", col="red"));
with(data, lines(dandt, Sub_metering_3, type="l", col="blue"));
legend(x=mean(data$dandt), y=39, bty="n", lty=c(1,1), col=c("black","red","blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Create the voltage plot
with(data, plot(dandt, Voltage, type="n", xlab="datetime"))
with(data, lines(dandt, Voltage, type="l"))

## Create the Global Reactive Power plot
with(data, plot(dandt, Global_reactive_power, type="n", xlab="datetime"))
with(data, lines(dandt, Global_reactive_power, type="l"))

## Copy the plot to a png file
dev.copy(png, file="plot4.png", width=480, height=480)

## Close the png file
dev.off()
