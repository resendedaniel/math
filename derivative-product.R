f <- function(x) {
#     (1 - x ^2) ^3
    f2(f1(x))
}
f_ <- function(x) {
#     -6 * x * (1 - x^2) ^2
    f2_(f1(x)) * f1_(x) 
}

f1 <- function(x) {
    1 - x ^2
}
f1_ <- function(x) {
    -2 * x
}

f2 <- function(x) {
    x ^3
}
f2_ <- function(x) {
    3 * x^2
}

# plotChart(f)
xDomain <- c(-1.5, 1.5)
curve(f_, xlim=xDomain, n=1001, col="blue")
curve(f, xlim=xDomain, n = 1001, add = TRUE)
# curve(f1, xlim=xDomain, n = 1001, col = "blue", add = TRUE)
# curve(f2, xlim=xDomain, n = 1001, col = "red", add = TRUE)

# Local y limits
abline(h=0, col=rgb(0,0,0,.5))
