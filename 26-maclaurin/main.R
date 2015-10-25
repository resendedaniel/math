for(j in (0:20) * 2) {
    print(j)
    
    f <- function(x) {
        out <- 0
        for(i in seq(0, j, 2)) {
            out <- out + x^i/factorial(i) * (-1)^(i/2)
        }
        
        out
    }
    
    tau <- 2*pi
    x <- seq(-2*tau, 2*tau, by=tau/2^5)
    y <- f(x)
    g <- ggplot(data.frame(x, y), aes(x, y)) + geom_line() + ylim(-2, 2) +
        geom_line(data=data.frame(x, y=cos(x)), aes(x, y), linetype="dashed") +
        scale_x_continuous(breaks=(-4:4) * pi, labels=paste0(-4:4, "\u03C0")) +
        ylab("cos") +
        xlab(paste("Aproximation ", j, "degree")) +
        ggtitle("Cosine Taylor series at 0 (Maclaurin)")
    print(g)
    png(paste0("img/", paste(c(rep("0", 4-nchar(as.character(j))), j), collapse=""), ".png"),
        720, 400)
    dev.off()
    format(j, "")
    Sys.sleep(.5)
}
