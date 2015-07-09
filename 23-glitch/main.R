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

# path <- "~/Pictures/ushuaia/stunning_landscape"
# path <- "~/Pictures/ushuaia/stunning_personal"
path <- "~/Pictures/macro"
files <- list.files(path)
files <- paste(path, files, sep="/")
files <- files[!grepl("treated", files)]

abysm <- sapply(files[-c(1:14)], function(file) {
    filter <- c("invert_color",
                "random_sidewalk",
                "extrude",
                "single_col",
                "noise_on_standard_deviation",
                "pixel_sort_color",
                "pixel_sort_sd")[7]

    t <- proc.time()
    size <- file.info(file)$size / (2^10)^10
    
    img <- apply_filter(filter, read_img(file))
    file <- sub(".jpg", "", file)
    destfile <- gsub(paste0(path,"/"), paste0(path, "/treated/", filter, "-"), file)
    destfile <- paste0(destfile, ".jpg")
    save_img(img, destfile)
    cat("\n", file, "\n", "size: ", paste0(size, "mb"), "\n\n")
    print(proc.time() - t)
})
system(paste0("say 'images done.'"))

# img <- read_img(files[1])
# plot_channels(img)
# save_img(img, "~/Desktop/test.jpg")
