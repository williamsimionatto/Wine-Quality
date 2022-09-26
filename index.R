
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

# cria variáveis categoricas para a qualidade do vinho
WineData$quality_description <- ifelse(WineData$quality < 5, 'ruim', ifelse(WineData$quality > 6,'bom','normal'))
WineData$quality_description <- as.factor(WineData$quality_description)
str(WineData$quality_description)

# Preparacao dos dados - cria datasets aleatorios para treino e tests
set.seed(as.numeric(Sys.Date()))
train_sample <- sample(nrow(WineData), 0.80 * nrow(WineData))
WineData_train <- WineData[train_sample, ]
WineData_test <- WineData[-train_sample, ]

# Verifica se os dados estao distribuidos de maneira uniforme
prop.table(table(WineData_train$quality_description))
prop.table(table(WineData_test$quality_description))
