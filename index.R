
# Importa dados
WineData <- read.table("winequality-red.csv", sep=",", header=TRUE)

head(WineData)
table(WineData$quality)
