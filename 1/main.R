# ---
# title: "1"
# objective: "Plot regression"
# author: "Daniel Resende"
# date: "January 24, 2015"
# output: html_document
# ---
setwd("~/workspace/math/1")

source('~/workspace/verios/verios-r/api/Asset.R')
source('~/workspace/math/1/api.R')

# Always loads
source('~/workspace/math/constants.R')

cat("\014")

## Getting / Generating data
n <- 2
x <- localRandom(n)
y <- x * runif(length(x))
m <- matrix(c(x, y), ncol=2)

# Summary data
sd <- apply(m, 2, sd)
var <- apply(m, 2, function(x) { sd(x)^2 })
cov <- cov(x, y)
cor <- cor(x, y)
median <- apply(m, 2, median)
length <- apply(m, 2, length)


print('Summary Data')
print(apply(m, 2, summary))
cat('sd', sd, '\n')
cat('var', var, '\n')
cat('cov', cov(x, y), '\n')
cat('cor', cor, '\n')
cat('length', length, '\n')

# Chart
xDomain <- range(x)
yDomain <- range(y)
xRange <- c(-50,50) #c(median[1] -3 * sd[1], median[1] + 3 * sd[1])
yRange <- c(-2,2) #c(median[2] -3 * sd[2], median[2] + 3 * sd[2])

par(mfrow=c(2,1))
plot(x, y, xlim=xRange, pch=20, main='Original data')
plot(x, y, xlim=xRange, pch=20, main='Translated', col = '#999999')
abline(h=0)
abline(v=0)