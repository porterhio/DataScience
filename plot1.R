#Read subset of data into R
#Lines for 2007-02-01 and 2007-02-02 found externally

data<-read.table("household_power_consumption.txt",sep=";",skip=66637,nrows=2880)                             #read subset of data from file
header<-read.table("household_power_consumption.txt",nrows=1,header=FALSE,sep =';',stringsAsFactors=FALSE)    #read column names from file
colnames(data)<-header                                                                                        #apply column names to data set

#call PNG device to save image
png(file ="plot1.png")

#plot histogram
hist(data$Global_active_power,col="red",main='Global Active Power',xlab='Global Active Power (kilowatts)',ylim=c(0,1200))

#close PNG device
dev.off()