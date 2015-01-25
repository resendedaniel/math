# ---
# title: "1"
# objective: "Slopes"
# author: "Daniel Resende"
# date: "January 24, 2015"
# output: html_document
# ---
setwd("~/workspace/math/2")

source('~/workspace/verios/verios-r/api/Asset.R')
source('./api.R')

# Always loads
source('~/workspace/math/constants.R')

cat("\014")
# Chart
pallete <- c('1B305D', '32557B', 'A59750', '6B7D31', '3B461B')
pallete <- paste('#', pallete, sep='')
gray <- '#000000'

xDomain <- seq(-tau, tau, by=.01)
# yDomain <- range(y)
xRange <- range(xDomain)
# yRange <- yDomain

par(mfrow=c(1,1))
curve(f, xlim=xRange, n=201, main="Derivatives")
abline(h = 0, v = 0, col = "gray30")

sapply(xDomain, function(x, n=.1) {
    slope <- (f(x + n) - f(x - n)) / (2*n)
    intercept <- f(x) - slope*x
    abline(a=intercept, b=slope, col=gray)
})
