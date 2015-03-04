sinminus <- function(x) {
    -sin(x)
}

curve(cos, -tau, tau, frame=F, col="darkred")
curve(sin, -tau, tau, add=TRUE, col="darkblue")

h <- c(-1, 1, 0)
v <- -1 * c(1/8, 1/4, 1/2, 1, 0)
v <- c(v, c(1/8, 1/4, 1/2, 1, 0))
v <- tau * v
abline(h=h, v=v, col="gray75")

sincos <- function(x) {
    cat("Flat", "\n")
    cat(sin(x), cos(x), "\n")
    cat("Squared", "\n")
    cat(sin(x) ^ 2, cos(x) ^ 2)
    cat(" = ", sin(x) ^ 2 + cos(x) ^ 2, "\n")
    abline(v=x)
}
sincos(2*tau*(runif(1)-.5))