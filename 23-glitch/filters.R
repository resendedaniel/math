invert_color <- function(img, color="red") {
    img[[color]] <- apply(img[[color]], 2, rev)
    img
}

random_sidewalk <- function(img) {
    img <- lapply(img, function(x) {
        n <- sample(100, 1)
        x <- cbind(x, x[,1:n])
        x <- x[,(n+1):(ncol(x))]
        x
    })
}

extrude <- function(img, direction="horizontal") {
    block <- .20
    position <- rnorm(1)/10 + .75
    
    img <- lapply(img, function(x) {
        col <- floor(dim(x)[1] * position)
        n <- floor(dim(x)[1] * block)
        
        x <- cbind(x[,1:col], matrix(rep(x[,col], n), ncol=n), x[,col:dim(x)[1]])
        x
    })
}

single_col <- function(img, direction="horizontal") {
    position <- runif(1)
    img <- lapply(img, function(x) {
        col <- floor(dim(x)[1] * position)
        n <- dim(x)[1]
        cat(col, n, "\n")
        
        matrix(rep(x[,col], n), ncol=n)
    })
}