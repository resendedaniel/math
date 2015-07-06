setwd("~/workspace/math/23-glitch")
source('~/workspace/math/23-glitch/api.R')
source('~/workspace/math/23-glitch/filters.R')
library(beepr)
library(jpeg)
library(ggplot2)
library(gridExtra)
library(reshape2)

# path <- "~/Pictures/ushuaia/stunning_landscape"
# path <- "~/Pictures/ushuaia/stunning_personal"
# path <- "~/Pictures/nephews"
# path <- "~/Pictures/inhotim"
# path <- "~/Pictures/zeca"
# path <- "~/Pictures/groceries"
path <- "~/Pictures/judson2"
files <- list.files(path)
files <- paste(path, files, sep="/")
files <- files[-length(files)]

# sapply(files[c(30, 28, 22, 18, 14, 10, 1:3)], function(file) {
abysm <- sapply(files[-c(1:2)], function(file) {
    filter <- c("invert_color",
                "random_sidewalk",
                "extrude",
                "single_col",
                "noise_on_standard_deviation",
                "pixel_sort_color",
                "pixel_sort_sd")[6]
    color <- "red"
    img <- apply_filter(filter, read_img(file), color)
    destfile <- gsub(paste0(path,"/"), paste0(path, "/treated/", filter, color, "-"), file)
    save_img(img, destfile)
    
    color <- "green"
    img <- apply_filter(filter, read_img(file), color)
    destfile <- gsub(paste0(path,"/"), paste0(path, "/treated/", filter, color, "-"), file)
    save_img(img, destfile)
    
    color <- "blue"
    img <- apply_filter(filter, read_img(file), color)
    destfile <- gsub(paste0(path,"/"), paste0(path, "/treated/", filter, color, "-"), file)
    save_img(img, destfile)
    
    beep()
})
system(paste0("say 'images done.'"))

# img <- read_img(files[1])
# plot_channels(img)
# save_img(img, "~/Desktop/test.jpg")
