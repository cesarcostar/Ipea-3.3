library(plotly)

Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")





# Definir a interface do usuário
ui <- fluidPage(
  titlePanel("Exercicio 1 - Capitulo 11 - POR DENTRO DA PNAD CONTÍNUA"),
  
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
      
      style = "width: 400px;"
    ),
    
    mainPanel(
      plotlyOutput(outputId = "grafico1", height = "800px")
    )
  )
)

# Definir o servidor
server <- function(input, output) {
  
  # Filtrar os dados pelo ano selecionado pelo usuário
  dados_filtrados <- reactive({
    indicadores_mt %>% 
      filter(ano == input$ano)
  })
  
  # Criar o gráfico interativo
  output$grafico1 <- renderPlotly({
    ggplotly(
      ggplot(data = dados_filtrados(), aes(x = .data[[input$variavel]], y = reorder(UF, .data[[input$variavel]]), fill = .data[[input$variavel]])) +
        geom_col() +
        geom_text(aes(label = scales::comma(.data[[input$variavel]])), color = "white", fontface = "bold", size = 3, position = position_stack(vjust = 0.5)) +
        scale_fill_gradient(low = "#69b3a2", high = "#0072B2") +
        labs(x = input$variavel, y = "Unidade Federativa", 
             title = paste(input$variavel, "por UF"))
    )
  })
}

# Rodar o aplicativo Shiny
shinyApp(ui = ui, server = server)