# ---
# title: "1"
# objective: "Translate points"
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
n <- 100
x <- localRandom(n)
y <- localRandom(n)
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
pallete <- c('1B305D', '32557B', 'A59750', '6B7D31', '3B461B')
pallete <- paste('#', pallete, sep='')

xDomain <- range(x)
yDomain <- range(y)
xRange <- c(-1, 1) * (median[1] + 3 * sd[1])
yRange <- c(-1, 1) * (median[2] + 3 * sd[2])

par(mfrow=c(1,1))
plot(x, y, xlim=xRange, ylim=yRange, pch=20, main='Translation', col=pallete[1])
points(-x, -y, xlim=xRange, ylim=yRange, pch=20, col = pallete[3])
abline(h = 0, v = 0, col = "gray30")

sapply(1:length(x), function(i) {
    gray <- '#dddddd'
    slope <- (y[i] - -y[i]) / (x[i] - -x[i])
#     abline(a=c(0,slope), col=gray)
#     abline(a=c(0,-slope), col=gray)
    segments(x[i], y[i], -x[i], -y[i], col=gray)
    NULL
})