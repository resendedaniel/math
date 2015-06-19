tau <- 2 * pi

m <- 1
angle <- 1/6
f <- 250
g <- 9.8

# F = m*a
distance <- sapply(0:100, function(t) {
    h_speed <- f / m * cos(angle * tau)
    v_speed <- f / m * sin(angle * tau) - (g * t) / m
    
    result <- if(min(h_speed, v_speed) < 0) {
        c(NA, NA)
    } else {
        c(t * h_speed, t * v_speed)
    }
})

distance <- distance[,apply(!is.na(distance), 2, any)]

lim <- range(distance, na.rm=TRUE)
plot(distance[1, ], distance[2,], xlim=lim, ylim=lim, type="n")
abline(0, tan(angle * tau), lty="dashed")
x <- apply(distance, 2, function(point) {
    points(point[1], point[2], pch=20)
    Sys.sleep(1/2)
})