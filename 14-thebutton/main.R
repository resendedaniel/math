setwd("~/workspace/math/14-thebutton")
library(dplyr)
library(reshape2)
library(ggplot2)
library(gridExtra)

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
    data$clicks <- sub(",", "", data$clicks)
    data$clicks <- as.numeric(data$clicks)
    data$time <- as.numeric(data$time)
    
    data
}

dataURL <- "http://hookrace.net/thebutton.txt"
loadData <- function () {
    t <- proc.time()
    file <- "data/thebutton.txt"
    download.file(dataURL, file)
    data <- readLines(file)
    tmp_bak <<- data
    print(proc.time() -t)

    t <- proc.time()
    data <- cleanData(data)
    print(proc.time() -t)

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
data$flair <- sapply(data$time, flair)
data$flair <- factor(data$flair, levels=c("purple", "blue", "green", "yellow", "orange", "red"))
sample <- data
# sample <- sample_n(data, 2000)
sample$d <- as.POSIXct(sample$d)
sample <- melt(sample, id=c("d", "flair"))
table <- table(data$time)

g1 <- ggplot(filter(sample, variable == "time"), aes(d, value)) +
    geom_point(aes(color=flair)) +
    geom_smooth(aes(size=1)) +
    theme_bw() +
    theme(legend.position = "none") +
    scale_y_reverse() +
    scale_color_manual(values=c("#820080", "#0083C7", "#02BE01", "#E5D900")) +
    xlab(paste("updated:",
               as.POSIXct(as.numeric(Sys.time()),
                          origin='1970-01-01',
                          tz="UTC"),
               "\n",
               "data source:",
               dataURL)) +
    ylab("click")

ggsave("img/plot1.png")
print(proc.time() - t)
# g1
g2 <- ggplot(filter(sample, variable == "time"), aes(value)) +
    geom_density() +
    theme_bw()
ggsave("img/plot2.png")
# grid.arrange(g1, g2, nrow=2)

print(proc.time() - t)