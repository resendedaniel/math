setwd("~/workspace/math/23-glitch")
source('~/workspace/math/23-glitch/api.R')
source('~/workspace/math/23-glitch/filters.R')
library(beepr)
library(jpeg)
library(ggplot2)
library(gridExtra)
library(reshape2)

path <- "~/Pictures/ushuaia/stunning_landscape"
files_img <- list.files(path, full.names=TRUE)
files_img <- files_img[-length(files_img)]

sapply(files_img, function(file) {
    filter <- "extrude"
    filtered_img <- apply_filter(filter,
                                 read_img(file))
    
    destfile <- sub("/IMG", paste0("/treated/", filter, "-IMG"), file)
    save_img(filtered_img, destfile)
    
    beep()
})
system(paste0("say 'images done'"))

img <- read_img(files_img[1])
    
### 3
# img$blue <- sqrt(img$blue)
# save_img(img, 3)

### 4
# img$red <- sqrt(img$red)
# save_img(img, 4)

### 5
# img$green <- sqrt(img$green)
# save_img(img, 5)

### 6
# m <- matrix(unlist(img), ncol=3)
# valid <- apply(m, 1, which.max) == 2
# m <- apply(m, 2, function(x) {
#     x[valid] <- 1
#     x
# })

# dim(m) <- dim
# save_img(m, 6)
