library(tidyverse)
library(readr)
cat("Darbinė direktorija:", getwd())
download.file("https://atvira.sodra.lt/imones/downloads/2023/monthly-2023.csv.zip", "../data/temp")
unzip("../data/temp",  exdir = "../data/")
file.remove("../data/temp")
file.remove("../data/monthly-2023.csv.zip")
data = read.csv2("../data/monthly-2023.csv")
file.remove("../data/monthly-2023.csv")
# 460000 EcoKodas

 data %>% 
   filter(Ekonominės.veiklos.rūšies.kodas.ecoActCode.==460000) %>%
   saveRDS('../data/sutvarkytas.rds')
 