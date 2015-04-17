transitionPlot <- function(seq) {
    count <- 101
    for(n in seq) {
        x <- 1:201 / n
        y <- sin(x/n)
#         y <- sin(log(log(x)/n))^2/sqrt(cos(x/3))
#         y <- (sin(x)^2)/sqrt(cos(log(x)/4))
#         y <- sin(2*x)/sqrt(sin(sin(x))^2)
#         y <- log(sin(2*x * (1/x))/sqrt(sin(sin(x))^2))
#         y <- log(sin(2*x * (1/n))/sqrt(sin(sin(x))^2))
        
        data <- data.frame(x, y)
#         png()
        plot(data,
             pch=20,
             axes=FALSE,
             frame.plot=FALSE,
             xlab="Take me out of here\nthis numbers are crazy",
             ylab="")
#         dev.off()
        Sys.sleep(1/12)
    }
}

tau <- 2 * pi
seq <- seq(-tau, tau, length.out=501)
seq <- seq ^ 2
seq <- seq[seq != 0]
print(seq)
transitionPlot(seq)
