
# Importa dados
WineData <- read.table("winequality-red.csv", sep=",", header=TRUE)

head(WineData)
table(WineData$quality)

# install.packages("Amelia")

library(Amelia)
missmap(WineData, main="Valores Faltantes - Vinho Vermelho", col=c("red","grey"), legend=TRUE)

# install.packages("ggplot2")
library(ggplot2)

ggplot(WineData, aes(x = fixed.acidity)) +
  geom_histogram(binwidth = 0.1) +
  scale_x_continuous(breaks = seq(4, 16, by = 1)) +
  ggtitle("Distruibuição Acidez Fixa") +
  xlab("Acidez Fixa") +
  ylab("Count")

ggplot(WineData, aes(x = pH)) +
  geom_histogram(binwidth = 0.02) +
  ggtitle("Distribuição pH") +
  xlab("pH") +
  ylab("Count")

ggplot(WineData, aes(x = free.sulfur.dioxide)) +
  geom_histogram(binwidth = 1) +
  ggtitle("Distribuição de SO2 liberado") +
  xlab("SO2 Liberado") +
  ylab("Count")

ggplot(WineData, aes(x = total.sulfur.dioxide)) +
  geom_histogram(binwidth = 3) +
  ggtitle("Distribuição total de SO2") +
  xlab("Total SO2") +
  ylab("Count")

ggplot(WineData, aes(x = alcohol)) +
  geom_histogram(binwidth = 0.1) +
  ggtitle("Distribuição do Alcool") +
  xlab("Alcool") +
  ylab("Count")

ggplot(WineData, aes(x = quality)) +
  geom_histogram(binwidth = 1) +
  scale_x_continuous(breaks = seq(3, 8, by = 1)) +
  ggtitle("Distribuição da Qualidade") +
  xlab("Qualidade") +
  ylab("Count")

ggplot(WineData, aes(x = volatile.acidity)) +
  geom_density(aes(fill = "red", color = "red")) +
  facet_wrap(~quality) +
  theme(legend.position = "none") +
  ggtitle("Acidez Volátil VS Qualidade") +
  xlab("Acidez Volátil") +
  ylab("Qualidade")

ggplot(WineData, aes(x = density, y = alcohol)) +
  geom_jitter(aes(alpha = 1/2)) +
  ggtitle("Densidade VS Alcool") +
  xlab("Densidade") +
  ylab("Alcool")

ggplot(aes(x = density, y = alcohol, color = quality), data = WineData)+
  geom_point(alpha=0.1) +
  theme_bw() +
  geom_smooth(se = FALSE, size=0.8)

# Pode-se observar que ao utilizar a qualidade como indicador de cor,
# a tendência geral é que quanto maior o álcool, menor a densidade.
# Pode-se observar também que quanto maior a qualidade, maior o teor alcoólico e menor a densidade.

# cria variáveis categoricas para a qualidade do vinho
WineData$quality <- ifelse(WineData$quality < 5, 'ruim', ifelse(WineData$quality > 6, 'bom','normal'))
WineData$quality <- as.factor(WineData$quality)
str(WineData$quality)

# Preparacao dos dados - cria datasets aleatorios para treino e tests
set.seed(123)
train_sample <- sample(nrow(WineData), 0.8 * nrow(WineData))
WineData_train <- WineData[train_sample, ]
WineData_test <- WineData[-train_sample, ]

# Verifica se os dados estao distribuidos de maneira uniforme
prop.table(table(WineData_train$quality))
prop.table(table(WineData_test$quality))

# Treinando modelo

# install.packages("C50")
library(C50)
WineData_model <- C5.0(WineData_train[-12], WineData_train$quality)
WineData_model
summary(WineData_model)

WineData_predict <- predict(WineData_model, WineData_test)

# install.packages("gmodels")
library(gmodels)

CrossTable(WineData_test$quality, WineData_predict, prop.chisq = FALSE, prop.c= FALSE, prop.r = FALSE, dnn = c('Qualidade Atual', 'Qualidade Prevista'))

# install.packages("caret")
library(caret)
confusionMatrix(WineData_test$quality, WineData_predict)
