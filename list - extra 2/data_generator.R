rm(list=ls())
library(mvtnorm)

n1 <- 140
n2 <- 60
xc1 <- rmvnorm(n1, mean=c(3,3), sigma = matrix(c(5, 0, 0, 0.2), nrow = 2, byrow = TRUE))
xc2 <- rmvnorm(n2, mean=c(3,4), sigma = matrix(c(5, 0, 0, 0.2), nrow = 2, byrow = TRUE))
X <- rbind(xc1, xc2)
Y <- c(rep(1, n1), rep(2, n2))
cols <- c("red","blue")
plot(X,  col=cols[Y])
data <- cbind(X, Y)
path = "~/Documents/UFMG/Mastering/2/Reconhecimento de padrões/listas/new/list_2/data.csv"
write.csv(data, path, row.names = FALSE)
