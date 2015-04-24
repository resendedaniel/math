library(httr)
library(XML)
library(dplyr)
library(lubridate)

t <- proc.time()

delay <- 0
traffic_url <- "http://www.reddit.com/r/thebutton/about/traffic"
r <- GET(traffic_url)
html <- htmlTreeParse(content(r, "text"), asText=TRUE)
html <- htmlTreeParse(traffic_url, useInternal = TRUE)
tables <- readHTMLTable(html)

## Click data
clicks <- loadData()
clicksByDate <- split(clicks, clicks$date)
date <- as.Date(names(clicksByDate))
mean <- unlist(lapply(clicksByDate, function(x) {
    mean(x$time)
}))
sd <- unlist(lapply(clicksByDate, function(x) {
    sd(x$time)
}))
numClicks <- unlist(lapply(clicksByDate, function(x) {
    length(x$time)
}))
min <- unlist(lapply(clicksByDate, function(x) {
    min(x$time)
}))
clicksByDate <- data.frame(date, mean, sd, numClicks, min)


## Daily  Visitors Table
### Getting and Cleanning
dailyDF <- tables[["traffic-day"]]
dailyDF$date <- as.Date(dailyDF$date, "%m/%d/%y")
dailyDF[2:4] <- sapply(dailyDF[2:4], function(x) {
    x <- as.character(x)
    x <- gsub(",", "", x)
    x <- as.numeric(x)
    x
})
dailyDF <- filter(dailyDF, date >= "2015-04-01")
dailyDF <- filter(dailyDF, subscriptions > 0)
dailyDF <- mutate(dailyDF, subscriptionsRate = subscriptions / uniques)

### Merging
data <- merge(clicksByDate, dailyDF)

### Normalizing
zdailyDF <- dailyDF
n <- nrow(zdailyDF)
zdailyDF$date <- (n-1):0
zdailyDF[2:4] <- sapply(zdailyDF[2:4], function(x) {
    (x - mean(x)) #/ sd(x)
})

### Plot
ggplot(melt(zdailyDF, id="date"), aes(date, value, color=variable)) +
    geom_line() +
    geom_smooth(method="lm", linetype="dashed") +
    facet_grid(variable~., scales="free") +
    theme_bw() +
    theme(legend.position="bottom")

## Regression
fit <- lm(subscriptions ~ date, dailyDF)
zfit <- lm(subscriptions ~ date, zdailyDF)
print(summary(fit))
print(summary(zfit))

par(mfrow=c(3,1))
plot(dailyDF$date, dailyDF$subscriptions, pch=20, main="scatter log", log="y")
abline(fit)
plot(dailyDF$date, dailyDF$subscriptions, pch=20, main="scatter no log")
abline(fit)
plot(dailyDF$date, fit$residuals, pch=20, main="residuals")
abline(h=0)

print(proc.time() - t)