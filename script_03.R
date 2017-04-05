library(tidyverse) # манипуляции с данными, графики
library(forcats) # работа с факторными переменными

# встроенный набор данных diamonds
# входит в состав пакета tidyverse (в ggplot2)
glimpse(diamonds)
help(diamonds)

diamonds %>% group_by(color) %>%
  summarise(naimenshee = min(price),
         naibolshee = max(price),
         seredina = median(price))


