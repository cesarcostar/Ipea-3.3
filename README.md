# Chamada Pública nº 014/2023 - “IpeaDATA-lab”.

Candidatos 3, 4, e 5 - Bolsa de Incentivo à Pesquisa II - Superior Completo

POR DENTRO DA PNAD CONTÍNUA

Cap. 11.4 Exercicio 1 Calcule todas as medidas de subutilização da força de trabalho por Regiões
Geográficas montando uma série de dados trimestrais para os anos de 2019 e 2020.

Utilizei as Livrarias:
library (dplyr)
library (PNADcIBGE)
library (tidyverse)
library (expss)

Para análise dos indicadores espaciais:

library(rgdal)
library(spdep)
library(maptools)
library(sf)
library(ggplot2)

Malha Territorial:

https://www.ibge.gov.br/geociencias/organizacao-do-territorio/malhas-territoriais/15774-malhas.html

# Definir vizinhança queen
nb_queen <- poly2nb(brasil_estados, queen = TRUE)

# Definir vizinhança rook
nb_rook <- poly2nb(brasil_estados, queen = FALSE)

# Calcular autocorrelação espacial (Moran) para vizinhança queen
moran_queen <- moran.test(brasil_estados$tx_desocup, nb2listw(nb_queen))

# Calcular autocorrelação espacial (Moran) para vizinhança rook
moran_rook <- moran.test(brasil_estados$tx_desocup, nb2listw(nb_rook))

