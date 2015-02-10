x <- sample(1:10, 5, replace=T)
y <- sample(1:10, 5, replace=T)

plot(x, y, xlim=c(0, 10), ylim=c(0, 10))
abline(h=mean(y), lty = 3)
abline(v=mean(x), lty = 3)

for(i in seq_along(x)) {
    segments(x[i], y[i], x[i], mean(y), lty = 2)
    segments(x[i], y[i], mean(x), y[i], lty = 2)
#     segments(x[i], y[i], mean(x), mean(y))
}

sd <- (x - mean(x)) * (x - mean(x))
print(sd)