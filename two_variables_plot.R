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
#     16*x + 10*10
    8.35 * x^2 + 1.7 * y^2
}

m <- rep(NA, 121)
dim(m) <- rep(sqrt(length(m)), 2)

for(i in 1:dim(m)[1]) {
    print((i-6)/5)
    for(j in 1:dim(m)[2]) {
        m[i,j] <- z((j-6)/5, (i-6)/5)
    }
}

# cloud(m)
wireframe(m)