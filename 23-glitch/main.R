setwd("~/workspace/math/23-glitch")
source('~/workspace/math/23-glitch/api.R')
source('~/workspace/math/23-glitch/filters.R')
library(beepr)
library(jpeg)
library(ggplot2)
library(gridExtra)
library(reshape2)

path <- "~/Pictures/ushuaia/stunning_landscape"
path <- "~/Pictures/ushuaia/stunning_personal"
files_img <- list.files(path, full.names=TRUE)
files_img <- files_img[-length(files_img)]

sapply(files_img, function(file) {
    filter <- "pixel_sort"
    filtered_img <- apply_filter(filter,
                                 read_img(file))
    
    destfile <- sub("/IMG", paste0("/treated/", filter, "-IMG"), file)
    save_img(filtered_img, destfile)
    
    beep()
})

# img <- read_img(files_img[13])
# img <- pixel_sort(img)
# save_img(img, "~/Desktop/test.jpg")
system(paste0("say 'images done'"))
