df <- data.frame(sd50=rnorm(30, mean=100, sd=50),
                 sd10=rnorm(30, mean=100, sd=10))
df <- melt(df)

ggplot(df, aes(x=value, color=variable)) +
    geom_density(aes(fill=variable), alpha=.5) + theme_bw() +
    geom_vline(xintercept=100, linetype = "longdash")
