read_img <- function(file) {
    # Read
    img <- readJPEG(file)
    dim <- dim(img)
    img <- list(red=img[,,1],
                green=img[,,2],
                blue=img[,,3])
}

save_img <- function(img, destfile) {
    # Save
    
    if(!file.exists(paste(path, "treated", sep="/"))) { dir.create(paste(path, "treated", sep="/")) }
    
    out <- array(c(img[[1]], img[[2]], img[[3]]), c(dim(img[[1]]), 3))
    writeJPEG(out, destfile)
}

apply_filter <- function(filter, img) {
    # Apply filter on each image    
    do.call(filter, list(img))
}

plot_channels <- function(img) {
    g <- sapply(1:2, function(i) {
        channels <- lapply(img, function(x) {
            apply(x, i, mean)
        })
        channels <- as.data.frame(channels)
        channels <- cbind(col=1:nrow(channels), channels)
        channels <- melt(channels, id="col")
        g <- ggplot(channels, aes(col, value, colour=variable)) + 
            geom_line() +
            ggtitle(ifelse(i==1, "Each row", "Each col"))
        list(g)
    })
    
    grid.arrange(g[[1]], g[[2]], nrow=2)
}