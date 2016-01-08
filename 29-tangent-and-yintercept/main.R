f <- function(x) {
    # exp(x) / (2 + x^3)
    # 1 / x
    # 4 - x^2
    # exp(sqrt(x))
    # x*cbrt(4-x)
    x^3 -7*x^2 +8*x +3
}
f_ <- function(x) {
    # exp(x) / (2 + x^3) + exp(x) * (-1 / (2 + x^3)^2 * 3*x^2)
    # -1 / x^2
    # 1/(2*x) #-2*x
    # exp(sqrt(x))/(2*sqrt(x))
    # cbrt(4-x) - 1 / (3 * cbrt(4-x)^2)*x
    3*t^2 -14*t +8
}

x <- seq(1, 6, .01)
y <- f(x)

df <- data.frame(x, y)

k <- 3
x1 <- seq(0, k+1, .01)

g <- ggplot(df, aes(x, y)) + geom_line()
#     geom_point(data=data.frame(x=k, y=f(k))) +
#     geom_line(data=data.frame(x=x1, y=f(k)+f_(k)*(x1-k)), linetype="dashed") +
#     geom_point(data=data.frame(x=0, y=f(k)+f_(k)*(0-k)))

g
