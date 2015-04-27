library(beepr)
source('~/workspace/math/constants.R')
cleanSeq <- function(time, ceil=.2, floor=.1) {
#     seq <- seq[seq<20 & seq >0]
    seq <- seq - min(seq)
    seq <- seq + floor
    seq <- seq/max(seq) * ceil
    print(seq)
    seq
}

n <- 2^7
seq <- (seq(0, 4*tau, length.out=n))
# seq <- log(abs(sin(seq)/cos(seq)^2))
seq <- sin(seq) + 2*sin(seq/2) + sin(seq/3) + 8*sin(seq/8)
seq <- cleanSeq(seq)


plot(seq,
     type="n",
#      frame=F,
     axes=FALSE,
     xaxt='n',
     ann=FALSE)
for(i in seq_along(seq)) {
    points(i, seq[i], pch=20, col="#6F8242")
    beep()
    Sys.sleep(seq[i])
}