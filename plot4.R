# Ensure script is place in the same directory as where the source data file 
# "household_power_consumption.txt" is placed. 
# Set current active working directory to the same as well. 
#  e.g.: setwd("<directory>")

#plot 1

# setup date search pattern 
pattern<- "^1/2/2007|^2/2/2007"

# obtain starting rownum of required rows; data is already sorted by date and time in source data file
required_rows<-grep(pattern , readLines("household_power_consumption.txt"))

# read data into data frame based on required rows' starting rownum and number of rows returned on top
dt<-read.table("household_power_consumption.txt",sep=";",header=FALSE,na.strings="?", 
	nrow=length(required_rows), skip=(required_rows[1]-1)) 

# dummy read 1 line to obtain header names
tmp<-read.table("household_power_consumption.txt",sep=";",header=TRUE, nrow=1) 
names(dt)<-names(tmp)

# additional date time field manipulation for subsequent plotting usage; code to put in standardized R template.
dt$DateTime<-as.POSIXlt(paste(dt$Date, dt$Time),"%d/%m/%Y %H:%M:%S", tz="GMT")

# plot and output to PNG file
png("plot4.png",width = 480, height = 480)
par("mfrow"=c(2,2))
plot(dt$DateTime,dt$Global_active_power,type="l", xlab="", ylab="Global Active Power")

plot(dt$DateTime,dt$Voltage,type="l", xlab="datetime", ylab="Voltage")

plot(dt$DateTime,dt$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
	lines(dt$DateTime,dt$Sub_metering_1, col="black")
	lines(dt$DateTime,dt$Sub_metering_2, col="red")
	lines(dt$DateTime,dt$Sub_metering_3, col="blue")
	legend("topright",bty="n", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
		col=c("black","red","blue"), lwd=1, lty=c(1,1,1))

plot(dt$DateTime,dt$Global_reactive_power,type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
