# Convert to gif
## ffmpeg -f image2 -i caos-%d.png ../video/video.avi
## ffmpeg -i video.avi -pix_fmt rgb24 out.gif
setwd("~/workspace/math/12-caos")
caosAlg <- function(x) {
    r * x * (1 - x)
}

caos <- function(r) {
        r <<- r
        x <- numeric(100)
        x[1] <- 0.1
        
        for(i in 2:length(x)) {
                x[i] <- caosAlg(x[i-1])
        }
        
        x
}



n <- 100
r <- seq(from=2.5, to=4, length.out=n)
mapply(function(r, i) {
        func <- paste0("f(x) = ", round(r, digits=2), " * x * (1 - x)")
#         png(file=paste("img/caos-", i, ".png", sep=""), width=1200, height=627)#, bg = "transparent")
        plot(caos(r), pch=20, axes=FALSE, ylab="", xlab="", #col=rgb(z,z,z),
             main=paste("Chaos: ", func, sep=""))
        Sys.sleep(1/16)
#         dev.off()
}, r=r, i=1:n)