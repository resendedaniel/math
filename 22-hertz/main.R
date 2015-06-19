library(ggplot2)
library(beepr)
library(gridExtra)
library(dplyr)

estimate_time <- function(hertz, n) {
    1/hertz*n
}

n <- 8
skip <- 8
hertz <- seq(skip, 440*2^2, skip)
print(sum(estimate_time(hertz, n)))

delay <- sapply(hertz, function(h) {
    t0 <- proc.time()
    sapply(1:n, function(i) {
        beep()
        Sys.sleep(1/h)
    })
    t1 <- proc.time()
    10/(t1[3] - t0[3])
})

df <- data.frame(hertz, delay)
df <- mutate(df, log_hertz=log(hertz)) %>%
    mutate(ratio=delay/hertz)
print(tail(df))
cat("total time: ", sum(df$delay), "\n")

g1 <- ggplot(df, aes(log_hertz, delay)) + geom_point() + stat_smooth(method="lm")
g2 <- ggplot(df, aes(hertz, delay)) + geom_point() + stat_smooth(method="lm")
g3 <- ggplot(df, aes(hertz, ratio)) + geom_point() + stat_smooth(method="lm")
g4 <- ggplot(df, aes(log_hertz, ratio)) + geom_point() + stat_smooth(method="lm")
grid.arrange(g1, g2, g4, g3, nrow=2)

# fit <- lm(delay ~ log_hertz, df)
# plot(fit)

