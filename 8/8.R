library(reshape2)
library(ggplot2)

cat("\014")  

genseq <- function(by=.1, r=1) {
    seq(-r, r, by=by)
}

f <- function(x, r=1) {
    sqrt((r-x)*(r+x))
}

area <- function(x, r=1) {
    f(x) * r
}

### Data
r <- 1
by <- .01
x <- genseq(by, r)
y0 <- f(x, r)
t1 <- (r-x)
t2 <- (r+x)
y1 <- t1 * t2
diff <- y0 - y1

df <- data.frame(x, t1, t2, y0, y1, diff)
# par(mfrow=c(1,1))
# plot(df)
print(df)
df <- melt(df, id="x")

g1 <- ggplot(df, aes(x, value, color=variable)) + geom_line()
#     scale_x_continuous(limits = c(-r, r)) +
#     scale_y_continuous(limits = c(-r, r))
plot(g1)

diff1 <- y0 - y1
diff2 <- y0 / y1
diff3 <- y1 - y0
diff4 <- y1 / y0
diff <- data.frame(x, diff1, diff2, diff3, diff4)
diff <- melt(diff, id="x")

g2 <- ggplot(diff, aes(x, value, color=variable)) + geom_line()
#     scale_x_continuous(limits = c(-r, r)) +
#     scale_y_continuous(limits = c(-r, r))
plot(g2)