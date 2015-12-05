tau <- 2*pi

sindeg <- function(x) {
    sin(x/360*tau)
}

cosdeg <- function(x) {
    cos(x/360*tau)
}

tandeg <- function(x) {
    tan(x/360*tau)
}

asindeg <- function(x) {
    asin(x)/tau*360
}

acosdeg <- function(x) {
    acos(x)/tau*360
}

atandeg <- function(x) {
    atan(x)/tau*360
}

quadratic_formula <- function(a=0, b=0, c=0) {
    (-b + c(-1,1)*sqrt(b^2 - 4*a*c)) / (2*a)
}
