tmp_bak <- data
loadData <- function () {
    url <- "http://hookrace.net/thebutton.txt"
    data <- readLines(url)
    data <- tmp_bak
    data
}

## Getting and cleaning data
data <- loadData()
data <- data[1:10]
data <- strsplit(data, "\t")

data <- data.frame(matrix(unlist(data), length(data), byrow=T))
names(data) <- c("d", "time")
data <- sapply(data, as.character)
data$d <- strptime()
data 



data