    # load file if it doesn't exists in local directory
    if(!file.exists("household_power_consumption.txt")){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        destination <- "file.zip"
        download.file(url, destination)    
        data <- read.table(unz(destination, "household_power_consumption.txt"),sep=";",header=TRUE,na.strings="?")
    } else data <- read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?")


    #Date format
    data$Date <- as.Date(data$Date, format="%d/%m/%Y")

    #subset data
    data_s <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

    #free-up memory
    rm(data)

    #Date conversion
    date_time <- paste(as.Date(data_s$Date), data_s$Time)
    data_s$Datetime <- as.POSIXct(date_time)

    #generate plot4
    par(mfrow = c(2, 2), mar=c(4,4,2,2))  
    with(data_s, {
        plot(Global_active_power~Datetime, type = "l",ylab = "Global Active Power", xlab = "")
        plot(Voltage~Datetime, type = "l", ylab = "Voltage")
        plot(Sub_metering_1~Datetime, type = "l", ylab = "Energy sub metering", xlab = "")
        lines(Sub_metering_2~Datetime, col = 'Red')
        lines(Sub_metering_3~Datetime, col = 'Blue')
        legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty = 1, lwd = 2, bty = "n",pch=1, cex=0.5)
        plot(Global_reactive_power~Datetime, type = "l", ylab = "Global_reactive_power")
    })

    #copy to png format
    dev.copy(png,file="plot4.png",height=480,width=480)
    dev.off()
