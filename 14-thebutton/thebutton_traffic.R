library(httr)
library(XML)
library(dplyr)
library(lubridate)

t <- proc.time()

delay <- 0
traffic_url <- "http://www.reddit.com/r/thebutton/about/traffic"
# r <- GET(trafficURL)
# html <- htmlTreeParse(content(r, "text"), asText=TRUE)
# html <- htmlTreeParse(trafficURL, useInternal = TRUE)
tables <- readHTMLTable(html)

## Daily  Visitors Table
### Getting and Cleanning
dailyDF$date <- as.Date(dailyDF$date, "%m/%d/%y")
dailyDF[2:4] <- sapply(dailyDF[2:4], function(x) {
    x <- as.character(x)
    x <- gsub(",", "", x)
    x <- as.numeric(x)
    x
})
dailyDF <- filter(dailyDF, date >= "2015-04-01")
dailyDF <- filter(dailyDF, date <= "2015-04-20")

### Normalizing
zdailyDF <- dailyDF
n <- nrow(zdailyDF)
zdailyDF$date <- (n-1):0
zdailyDF[2:4] <- sapply(zdailyDF[2:4], function(x) {
    (x - mean(x)) / sd(x)
})

### Plot
ggplot(melt(zdailyDF, id="date"), aes(date, value, color=variable)) +
    geom_line() +
    geom_smooth(method="lm", linetype="dashed") +
    facet_grid(variable~., scales="free") +
    theme_bw() +
    theme(legend.position="bottom")

## Regression
# I don't know why fit and zfit aren't the same. Need help.
fit <- lm(subscriptions ~ uniques + pageviews, dailyDF -1)
zfit <- lm(subscriptions ~ uniques + pageviews, zdailyDF -1)
print(summary(fit))
print(summary(zfit))

print(proc.time() - t)