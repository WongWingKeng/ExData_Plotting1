# Ensure script is place in the same directory as where the source data file 
# "household_power_consumption.txt" is placed. 
# Set current active working directory to the same as well. 
#  e.g.: setwd("<directory>")

#plot 2

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
png("plot2.png",width = 480, height = 480)
plot(dt$DateTime,dt$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
