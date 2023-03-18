# Instale os pacotes shiny e shinythemes se você ainda não os instalou
# install.packages("shiny")
# install.packages("shinythemes")

# Carregar pacotes
library(shiny)
library(shinythemes)
library(rgdal)
library(spdep)
library(maptools)
library(sf)
library(ggplot2)

# Crie uma função para gerar o mapa
generate_map <- function() {
  ggplot(data = brasil_estados) +
    geom_sf(aes(fill = tx_desocup)) +
    geom_text(data = centroid_coords, aes(x = x, y = y, label = round(tx_desocup, 1)),
              size = 3, color = "black") +
    scale_fill_gradient(low = "white", high = "red", name = "Taxa de Desocupação") +
    labs(title = "Taxa de Desocupação por Estado") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5))
}

# Código do aplicativo Shiny
ui <- fluidPage(
  theme = shinytheme("cerulean"),
  titlePanel("Shiny Regional"),
  mainPanel(
    plotOutput("map", height = "900px", width = "900px")
  )
)

server <- function(input, output) {
  output$map <- renderPlot({
    generate_map()
  })
}

shinyApp(ui = ui, server = server)
