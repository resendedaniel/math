setwd("~/workspace/math/24-khan")
library(jsonlite)
library(lubridate)
library(reshape2)
library(ggplot2)
library(dplyr)
library(gridExtra)

file <- "response.json"
rawdata <- fromJSON(file)

exercises <- rawdata$students$activity$dictExerciseBuckets
videos <- rawdata$students$activity$dictVideoBuckets

data <- mapply(function(d, n) {
    d <- d[sapply(d, is.data.frame)]
    dates <- names(d)
    dates <- mdy(dates)
    d <- sapply(d, function(e) {
        e$minutes
    })
    d <- data.frame(dates, d, row.names=NULL)
    names(d)[2] <- n
    
    list(d)
}, d=list(exercises, videos), n=c("exercises", "videos"))

data <- do.call("merge", c(data, all=T))
data[is.na(data)] <- 0

data <- mutate(data, total_exercises = cumsum(exercises)) %>%
    mutate(total_videos = cumsum(videos))

data <- melt(data, id="dates")

g1 <- ggplot(filter(data, variable %in% c("total_exercises", "total_videos")), aes(dates, value, fill=variable)) + 
    geom_area(alpha=.5) +
    xlab("") +
    ylab("minutos") +
    theme(legend.position="none")

g2 <- ggplot(filter(data, variable %in% c("exercises", "videos")), aes(dates, value, color=variable)) + 
    geom_point() +
    geom_smooth(method="lm", se=FALSE) +
    xlab("") + 
    ylab("minutos por dia") +
    theme(legend.position="none")    

g3 <- ggplot(filter(data, variable %in% c("exercises", "videos")), aes(value, fill=variable)) +
    geom_histogram(bin=30) +
    facet_wrap(~variable) +
    xlab("minutos no dia") + 
    ylab("dias") +
    theme(legend.position="bottom", legend.title=element_blank())

grid.arrange(g1, g2, g3, nrow=3, main="Khan Academy effort/pleasure")

filter(data, variable %in% c("exercises", "videos")) %>%
    group_by(variable) %>%
    summarise(sum(value))
filter(data, variable %in% c("exercises", "videos")) %>%
    group_by(variable) %>%
    summarise(mean(value))

