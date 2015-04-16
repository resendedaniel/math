transitionPlot <- function(seq) {
    count <- 101
    for(n in seq) {
        x <- 1:201 / n
        y <- sin(x)
        
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
