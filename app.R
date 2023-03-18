library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(DT)

# Definir a interface do usuário
ui <- fluidPage(
  titlePanel("Análise de Dados"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "variavel", label = "Variável:",
                  choices = c("Taxa de desocupação" = "tx_desocup",
                              "Taxa combinada de desocupação e de subocupação por insuficiência de horas trabalhadas" = "tx_comb_subocup",
                              "Taxa combinada de desocupação e força de trabalho potencial" = "tx_comb_ftp",
                              "Taxa composta de subutilização da força de trabalho" = "tx_comp_subut",
                              "Taxa de desalento na força de trabalho ampliada" = "tx_desal_fat",
                              "Percentual de desalentados na população fora da força de trabalho" = "pc_desal_fft",
                              "Percentual de desalentados na força de trabalho potencial" = "pc_desal_ftp")),
      
      selectInput(inputId = "ano", label = "Ano:",
                  choices = unique(indicadores_mt$ano)),
      
      img(src = "ipea.jfif", height = 100, width = 100)
    ),
    
    mainPanel(
      plotlyOutput(outputId = "grafico1"),
      dataTableOutput(outputId = "tabela1")
    )
  )
)




