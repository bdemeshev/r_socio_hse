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

opisanie <- diamonds %>% group_by(color) %>%
  summarise(naimenshee = min(price),
            naibolshee = max(price),
            seredina = median(price),
            kolichestvo = n())
opisanie

# самая популярная функция на группированных табличках
# число наблюдений в группе
count(diamonds, color)

# сгруппировали по цвету
# для каждого цвета посчитать разницу цены и 
# средней цены бриллиантов данного цвета
diamonds2 <- diamonds %>% group_by(color) %>%
  mutate(otklonenie = price - mean(price))

glimpse(diamonds2)

# отбор строк
diamonds3 <- filter(diamonds2, otklonenie > 0)
glimpse(diamonds3)

opisanie

# переименовать переменную
diamonds4 <- rename(diamonds3, raznost = otklonenie)

Захвати Галактику!
  

