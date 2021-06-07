rm(list=ls())

# Carregando base de dados:
path <- file.path("~/Documents/UFMG/10/Reconhecimento de padrões/list/list_1/database", "BreastCancer.csv")
data <- read.csv(path)

plot(data[,2:11], col=c("red", "blue")[unclass(data$Class)])
