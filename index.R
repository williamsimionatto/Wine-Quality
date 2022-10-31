
# Importa dados
WineData <- read.table("winequality-red.csv", sep=",", header=TRUE)

head(WineData)
table(WineData$quality)

# install.packages("Amelia")

# MISSING VALUES
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
  geom_histogram(binwidth = .1, fill = 'chartreuse',  col=I("chartreuse4")) +
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

ggplot(WineData, aes(x = volatile.acidity)) +
  geom_density(aes(fill = "red", color = "red")) +
  facet_wrap(~quality) +
  theme(legend.position = "none") +
  ggtitle("Acidez Volátil VS Qualidade") +
  xlab("Acidez Volátil") +
  ylab("Qualidade")

ggplot(WineData, aes(x = quality)) +
  geom_histogram(binwidth = 1) +
  scale_x_continuous(breaks = seq(3, 8, by = 1)) +
  ggtitle("Distribuição da Qualidade") +
  xlab("Qualidade") +
  ylab("Count")

ggplot(WineData, aes(x = density, y = alcohol)) +
  geom_jitter(aes(alpha = 1/2)) +
  ggtitle("Densidade VS Alcool") +
  xlab("Densidade") +
  ylab("Alcool")

ggplot(WineData, aes(x = density, y = alcohol, color = quality)) +
  geom_point(alpha=0.1) +
  theme_dark() +
  geom_smooth(se = FALSE, size=0.8) +
  ggtitle('Densidade por teor alcoolico do vinho') +
  labs(y = 'Teor Alcoolico', x = 'Densidade', color = 'Qualidade do Vinho')

ggplot(WineData, aes(x = residual.sugar, color = quality)) +
  geom_density() +
  scale_color_brewer(type = 'seq', palette = 'RdPu') +
  scale_x_log10(breaks = seq(1, 15, 2)) +
  scale_y_continuous(breaks = seq(0, 1.5, .25)) +
  labs(x = 'Açúcar Residual por Litro', y = 'Densidade', color = 'Qualidade do Vinho') +
  ggtitle('Densidade por açúcar residual em escala log segmentado por qualidade')

# cria variáveis categoricas para a qualidade do vinho
WineData$quality <- ifelse(WineData$quality < 5, 'ruim', ifelse(WineData$quality > 6, 'bom', 'normal'))
WineData$quality <- as.factor(WineData$quality)
str(WineData$quality)

# Verifica a distribuição dos dados original dos dados.
prop.table(table(WineData$quality))

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

# install.packages("caret")
library(caret)
confusionMatrix <- confusionMatrix(WineData_test$quality, WineData_predict)
confusionMatrixTable <- as.data.frame(confusionMatrix$table)
confusionMatrixTable$diag <- confusionMatrixTable$Prediction == confusionMatrixTable$Reference
confusionMatrixTable$ref_freq <- confusionMatrixTable$Freq * ifelse(is.na(confusionMatrixTable$diag),-1,1)
data.frame(confusionMatrix$overall)

ggplot(data = confusionMatrixTable, aes(x = Prediction , y =  Reference, fill = Freq))+
  scale_x_discrete(position = "top") +
  geom_tile( data = confusionMatrixTable, aes(fill = ref_freq)) +
  scale_fill_gradient2(guide = FALSE, low="red3", high="orchid4", midpoint = 0, na.value = 'white') +
  geom_text(aes(label = Freq), color = 'black', size = 3) +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        legend.position = "none",
        panel.border = element_blank(),
        plot.background = element_blank(),
        axis.line = element_blank(),
  )

## Treina com mais trials
error.rate = NULL
trials <- 1:20

for(i in trials){
  set.seed(123)
  model = C5.0(WineData_train[-12], WineData_train$quality, trials = i)
  predict <- predict(model, WineData_test)
  error.rate[i] = mean(WineData_test$quality != predict)
}

error.df <- data.frame(error.rate,trials)
error.df
ggplot(error.df,aes(x=trials,y=error.rate)) + 
  geom_point() + 
  geom_line(lty="dotted",color='red')

