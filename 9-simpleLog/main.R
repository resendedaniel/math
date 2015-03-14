animateLog <- function(n) {
    sapply(n, function(n) {
        print(n)
        plot(log(1:n), pch=20)
        plot(log(1:n), pch=20, log="x")
        Sys.sleep(1/4)
    })
}
par(mfrow=c(2,1))
n <- 2^(0:10)
animateLog(n)