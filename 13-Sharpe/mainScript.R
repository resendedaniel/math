plot(log(1:100),
     type="l",
     main="Sharpe",
     xlab="Risco",
     ylab="Rentabilidade",
     frame=F)


h <- c(5,10,
       45,50)
sapply(h, function(x) {
    y <- log(x)
    segments(x, 0, y1=y, lty="dashed")
    segments(0, y, x1=x, lty="dashed")
    log(h)
})
