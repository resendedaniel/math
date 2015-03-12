library(reshape2)
library(ggplot2)

cat("\014")  

### Data
r <- 1
by <- .01
x <- seq(-r, r, by=by)
y0 <- sqrt((r-x)*(r+x))
t1 <- (r-x)
t2 <- (r+x)
y1 <- t1 * t2
diff <- y0 - y1


df <- data.frame(x, t1, t2, y0, y1, diff)
# par(mfrow=c(1,1))
# plot(df)
print(df)
df <- melt(df, id="x")

g <- ggplot(df, aes(x, value, color=variable)) + geom_line()
#     scale_x_continuous(limits = c(-r, r)) +
#     scale_y_continuous(limits = c(-r, r))
plot(g)

# plot(x, y0 - y1)