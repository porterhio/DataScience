#Read subset of data into R
#Lines for 2007-02-01 and 2007-02-02 found externally

data<-read.table("household_power_consumption.txt",sep=";",skip=66637,nrows=2880)                             #read subset of data from file
header<-read.table("household_power_consumption.txt",nrows=1,header=FALSE,sep =';',stringsAsFactors=FALSE)    #read column names from file
colnames(data)<-header                                                                                        #apply column names to data set

#create merged date and time variable
datetime<-as.POSIXlt(paste(as.Date(data$Date,format="%d/%m/%Y"),data$Time),format="%Y-%m-%d %H:%M:%S")

#add merged time and date to data set
data2<-cbind(data,datetime)

#call PNG device to save image
png(file ="plot4.png")

#set margins
par(mar=c(4, 4, 1, 1),mfrow=c(2,2))
#plot Global Active Power
with(data2, {
  #First Plot (from plot2.R)
  plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
  #Second Plot (similar to first plot)
  plot(datetime,Voltage,type="l",ylab="Voltage")
  #Third plot (from plot3.R, with legend outline removed)
  plot(datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
  with(data2,lines(datetime,Sub_metering_2,col="red"))
  with(data2,lines(datetime,Sub_metering_3,col="blue"))
  legend("topright",lty=1,bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  #Last plot (like first and second)
  plot(datetime,Global_reactive_power,type="l")
  })

#close PNG device
dev.off()