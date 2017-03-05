temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header=T,sep=";",na.strings = "?",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
unlink(temp)

data$datestamp <- as.Date(data$Date,format="%d/%m/%Y",tz="GMT")
data <- data[data$datestamp=="2007-02-01" | data$datestamp=="2007-02-02",]

data$datetime <- as.POSIXct(paste(data$Date,data$Time),"%d/%m/%Y %H:%M:%S",tz="GMT")


png("plot4.png",width=480,height=480)

# add plots column-wise
par(mfcol=c(2,2))

# first plot
plot(Global_active_power ~ datetime, data, type="l",xlab="",xaxt="n",ylab="Global Active Power (kilowatts)")
axis.POSIXct(1,at=seq(as.POSIXlt("2007-02-01",tz="GMT"),as.POSIXlt("2007-02-03",tz="GMT"),by="day"),
             format="%a")

# second plot
plot(Sub_metering_1 ~ datetime,data,type="l",col="black",ylab="Energy sub metering",xaxt="n",xlab="")
lines(Sub_metering_2 ~ datetime,data,col="red")
lines(Sub_metering_3 ~ datetime,data,col="blue")
axis.POSIXct(1,at=seq(as.POSIXlt("2007-02-01",tz="GMT"),as.POSIXlt("2007-02-03",tz="GMT"),by="day"),
             format="%a")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),col=c("black","red","blue"),bty="n")


#third plot
plot(Voltage ~ datetime, data, type="l",xaxt="n")
axis.POSIXct(1,at=seq(as.POSIXlt("2007-02-01",tz="GMT"),as.POSIXlt("2007-02-03",tz="GMT"),by="day"),
             format="%a")

#fourth plot
plot(Global_reactive_power ~ datetime, data, type="l",xaxt="n")
axis.POSIXct(1,at=seq(as.POSIXlt("2007-02-01",tz="GMT"),as.POSIXlt("2007-02-03",tz="GMT"),by="day"),
             format="%a")


dev.off()