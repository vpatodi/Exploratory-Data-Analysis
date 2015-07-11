# set working directory (change this to fit your needs)

setwd('~/rsvij/dataScience/Exploratory-Data-Analysis4')
# make sure the plots folder exists
if (!file.exists('plots')) {
  dir.create('plots')
}

# load data
source('rprog/preProcess.R')

# open device
png(filename='plots/plot2.png',width=480,height=480,units='px')

# plot data
plot(power.consumption$DateTime,power.consumption$GlobalActivePower,ylab='Global Active Power (kilowatts)', xlab='', type='l')
# Turn off device
x<-dev.off()
