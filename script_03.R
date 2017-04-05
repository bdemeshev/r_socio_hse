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
  
# склеиваем столбцы двух таблиц (одинаковое количество строк)
dubl <- bind_cols(diamonds3, diamonds4)
  
skleeni_stroki <- bind_rows(diamonds3, 
                            diamonds4)  
glimpse(skleeni_stroki)

# в память о команде rbind устроить перерыв :)
skleeni_stroki_old <- rbind(diamonds3, 
                            diamonds4)
# rbind — это предшественник bind_rows

opisanie

# левый джойн 
# склеиваем две таблицы по переменной color
joined_table <- left_join(diamonds, opisanie,
                          by = "color")
glimpse(joined_table)

count(diamonds, color) %>% arrange(n)
count(opisanie, color) %>% arrange(n)

# работа с факторными переменными

# создадим факторную переменную из обычной :)
igrushka <- data_frame(
        x = c(3, 4, 4, 5, 2),
        y = c("М", "Ж", "М", "Ж", "м"))
igrushka
# use cp1251 for non utf-8 program... (windows)
glimpse(igrushka)

igrushka2 <- mutate(igrushka, 
                    fy = factor(y),
                    fx = factor(x))
glimpse(igrushka2)

ggplot(data = diamonds) + 
  geom_bar(aes(x = color))

ggplot(data = igrushka2) + 
  geom_bar(aes(x = fy, y = x), stat = "identity")

# посмотрим на уровни факторной переменной
levels(igrushka2$fy)

# объединяем несколько уровней в один
igrushka3 <- mutate(igrushka2, 
  fy_united = 
    fct_collapse(fy, male = c("М", "м")))
glimpse(igrushka3)
