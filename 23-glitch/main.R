package_list <- c('jpeg', 'ggplot2', 'gridExtra', 'reshape2')
for(p in package_list) {
    if(!(p %in% rownames(installed.packages()))) install.packages(p, repos='http://cran.rstudio.com', lib='/usr/local/lib/R/site-library/')
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
path <- "~/img/zeca"
files <- list.files(path)
files <- paste(path, files, sep="/")
files <- files[!grepl("treated", files)]

abysm <- sapply(files, function(file) {
    filter <- c("invert_color",
                "random_sidewalk",
                "extrude",
                "single_col",
                "noise_on_standard_deviation",
                "pixel_sort_color",
                "pixel_sort_sd")[7]

    print(file)
    img <- apply_filter(filter, read_img(file))
    destfile <- gsub(paste0(path,"/"), paste0(path, "/treated/", filter, "-"), file)
    save_img(img, destfile)
})
system(paste0("say 'images done.'"))

# img <- read_img(files[1])
# plot_channels(img)
# save_img(img, "~/Desktop/test.jpg")
