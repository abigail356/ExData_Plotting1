temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header=T,sep=";",na.strings = "?",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
unlink(temp)


data$datestamp <- as.Date(data$Date,format="%d/%m/%Y",tz="GMT")
data <- data[data$datestamp=="2007-02-01" | data$datestamp=="2007-02-02",]

data$datetime <- as.POSIXct(paste(data$Date,data$Time),"%d/%m/%Y %H:%M:%S",tz="GMT")


png("plot2.png",width=480,height=480)

plot(Global_active_power ~ datetime, data, type="l",xlab="",xaxt="n",ylab="Global Active Power (kilowatts)")
axis.POSIXct(1,at=seq(as.POSIXlt("2007-02-01",tz="GMT"),as.POSIXlt("2007-02-03",tz="GMT"),by="day"),
             format="%a")



dev.off()