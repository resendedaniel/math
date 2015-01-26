# data = data.frame(
#     x = rep( (1:25)/10, each=5),
#     y = rep( c(1, 2, 3, 4, 5), 5)
# )
# 
# data$z = runif(
#     25,
#     min = (data$x*data$y - 0.1 * (data$x*data$y)),
#     max = (data$x*data$y + 0.1 * (data$x*data$y))
# )
# 
# cloud(z ~ x * y, data=data)
# wireframe(z ~ x * y, data=data)

z <- function(x, y) {
#     2*x^2 + 2*x*y + 2*y^2 -6*x
#     x^2 - y^2
#     -x^2 - y^2
#     16*x + 10*10
    
    r <- if(x + y == 1) {
        cat(x, y, 'valid', '\n')
        8.35 * x^2 + 1.7 * y^2
    }
    else {
        NA
    }
    
    r
    
#     8.35 * x^2 + 1.7 * y^2
}

dimension <- seq(0,1,by=.01)
m <- matrix(rep(NA, length(dimension)^2), nrow=length(dimension))

for(i in 1:length(dimension)) {
    for(j in 1:length(dimension)) {
        m[i,j] <- z(dimension[j], dimension[i])
    }
}

cloud(m)
# wireframe(m)