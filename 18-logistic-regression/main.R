logisticFunction <- function(x) {
    1 / (1 + exp(-x))
}

x <- seq(-6, 6, by=.1)
y <- logisticFunction(x)

# png("img/img1.png")
plot(x, f(x), pch=20, main="Logistic Regression", frame=F)
# dev.off()