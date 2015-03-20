caos <- function(r) {
        r <<- r
        x <- numeric(100)
        x[1] <- 0.1
        
        for(i in 2:length(x)) {
                x[i] <- caosAlg(x[i-1])
        }
        
        x
}

caosAlg <- function(x) {
        r * x * (1 - x)
}

count <- 100
sample <- seq(from=2.5, to=4, length.out=201)
sapply(sample, function(x) {
        count <<- count + 1
        z <- round((count-100)/201 * 255)
        print(z)
        png(file=paste("img-caos-", count, ".png", sep=""), width=1200, height=627, bg = "transparent")
        plot(caos(x), pch=20, axes=FALSE, ylab="", xlab="", #col=rgb(z,z,z),
             main=paste("Caos #", round(x, digits=2), sep=""))
        Sys.sleep(1/16)
        dev.off()
})