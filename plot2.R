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
png(file ="plot2.png")

#set margins
par(mar = c(3, 4, 1, 1))
#plot Global Active Power
with(data2,plot(datetime,Global_active_power,type="l",xlab=NULL,ylab="Global Active Power (kilowatts)"))

#close PNG device
dev.off()