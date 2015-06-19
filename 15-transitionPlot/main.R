setwd("~/workspace/math/15-transitionPlot")
source('~/workspace/math/constants.R')

transitionPlot <- function(seq, fun, side_by_side=FALSE, save=F) {
    if(save) {
         folders <- list.files("img")
         folders <- unlist(strsplit(folders, "-"))
         folders <- as.numeric(folders)
         folder_i <- max(folders, na.rm=T) + i
         dir <- paste0("img/img-", foder_i)
         dir.create(dir)
    }
    
    data <- sapply(seq, function(n) {
        sapply(1:201/n, function(x) {
            do.call(fun, list(x))
        })
    })
    
    if(side_by_side) {
        melt_data <- melt(data)
        g <- ggplot(melt_data, aes(Var1, value, colour=Var2)) + 
            geom_point(size=1) + 
            ylim(0, quantile(y, 1-dnorm(3))) +
            facet_wrap(~Var2)
        print(g)
    } else {
        apply(data, 2, function(y) {
            plot(y,
                 pch=20,
                 axes=FALSE,
                 frame.plot=FALSE,
                 #              xlab="Take me out of here",
                 xlab="",
                 ylab="")
            #         dev.off()
            Sys.sleep(1/12)
        })
    }
}

funs <- list(function(x) (sin(x)^2)/sqrt(cos(log(x)/4)),              
             function(x) sin(x),
             function(x) sin(2*x)/sqrt(sin(sin(x))^2),
             function(x) log(sin(2*x * (1/x))/sqrt(sin(sin(x))^2)),
             function(x) log(sin(2*x * (1/n))/sqrt(sin(sin(x))^2)))
#         y <- sin(log(log(x)/n))^2/sqrt(cos(x/3))

tau <- 2 * pi
seq <- seq(0, tau, length.out=6^2+1)
seq <- seq ^ 2
seq <- seq[seq != 0]
out <- transitionPlot(seq, funs[[1]], side_by_side=T)
