# set working directory (change this to fit your needs)
setwd('~/rsvij/dataScience')

# required packages
library(data.table)
library(lubridate)

# make sure the sources data folder exists
if (!file.exists('course4')) {
  dir.create('course4')
}

# check to see if the existing tidy data set exists; if not, make it...
if (!file.exists('course4/power_consumption.txt')) {
  
  # download the zip file and unzip
  file.url<-'https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip'
  
  
  
  download.file(file.url,destfile='course4/power_consumption.zip',method="curl")
  unzip('course4/power_consumption.zip',exdir='course4',overwrite=TRUE)

  # read the raw table and limit to 2 days
  variable.class<-c(rep('character',2),rep('numeric',7))
  power.consumption<-read.table('course4/household_power_consumption.txt',header=TRUE,
                                sep=';',na.strings='?',colClasses=variable.class)
  power.consumption<-power.consumption[power.consumption$Date=='1/2/2007' | power.consumption$Date=='2/2/2007',]

  # clean up the variable names and convert date/time fields
  cols<-c('Date','Time','GlobalActivePower','GlobalReactivePower','Voltage','GlobalIntensity',
          'SubMetering1','SubMetering2','SubMetering3')
  colnames(power.consumption)<-cols
  power.consumption$DateTime<-dmy(power.consumption$Date)+hms(power.consumption$Time)
  power.consumption<-power.consumption[,c(10,3:9)]
  
  # write a clean data set to the directory
  write.table(power.consumption,file='course4/power_consumption.txt',sep='|',row.names=FALSE)
} else {
  
  power.consumption<-read.table('course4/power_consumption.txt',header=TRUE,sep='|')
  power.consumption$DateTime<-as.POSIXlt(power.consumption$DateTime)

}

# remove the large raw data set 
if (file.exists('course4/household_power_consumption.txt')) {
  x<-file.remove('course4/household_power_consumption.txt')
}
