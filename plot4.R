    # load file if it doesn't exists in local directory
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
    
    #DateTime Conversion
    date_time <- paste(as.Date(data_s$Date,format="%d/%m/%Y"), data_s$Time)
    data_s$Datetime <- as.POSIXct(date_time)
    
    #generate plot 4
    png(filename = "plot4.png", width = 480,height = 480)
    par(mfrow = c(2, 2), mar=c(4,4,2,2))  
    with(data_s, {
        plot(Global_active_power~Datetime, type = "l",ylab = "Global Active Power", xlab = "")
        plot(Voltage~Datetime, type = "l", ylab = "Voltage")
        plot(Sub_metering_1~Datetime, type = "l", ylab = "Energy sub metering", xlab = "")
        lines(Sub_metering_2~Datetime, col = 'Red')
        lines(Sub_metering_3~Datetime, col = 'Blue')
        legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty = 1, lwd = 2, bty = "n",pch=1, cex=0.90)
        plot(Global_reactive_power~Datetime, type = "l", ylab = "Global_reactive_power")
        })
    dev.off()
