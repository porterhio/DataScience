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
png(file ="plot3.png")

#set margins
par(mar = c(3, 4, 1, 1))
#plot energy sub metering
with(data2,plot(datetime,Sub_metering_1,type="l",xlab=NULL,ylab="Energy sub metering"))
#add sub metering 2
with(data2,lines(datetime,Sub_metering_2,col="red"))
#add sub metering 3
with(data2,lines(datetime,Sub_metering_3,col="blue"))
#add label
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#close PNG device
dev.off()