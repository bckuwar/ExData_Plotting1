    # load file if it doesn't exists in the local directory
    if(!file.exists("household_power_consumption.txt")){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        destination <- "file.zip"
        download.file(url, destination)    
        data <- read.table(unz(destination, "household_power_consumption.txt"),sep=";",header=TRUE,na.strings="?")
    } else data <- read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?")
    
    #Date Conversion
    data$Date <- as.Date(data$Date, format="%d/%m/%Y")
    
    #subset data
    data_s <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
    
    #free-up memory
    rm(data)
    
    #reset to single plot
    par(mfrow = c(1, 1)) 
    
    #generate plot 1
    hist(data_s$Global_active_power,main="Global Active Power",col="red", xlab="Global Active Power(kilowatts)", ylab="Frequency")
    
    #copy to png format
    dev.copy(png,file="plot1.png",height=480,width=480)
    dev.off()
