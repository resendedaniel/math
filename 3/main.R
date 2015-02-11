x <- sample(1:10, 5, replace=T)
y <- sample(1:10, 5, replace=T)

var1 <- sum((x - mean(x)) * (y - mean(y))) / length(x)
var2 <- mean(x * y) - mean(x)*mean(y)
slope <- (mean(x*y)-mean(x)*mean(y))/(mean(x^2)-mean(x)^2)


plot(x, y, xlim=c(0, 10), ylim=c(0, 10), main=paste("Variance =", var1))
abline(h=mean(y), lty = 3)
abline(v=mean(x), lty = 3)

for(i in seq_along(x)) {
    segments(x[i], y[i], x[i], mean(y), lty = 2)
    segments(x[i], y[i], mean(x), y[i], lty = 2)
    #     segments(x[i], y[i], mean(x), mean(y))
}
abline(a=mean(y)-slope*mean(x), b=slope)

cat(var1, var2, "\n")