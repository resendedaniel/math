library(dplyr)
library(reshape2)
library(ggplot2)
library(gridExtra)

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

loadData <- function () {
    t <- proc.time()
    url <- "http://hookrace.net/thebutton.txt"
#     data <- ifelse(exists("tmp_bak"), tmp_bak, readLines(url))
    data <- readLines(url)
    tmp_bak <<- data
    print(proc.time() -t)

    t <- proc.time()
    data <- cleanData(data)
    print(proc.time() -t)

    data
}

# data <- loadData()
sample <- data
# sample <- sample_n(data, 2000)
sample$d <- as.POSIXct(sample$d)
sample <- melt(sample, id="d")

g1 <- ggplot(filter(sample, variable == "time"), aes(d, value, fill=variable)) +
    geom_point() +
    geom_smooth() +
    theme_bw() +
    theme(legend.position = "none")
g2 <- ggplot(filter(sample, variable == "time"), aes(value)) +
    geom_density() +
    theme_bw()
grid.arrange(g1, g2, nrow=2)
ggsave()
