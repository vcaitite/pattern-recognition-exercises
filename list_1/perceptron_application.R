rm(list=ls())
source("~/Documents/UFMG/10/Reconhecimento de padrões/list/list_1/trainPerceptron.R")
source("~/Documents/UFMG/10/Reconhecimento de padrões/list/list_1/yperceptron.R")
library(caret)

# Carregando base de dados:
path <- file.path("~/Documents/UFMG/10/Reconhecimento de padrões/list/list_1/database", "BreastCancer.csv")
data <- read.csv(path)

# Rotular as amostras das Classes com o valor de 0 (malígno) e 1 (benígno).
data$Class <- ifelse(data$Class=="malignant", 0, 1)

# Tratamento de dados faltantes - Remove-se linhas contendo NA
data <- data[complete.cases(data),]

# Removendo coluna ID
data <- data[,2:11]

# Realiza pelo 20 execuções diferentes
accuracy_train <- rep(0, 20)
accuracy_test <- rep(0, 20)
for(execution in 1:20){
  # Selecionar aleatoriamente 70% das amostras para o conjunto de treinamento e30% para o conjunto de teste
  partition <- createDataPartition(1:nrow(data),p=.7)
  train <- as.matrix(data[partition$Resample1,])
  test <- as.matrix(data[- partition$Resample1,])
  x_train <- as.matrix(train[, 1:(ncol(train)-1)])
  y_train <- as.matrix(train[, ncol(train)])
  x_test <- as.matrix(test[, 1:(ncol(train)-1)])
  y_test <- as.matrix(test[, ncol(train)])
  
  # Treinando modelo:
  retlist<-trainPerceptron(x_train, y_train, 0.1, 0.01, 1000, 1)
  W<-retlist[[1]]
  
  # Calculando acurácia de treinamento
  y_hat_train <- as.matrix(yperceptron(x_train, W, 1), nrow = length_train, ncol = 1)
  accuracy_train[execution]<-1-((t(y_hat_train-y_train) %*% (y_hat_train-y_train))/length(y_train))
  #print(paste("Acurácia de treinamento para execução", execution, ": ", accuracy_train[execution]))
  
  # Calculando acurácia de Teste:
  y_hat_test <- as.matrix(yperceptron(x_test, W, 1), nrow = length_test, ncol = 1)
  accuracy_test[execution]<-1-((t(y_hat_test-y_test) %*% (y_hat_test-y_test))/length(y_test))
  #print(paste("Acurácia de teste para execução", execution, ": ", accuracy_test[execution]))
}

# Média das acurácias
mean_accuracy_train <- mean(accuracy_train) * 100
mean_accuracy_test <- mean(accuracy_test) * 100

# Desvio Padrão das acurácias
sd_accuracy_train <- sd(accuracy_train) * 100
sd_accuracy_test <- sd(accuracy_test) * 100

#Printing Result
print(paste("Acurácia media de treinamento do modelo: ", mean_accuracy_train, "%", "±", sd_accuracy_train, "%"))
print(paste("Acurácia media de teste do modelo: ", mean_accuracy_test, "%", "±", sd_accuracy_test, "%"))

