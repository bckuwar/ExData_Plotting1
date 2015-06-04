    # load file if it doesn't exists in the local directory
    if(!file.exists("household_power_consumption.txt")){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        destination <- "file.zip"
        download.file(url, destination)
        unz(destination, "household_power_consumption.txt")
    } 
    
    #read only subset of data
    library(sqldf)
    data_s <- read.csv.sql("household_power_consumption.txt","select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep=";",header=TRUE)      
    closeAllConnections()
    
    #generate plot 1
    png(filename = "plot1.png", width = 480,height = 480)
    par(mfrow = c(1, 1),  mar=c(5,5,3,3)) 
    hist(data_s$Global_active_power,main="Global Active Power",col="red", xlab="Global Active Power(kilowatts)", ylab="Frequency")
    dev.off()
