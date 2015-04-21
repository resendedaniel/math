library(httr)

traffic_url <- "http://www.reddit.com/r/thebutton/about/traffic"
r <- GET(trafficURL)

content(r, as="raw")
cat(paste("I have printed the response of", traffic_url, ", as raw", "\n"))
Sys.sleep(5)
content(r, as="text")
cat("Now as text, it's more redable for humans", "\n")
Sys.sleep(5)
content(r, as="parsed")
cat("Parsed is in a format more prone to r read the data. I don't know exactly the difference, but I'll try to get it.")