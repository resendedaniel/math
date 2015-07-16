package_list <- c('jpeg', 'ggplot2', 'gridExtra', 'reshape2')
for(p in package_list) {
    if(!(p %in% rownames(installed.packages()))) install.packages(p, repos='http://cran.rstudio.com', lib='/usr/local/lib/R/site-library/', dependencies=TRUE)
    library(p, character.only = TRUE)
}

source('api.R')
source('filters.R')
library(jpeg)
library(ggplot2)
library(gridExtra)
library(reshape2)

path <- "~/img/botanical"
path <- "~/Pictures/cityporn"

files <- list.files(path)
files <- paste(path, files, sep="/")
files <- files[!grepl("treated", files)]

abysm <- sapply(files, function(file) {

    t <- proc.time()
    size <- round(file.info(file)$size / (2^20), 2)
    raw_img <- read_img(file)
    file <- sub(".jpg", "", file)
    file <- sub(".jpeg", "", file)
    file <- sub(".JPG", "", file)
    file <- sub(".JPEG", "", file)

    f0 <- "pixel_sort_sd"
    img <- apply_filter(f1, raw_img)
    destfile <- gsub(paste0(path,"/"), paste0(path, "/treated/"), file)
    destfile <- paste0(destfile, "-", f0, ".jpg")
    save_img(img, destfile)
    rm(img)
    cat("\n")
    
    f1 <- "pixel_sort_var"
    img <- apply_filter(f1, raw_img)
    destfile <- gsub(paste0(path,"/"), paste0(path, "/treated/"), file)
    destfile <- paste0(destfile, "-", f1, ".jpg")
    save_img(img, destfile)
    rm(img)
    cat("\n")
    
#     f2 <- "pixel_sort_color"
#     img <- apply_filter(f2, raw_img, color="red")
#     destfile <- gsub(paste0(path,"/"), paste0(path, "/treated/"), file)
#     destfile <- paste0(destfile, "-", f2, "-red", ".jpg")
#     save_img(img, destfile)
#     rm(img)
#     cat("\n")
#     
#     img <- apply_filter(f2, raw_img, color="green")
#     destfile <- gsub(paste0(path,"/"), paste0(path, "/treated/"), file)
#     destfile <- paste0(destfile, "-", f2, "-green", ".jpg")
#     save_img(img, destfile)
#     rm(img)
#     cat("\n")
#     
#     img <- apply_filter(f2, raw_img, color="green")
#     destfile <- gsub(paste0(path,"/"), paste0(path, "/treated/"), file)
#     destfile <- paste0(destfile, "-", f2, "-blue", ".jpg")
#     save_img(img, destfile)
#     rm(img)
#     cat("\n")

    cat(file, "\n", "size: ", paste0(size, "mb"), "\n")
    print(proc.time() - t)
    cat("\n")
})
# system(paste0("say 'images done.'"))

# img <- read_img(files[1])
# plot_channels(img)
# save_img(img, "~/Desktop/test.jpg")
