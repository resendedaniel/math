setwd("~/workspace/math/14-thebutton")
library(dplyr)
library(reshape2)
library(ggplot2)
library(gridExtra)
library(beepr)
library(scales)
library(lubridate)

t <- proc.time()

cleanData <- function(data) {
    data <- strsplit(data, "\t")
    data <- lapply(data, function(x) {
        if(length(x) == 2) {
            c(x[1], NA, x[2])
        } else if(length(x) == 3) {
            x
        } else if(length(x) == 4) {
            c(x[1], x[2], x[4])
        }
    })
    
    
    data <- unlist(data)
    data <- matrix(data, ncol=3, byrow=TRUE)
    data <- data.frame(data, stringsAsFactors=F)
    names(data) <- c("d", "clicks", "time")
    
    data$d <- strptime(data$d, "%Y-%m-%d-%H-%M-%S")
    data$date <- as.factor(format(data$d, "%Y-%m-%d"))
    data$hour <- as.factor(as.numeric(format(data$d, "%H")))
    data$clicks <- sub(",", "", data$clicks)
    data$clicks <- as.numeric(data$clicks)
    data$time <- as.numeric(data$time)
    data$flair <- sapply(data$time, flair)
    data$flair <- factor(data$flair, levels=c("purple", "blue", "green", "yellow", "orange", "red"))
    data$d <- as.POSIXct(data$d)
    
    data
}

dataURL <- "http://hookrace.net/thebutton.txt"
loadData <- function () {
    file <- "data/thebutton.txt"
    download.file(dataURL, file)
    data <- readLines(file)
    data <- cleanData(data)

    data
}

flair <- function(n) {
    x <- if (n >= 51) {
        "purple"
    } else if (n >= 41) {
        "blue"
    } else if (n >= 31) {
        "green"
    } else if (n >= 21) {
        "yellow"
    } else if (n > 11) {
        "orange"
    } else {
        "red"
    }
    
    x
}

originalData <- data <- loadData()

g3 <- ggplot(data, aes(date, time)) +
    geom_jitter(size=1.5, aes(color=flair, alpha=.01)) +
    geom_violin(adjust=3) +
    scale_y_reverse() + 
    scale_color_manual(values=c("#A13F9F", "#0083C7", "#02BE01", "#E5D900", "#E59500", "#E50000")) +
    theme_bw() +
    theme(legend.position = "none") +
    xlab(paste("updated:",
               as.POSIXct(as.numeric(Sys.time()),
                          origin='1970-01-01',
                          tz="UTC"),
               "UTC",
               "\n",
               "data source:",
               dataURL)) +
    ylab("seconds left")
ggsave("img/plot3.png", width=16, height=10, dpi=150)

# data <- melt(data, id=c("d", "flair", "hour", "date"))
table <- table(data$time)

g1 <- ggplot(data, aes(d, time)) +
    geom_point(size=1.5, aes(color=flair)) +
#     geom_smooth() +
    theme_bw() +
    theme(legend.position = "none") +
    scale_y_reverse() +
    scale_color_manual(values=c("#A13F9F", "#0083C7", "#02BE01", "#E5D900", "#E59500", "#E50000")) +
    xlab(paste("updated:",
               as.POSIXct(as.numeric(Sys.time()),
                          origin='1970-01-01',
                          tz="UTC"),
               "UTC",
               "\n",
               "data source:",
               dataURL)) +
    ylab("click")
ggsave("img/plot1.png", width=16, height=10, dpi=150)

g2 <- g1 + 
    facet_wrap(~date, scales="free_x", ncol=7) +
    scale_x_datetime(labels = date_format("%H:%M"),breaks = "6 hour")
ggsave("img/plot2.png", width=16, height=10, dpi=150)

print(proc.time() - t)
beep(4)