library(ggplot2)

m0 <- 30
m1 <- 31

sigma0 <- 12
sigma1 <- 4

n0 <- 10
n1 <- 4

x0 <- rnorm(n0, mean=m0, sd=sigma0)
x1 <- rnorm(n1, mean=m1, sd=sigma1)

m0 <- mean(x0)
m1 <- mean(x1)

sigma0 <- sd(x0) / sqrt(n0)
sigma1 <- sd(x1) / sqrt(n1)

x <- range(c(m0 + c(-1, 1) * 4 * sigma0, m1 + c(-1, 1) * 4 * sigma1))

t <- t.test(x0, x1)

g <- ggplot(data.frame(x=seq(x[1], x[2], length.out=11)), aes(x)) +
    geom_histogram(data=data.frame(x0), aes(x0, y=..density..), fill="darkred", alpha=.5) +
    geom_histogram(data=data.frame(x1), aes(x1, y=..density..), fill="darkblue", alpha=.5) +
    stat_function(fun=dnorm, geom="line", 
                  args=list(mean=m0, sd=sigma0), col="darkred") +
    stat_function(fun=dnorm, geom="line",
                  args=list(mean=m1, sd=sigma1), col="darkblue") +
    geom_vline(aes(xintercept=qnorm(.975, m0, sigma0)), col="darkred") +
    ggtitle(round(1-t$p.value,2))
g

print(x0)
print(x1)