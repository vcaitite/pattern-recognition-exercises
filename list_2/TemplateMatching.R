rm(list=ls())
library("jpeg")
library("imager")
library("OpenImageR")

rotate <- function(image) t(apply(image, 2, rev))
grayscale <- function(image)  0.2126 * image[,,1] + 0.7152 * image[,,2] + 0.0722 * image[,,3]
  
image <- readJPEG("~/Documents/UFMG/10/Reconhecimento de padrões/list/pattern-recognition-exercises/list_2/placas.jpg")
plates <- grayscale(image)
plates <- rotate(plates)
op <- par(bg = "thistle")
image(plates)
rect(150, 400, 175, 450, density = 90, col = "blue",
     angle = -30, border = "transparent")

p1 <- readJPEG("~/Documents/UFMG/10/Reconhecimento de padrões/list/pattern-recognition-exercises/list_2/placa_1.jpg")
p1 <- grayscale(p1)
p1 <- rotate(p1)
image(p1)

nl_p1 <- nrow(p1)
nc_p1 <- ncol(p1)  
nl <- nrow(plates) - nl_p1
nc <- ncol(plates) - nc_p1

d <- matrix(0, nl, nc)
for(l in 1:nl){
  for(c in 1:nc){
    d[l,c] <- sum(abs(plates[l:(l+nl_p1-1), c:(c+nc_p1-1)]-p1))
  }
}

result = which(d == min(d), arr.ind=TRUE)
contour(d)

for(l in (result[1]:233)){
  plates[l, result[2]]=7
  plates[l, result[2]+85]=7
  plates[l, result[2]+1]=7
  plates[l, result[2]+86]=7
  plates[l, result[2]+2]=7
  plates[l, result[2]+87]=7
}
image(plates, col=gray(50:1/50))
