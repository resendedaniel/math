library(reshape2)

#The far side of a normal
n <- 1:32
n <- 2^(0:8)
sapply(n, function(n) {
    seq <- seq(-n,n,by=.1)
    normal <- dnorm(seq)
    
    plot(seq, normal,
         type="l",
         frame=FALSE,
         main="The far side of a Normal",
         xlab="Standard Deviation",
         ylab="Density")
    Sys.sleep(1/8)
})

# The log of a normal
n <- 5
seq <- seq(-n,n,by=.01)
normal <- dnorm(seq)
lognormal <- log(normal)
df <- data.frame(seq, normal, lognormal)

ggplot(df, aes(seq, lognormal)) +
    geom_line() +
    ggtitle("The log of a Normal") +
    theme(plot.title = element_text(lineheight=3, face="bold", size=20))
    xlab("Standard Deviation") +
    ylab("Density")