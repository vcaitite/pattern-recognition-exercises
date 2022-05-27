rm(list=ls())
library(mlbench)

data <- mlbench.spirals(3000 , sd =0.05)
cols <- c("red","blue")
plot(data$x,  col=cols[data$classes])
data <- cbind(data$x, data$classes)
path = "~/Documents/UFMG/Mastering/2/Reconhecimento de padrões/listas/new/list_5/data/spirals.csv"
write.csv(data, path, row.names = FALSE)
