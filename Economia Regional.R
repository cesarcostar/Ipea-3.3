# Carregar pacotes
library(rgdal)
library(spdep)
library(maptools)
library(sf)
library(ggplot2)

Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")

# Carregar o shapefile
brasil_estados <- st_read("BR_UF_2021.shp")

brasil_estados$UF <- brasil_estados$NM_UF
brasil_estados$NM_UF <- NULL

# Converter a coluna "UF" no shapefile para caractere
brasil_estados$UF <- as.character(brasil_estados$UF)

# Converter a coluna "UF" no arquivo de dados para caractere
indicadores_mt2021$UF <- as.character(indicadores_mt2021$UF)

brasil_estados <- merge(brasil_estados, indicadores_mt2021, by.x="UF", by.y="UF")

# Definir vizinhança queen
nb_queen <- poly2nb(brasil_estados, queen = TRUE)

# Definir vizinhança rook
nb_rook <- poly2nb(brasil_estados, queen = FALSE)

# Calcular autocorrelação espacial (Moran) para vizinhança queen
moran_queen <- moran.test(brasil_estados$tx_desocup, nb2listw(nb_queen))

# Calcular autocorrelação espacial (Moran) para vizinhança rook
moran_rook <- moran.test(brasil_estados$tx_desocup, nb2listw(nb_rook))

ggplot(data = brasil_estados) +
  geom_sf(aes(fill = tx_desocup)) +
  scale_fill_gradient(low = "white", high = "red", name = "Taxa de Desocupação") +
  labs(title = "Taxa de Desocupação por Estado") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

#legenda

# Calcular os centróides dos estados
brasil_estados$centroid <- st_centroid(brasil_estados)

# Criar um data frame com as coordenadas x e y dos centróides
centroid_coords <- data.frame(
  UF = brasil_estados$UF,
  tx_desocup = brasil_estados$tx_desocup,
  x = st_coordinates(brasil_estados$centroid)[, 1],
  y = st_coordinates(brasil_estados$centroid)[, 2]
)

# Criar um mapa temático da taxa de desocupação com ggplot2 e adicionar rótulos
ggplot(data = brasil_estados) +
  geom_sf(aes(fill = tx_desocup)) +
  geom_text(data = centroid_coords, aes(x = x, y = y, label = round(tx_desocup, 1)),
            size = 3, color = "black") +
  scale_fill_gradient(low = "white", high = "red", name = "Taxa de Desocupação") +
  labs(title = "Taxa de Desocupação por Estado") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

