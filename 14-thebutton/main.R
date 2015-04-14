loadData <- function () {
    t <- proc.time()
    url <- "http://hookrace.net/thebutton.txt"
#     data <- ifelse(exists("tmp_bak"), tmp_bak, readLines(url))
    data <- readLines(url)
    tmp_bak <<- data
    print(proc.time() -t)

    data
}

## Getting and cleaning data
data <- loadData()
data <- strsplit(data, "\t")

data <- matrix(unlist(data), length(data), byrow=T)
data <- data.frame(data, stringsAsFactors=F)
names(data) <- c("d", "time")
data$d <- strptime(data$d, "%Y-%m-%d-%H-%M-%S")
data$time <- as.numeric(data$time)

# data <- tmp_bak