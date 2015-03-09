# Simple plots with roman numerals

library(ggplot2)
library(gridExtra)

romanLength <- nchar(as.character(as.roman(1:3899)))

# par(mfrow=c(2,1))
# plot(romanLength, log="", type="l")
# plot(romanLength, log="x", type="l")

df <- data.frame(romanLength)

g0 <- ggplot(df, aes(x=1:3899, romanLength)) +
    geom_point(col="darkblue", alpha=.75)

g1 <- g0 +
    xlab("linear scale") +
    ylab("")

g2 <- g0 +
    xlab("logarithmic scale") +
    ylab("") +
    scale_x_log10()

grid.arrange(g1, g2, nrow=2, main="Roman Numerals Length")

png("img/linear.png", 1440, 900)
g1 + ggtitle("Roman Numerals Length")
dev.off()

png("img/log.png", 1440, 900)
g2 + ggtitle("Roman Numerals Length - Log Scale")
dev.off()


## Smooth
png("img/linear_smooth.png", 1440, 900)
g1 + ggtitle("Roman Numerals Length") + geom_smooth()
dev.off()

png("img/log_smooth.png", 1440, 900)
g2 + ggtitle("Roman Numerals Length - Log Scale") + geom_smooth()
dev.off()