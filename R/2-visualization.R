library(tidyverse)
library(ggplot2)

data= readRDS('../data/sutvarkytas.rds')
data =data %>%  mutate(Vidutinis.darbo.užmokestis..avgWage. =
                as.numeric(Vidutinis.darbo.užmokestis..avgWage.))
data = data %>% mutate(Mėnuo..month. = ym(Mėnuo..month.))
names(data)[names(data)=="Pavadinimas..name."] <- "Imoniu pavadinimai" 

# 2.1 uzduotis
g1= data %>%
  ggplot(aes(x=Vidutinis.darbo.užmokestis..avgWage.)) + 
  geom_histogram(bins = 200, fill='red') + labs(title = 'Vidutinis atlygis',
                                                x= 'atlyginimas', y='kiekis')
  ggsave('../img/pirmasGrafikas.png', g1)

# 2.2 uzduotis
  
 topinesimones = data %>%
    group_by(`imoniu pavadinimai`) %>%
    summarise(top5=max(Vidutinis.darbo.užmokestis..avgWage.)) %>%
    arrange(desc(top5)) %>%
    head(5)

 g2 =  data %>%
     filter(`imoniu pavadinimai` %in% topinesimones$`imoniu pavadinimai`) %>% 
     ggplot(aes(x=Mėnuo..month., y=Vidutinis.darbo.užmokestis..avgWage.,
                col = `imoniu pavadinimai` )) +
     geom_line() + labs(title = 'Kitimo dinamika', x='Menuo', y='Vidutinis atlygis')
   
 ggsave('../img/antrasgrafikas.png', g2, width = 10)
 
 
 # trecias grafikas

apdraustuju = data %>% 
   filter(`imoniu pavadinimai` %in% topinesimones$`imoniu pavadinimai`) %>%
   group_by(`imoniu pavadinimai`) %>% 
   summarise(maxapdr = max(Apdraustųjų.skaičius..numInsured.)) %>%
  arrange(desc(maxapdr))

apdraustuju$`imoniu pavadinimai`=factor(apdraustuju$`imoniu pavadinimai`, 
levels = apdraustuju$`imoniu pavadinimai`[order(apdraustuju$maxapdr, decreasing = TRUE)])

g3 = apdraustuju %>% 
  ggplot(aes(x=`imoniu pavadinimai`, y=maxapdr, fill = `imoniu pavadinimai`)) +
  geom_col() + labs(y = 'apdraustuju skaicius', title = 'Maksimalus apdraustuju skaicius')
ggsave('../img/treciasgrafikas.png', g3, width = 10)
 
 
 
 
 
 