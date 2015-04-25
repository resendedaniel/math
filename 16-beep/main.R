library(beepr)
tau <- 2 * pi
sapply(1:4, function(x) {
    beep()
    Sys.sleep(1/12)
})
Sys.sleep(4/12)
sapply(1:8, function(x) {
    beep()
    Sys.sleep(1/24)
})
Sys.sleep(4/12)
sapply(1:4, function(x) {
    beep()
    Sys.sleep(1/12)
})
Sys.sleep(4/12)
sapply(1:8, function(x) {
    beep()
    Sys.sleep(1/24)
})
Sys.sleep(4/12)
sapply(1:4, function(x) {
    beep()
    Sys.sleep(1/12)
})
Sys.sleep(4/12)
sapply(1:8, function(x) {
    beep()
    Sys.sleep(1/24)
})
Sys.sleep(4/12)
seq <- (sin(seq(-2*tau, 2*tau, length.out=64)) + 1)/4
# plot(seq, pch=20)
sapply(seq/2, function(n) {
    beep()
    Sys.sleep(n)
})