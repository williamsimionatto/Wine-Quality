
# Importa dados
WineData <- read.table("winequality-red.csv", sep=",", header=TRUE)

head(WineData)
table(WineData$quality)

install.packages("Amelia")

library(Amelia)
missmap(WineData, main="Valores Faltantes - Vinho Vermelho", col=c("red","grey"), legend=TRUE)

install.packages("ggplot2")
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
  xlab("Free SO2") +
  ylab("Count")

ggplot(WineData, aes(x = total.sulfur.dioxide)) +
  geom_histogram(binwidth = 3) +
  ggtitle("Distribuição total de SO2") +
  xlab("Total SO2") +
  ylab("Count")

ggplot(WineData, aes(x = alcohol)) +
  geom_histogram(binwidth = 0.1) +
  ggtitle("Distribuição do Alcool") +
  xlab("Alcohol") +
  ylab("Count")

ggplot(WineData, aes(x = quality)) +
  geom_histogram(binwidth = 1) +
  scale_x_continuous(breaks = seq(3, 8, by = 1)) +
  ggtitle("Distribuição da Qualidade") +
  xlab("Qualidade") +
  ylab("Count")
