#1. Calcule todas as medidas de subutilização da força de trabalho por Regiões
#Geográficas montando uma série de dados trimestrais para os anos de 2019 e
#2020.

#Indicadores de mercado de trabalho

rm(list = ls()) #Libera memória, apagando os objetos abertos no R.

gc() #Libera a memoria RAM que não esta sendo utilizada pelo computador:

Sys.getlocale()

Sys.setlocale("LC_ALL", "en_US.UTF-8")


library (dplyr)
library (PNADcIBGE)
library (tidyverse)
library (expss)

#2021

pnadc2021_T1_df <- get_pnadc(2021,
                             quarter = 1,
                             design = FALSE,
                             labels = TRUE)



indicadores_mt2021 <- pnadc2021_T1_df %>%
  tab_cells(UF) %>%
  tab_cols(VD4002,VD4003,VD4004A,VD4005) %>%
  tab_weight(weight = V1028) %>%
  tab_stat_cases(total_statistic = "w_cases",
                 total_label = "Total") %>%
  tab_pivot()


names(indicadores_mt2021)

colnames(indicadores_mt2021) <- c("UF","ocup","desocup","ftp","fft","subocup","desalent")

names(indicadores_mt2021)

indicadores_mt2021 <- as_tibble(indicadores_mt2021)



indicadores_mt2021 <-
  as.data.frame(indicadores_mt2021 %>%
                  mutate(tx_desocup = desocup/(ocup+desocup)* 100,
                         tx_comb_subocup = (desocup+subocup)/(ocup+desocup)* 100,
                         tx_comb_ftp = (desocup+ftp)/(ocup+desocup+ftp)* 100,
                         tx_comp_subut = (desocup+subocup+ftp)/(ocup+desocup+ftp)* 100,
                         tx_desal_fta = (desalent)/(ocup+desocup+ftp)* 100,
                         pc_desal_fft = (desalent)/(fft + ftp)* 100,
                         pc_desal_ftp = (desalent)/(ftp)* 100))





indicadores_mt2021 <- as.data.frame(indicadores_mt2021) %>%
  select(UF, tx_desocup, tx_comb_subocup,
         tx_comb_ftp, tx_comp_subut, tx_desal_fta,
         pc_desal_fft, pc_desal_ftp)


#Visualiza apenas as primeiras linhas do objeto
head(indicadores_mt2021)

#2020


pnadc2020_T1_df <- get_pnadc(2020,
                             quarter = 1,
                             design = FALSE,
                             labels = TRUE)



indicadores_mt2020 <- pnadc2020_T1_df %>%
  tab_cells(UF) %>%
  tab_cols(VD4002,VD4003,VD4004A,VD4005) %>%
  tab_weight(weight = V1028) %>%
  tab_stat_cases(total_statistic = "w_cases",
                 total_label = "Total") %>%
  tab_pivot()

names(indicadores_mt2020)

colnames(indicadores_mt2020) <- c("UF","ocup","desocup","ftp","fft","subocup","desalent")

names(indicadores_mt2020)

indicadores_mt2020 <- as_tibble(indicadores_mt2020)


indicadores_mt2020 <- as.data.frame(indicadores_mt2020 %>%
                                      mutate(tx_desocup = desocup/(ocup+desocup)* 100,
                                             tx_comb_subocup = (desocup+subocup)/(ocup+desocup)* 100,
                                             tx_comb_ftp = (desocup+ftp)/(ocup+desocup+ftp)* 100,
                                             tx_comp_subut = (desocup+subocup+ftp)/(ocup+desocup+ftp)* 100,
                                             tx_desal_fta = (desalent)/(ocup+desocup+ftp)* 100,
                                             pc_desal_fft = (desalent)/(fft + ftp)* 100,
                                             pc_desal_ftp = (desalent)/(ftp)* 100))

indicadores_mt2020 <- as.data.frame(indicadores_mt2020) %>%
  select(UF, tx_desocup, tx_comb_subocup,
         tx_comb_ftp, tx_comp_subut, tx_desal_fta,
         pc_desal_fft, pc_desal_ftp)


#Visualiza apenas as primeiras linhas do objeto
head(indicadores_mt2020)


#2019


pnadc2019_T1_df <- get_pnadc(2019,
                             quarter = 1,
                             design = FALSE,
                             labels = TRUE)



indicadores_mt2019 <- pnadc2019_T1_df %>%
  tab_cells(UF) %>%
  tab_cols(VD4002,VD4003,VD4004A,VD4005) %>%
  tab_weight(weight = V1028) %>%
  tab_stat_cases(total_statistic = "w_cases",
                 total_label = "Total") %>%
  tab_pivot()

names(indicadores_mt2019)

colnames(indicadores_mt2019) <- c("UF","ocup","desocup","ftp","fft","subocup","desalent")

names(indicadores_mt2019)

indicadores_mt2019 <- as_tibble(indicadores_mt2019)


indicadores_mt2019 <- as.data.frame(indicadores_mt2019 %>%
                                      mutate(tx_desocup = desocup/(ocup+desocup)* 100,
                                             tx_comb_subocup = (desocup+subocup)/(ocup+desocup)* 100,
                                             tx_comb_ftp = (desocup+ftp)/(ocup+desocup+ftp)* 100,
                                             tx_comp_subut = (desocup+subocup+ftp)/(ocup+desocup+ftp)* 100,
                                             tx_desal_fta = (desalent)/(ocup+desocup+ftp)* 100,
                                             pc_desal_fft = (desalent)/(fft + ftp)* 100,
                                             pc_desal_ftp = (desalent)/(ftp)* 100))

indicadores_mt2019 <- as.data.frame(indicadores_mt2019) %>%
  select(UF, tx_desocup, tx_comb_subocup,
         tx_comb_ftp, tx_comp_subut, tx_desal_fta,
         pc_desal_fft, pc_desal_ftp)


#Visualiza apenas as primeiras linhas do objeto
head(indicadores_mt2019)

indicadores_mt2021$UF

indicadores_mt2019 <- mutate(indicadores_mt2019, ano = 2019)

indicadores_mt2020 <- mutate(indicadores_mt2020, ano = 2020)

indicadores_mt2021 <- mutate(indicadores_mt2021, ano = 2021)

indicadores_mt2019$UF <- sub("UF\\|", "", indicadores_mt2019$UF)

indicadores_mt2020$UF <- sub("UF\\|", "", indicadores_mt2020$UF)

indicadores_mt2021$UF <- sub("UF\\|", "", indicadores_mt2021$UF)

indicadores_mt <- bind_rows(indicadores_mt2019,indicadores_mt2020,indicadores_mt2021)

indicadores_mt


#shiny

library(shiny)
library(dplyr)

#tx desocup Taxa de desocupação
#tx comb subocup
#Taxa combinada de desocupação e de subocupação por
#insuficiência de horas trabalhadas
#tx comb ftp Taxa combinada de desocupação e força de trabalho potencial
#tx comp subut Taxa composta de subutilização da força de trabalho
#tx desal fta Taxa de desalento na força de trabalho ampliada
#pc desal fft
#Percentual de desalentados na população fora da força de
#trabalho
#pc desal ftp Percentual de desalentados na força de trabalho potencial







