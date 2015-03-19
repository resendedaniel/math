r0 <- 1
r1 <- 1.158728
by <- .001

f0 <- function(x, r0) {
    -sqrt((r0-x)*(r0+x))
}

f1 <- function(x, r0, r1) {
    sqrt((r1-x)*(r1+x)) - r0
}

x <- seq(-r0, r0, by=by)
y0 <- sapply(x, f0, r0=r0)
y1 <- sapply(x, f1, r0=r0, r1=r1)
invalid <- y1-y0 < 0
y1[invalid] <- y0[invalid]

data <- data.frame(x, y0, y1)

area <- function(y0, y1, by) {
    sum((y1 - y0) * by)
}

ggplot(data, aes(x=x, xend=x, y=y0, yend=y1)) +
    geom_line() +
    geom_segment() +
    geom_hline(aes(yintercept=0)) +
    ggtitle(paste0("Qual o tamanho da corda que preciso amarrar um gado\n",
            "para ele pastar em apenas metade de um terreno circular:\n",
            r1))

a <- area(y0, y1, by)
cat(a, pi/2, ifelse(a>pi/2,"Reduce","Increase"))