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
dailyDF <- tables[["traffic-day"]]
dailyDF$date <- as.Date(dailyDF$date, "%m/%d/%y")

dailyDF[2:4] <- sapply(dailyDF[2:4], function(x) {
    x <- as.character(x)
    x <- gsub(",", "", x)
    x <- as.numeric(x)
    x
})
dailyDF <- filter(dailyDF, date >= "2015-04-01")
dailyDF <- filter(dailyDF, date != today())
ggplot(melt(dailyDF, id="date"), aes(date, value, color=variable)) +
    geom_line() +
    geom_smooth(method="lm", linetype="dashed") +
    facet_grid(variable~., scales="free") +
    theme_bw() +
    theme(legend.position="bottom")


## Regression
fit <- lm(subscriptions ~ uniques + pageviews, dailyDF)
summary(fit)

# print(content(r, as="raw"))
# cat(paste("\n", "I have printed the response of", traffic_url, ", as raw", "\n"))
# Sys.sleep(delay)
# 
# print(content(r, as="text"))
# cat("\n", "Now as text, it's more redable for humans", "\n")
# Sys.sleep(delay)
# 
# print(content(r, as="parsed"))
# cat("\n", "Parsed is in a format more prone to r read the data. I don't know exactly the difference, but I'll try to get it.")
# 
# names(r)

print(proc.time() - t)