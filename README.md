Red Wine Quality
================

Este projeto tem por objetivo treinar um modelo do machine learning para
prever a qualidade do vinho vermelho. Para este treinamento será
utilizado o modelo `Árvore de decisão`, por meio do pacote (`C50`).

## Dataset

O Dataset está disponível em: [Red Wine
Quality](https://www.kaggle.com/datasets/uciml/red-wine-quality-cortez-et-al-2009).

O Dataset apresenta os dados de 1599 vinhos, distribuídos entre 12
variáveis coletadas com base em testes físicos-químicos:

1.  `fixed acidity`

-   Representa a volatilidade dos ácidos presentes no vinho, ou seja,
    ácidos que não evaporam facilmente.

2.  `volatile acidity`

-   Representa a quantidade de ácido acético no vinho, ou seja, níveis
    muito altos podem causar um sabador de vinagre no vinho.

3.  `citric acid`

-   Representa a quantidade de ácido cítrico presente no vinho.

4.  `residual sugar`

-   Representa a quantidade de açúcar restante no vinho após o processo
    de fermentação.

5.  `chlorides`

-   Representa a quantidade de sal presente no vinho.

6.  `free sulfur dioxide`

-   Representa a quantidade de gás SO2 liberado.

7.  `total sulfur dioxide`

-   Representa o total de gás SO2.

8.  `density`

-   Representa a densidade do vinho.

9.  `pH`

-   Representa quão ácido ou básico é um vinho em uma escala de 0 (muito
    ácido) a 14 (muito básico);

10. `sulphates`

-   Um aditivo de vinho que pode contribuir para os níveis de dióxido de
    enxofre

11. `alcohol`

-   Representa a percentagem de teor alcoólico do vinho.

12 . `quality`

-   Representa a pontuação do vinho, em uma escala de 0 a 10. Sendo 0 um
    vinho considerado `ruim` e 10 um vinho `bom`.

## Análise Exploratória dos dados

Uma breve análise dos dados, para poder entender suas características.

![](README_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

A partir do gráfico gerado, podemos observar que a tendência geral é que
quanto maior o teor álcoolico do vinho, menor a sua densidade. Nesta
análise, pode-se concluir também que quanto maior a qualidade do vinho,
maior o teor alcoólico e menor a densidade.

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

Vemos que a densidade por açúcar residual tem uma distribuição bimodal
para os vinhos de maior qualidade e uma cauda longa para os de menor
qualidade mas de forma pouco significativa.

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

O pH presentes nos vinhos, apresenta uma distribuição normal e bem
concentrada, na faixa entre `3.0` e `3.7`.

## Preparação dos dados para aplicação do modelo

Para preparação dos dados, foi necessário criar uma variável categorica
para a qualidade do vinho, aplicando o seguinte critério:

> Qualidade \< 5 = ruim, Qualidade \> 5 & Qualidade \< 6 = normal,
> Qualidade \> 6 = boa

Os dados foram separados aleatoriamente entre dados de ‘test’ e
‘training’, onde 80% dos dados foram separados para testes e os 20%
restantes separados para treinamento do modelo.

Após a separação os dados ficaram distruibuidos da seguinte forma:

| Var1   |      Freq |
|:-------|----------:|
| bom    | 0.1469898 |
| normal | 0.8123534 |
| ruim   | 0.0406568 |

Distribuição dos dados de treinamento

| Var1   |     Freq |
|:-------|---------:|
| bom    | 0.090625 |
| normal | 0.875000 |
| ruim   | 0.034375 |

Distribuição dos dados de testes

É possível notar que os dados não estão distribuídos de maneira
uniforme, pois em ambos os datasets há uma concentração de vinhos
considerados `normais`, cerca de 80%.
