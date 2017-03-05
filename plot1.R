temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header=T,sep=";",na.strings = "?",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
unlink(temp)

data$Date <- as.Date(data$Date,format="%d/%m/%Y",tz="GMT")

newdata <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02",]

png("plot1.png")

hist(newdata$Global_active_power,col="red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.off()