library(tidyverse) # обработка данных, графики
library(forcats) # для работы с факторными переменными
library(lubridate) # для работы с датами/временем
library(stringr) # для работы с текстовыми переменными
library(reshape2) # преобразование длинные <-> широкие
library(readr) # чтение файлов

# install = инсталлировать (1 раз)
# install.packages("the_package")
# Tools - Install packages 
# --------------------------------
# attach = load = подключить = загрузить (каждый раз при запуске)
# library(the_package)
# 
# список функций пакета:
help(package = "readr")
# документация по функции
help(read_csv)
# или коротко:
?read_csv

adv <- read_csv("~/Downloads/Advertising.csv")
# File -> Import Dataset -> From CSV ->

glimpse(adv)

# два простых графика

# самый идеальный, пустой график!
ggplot(data = adv)

# чуть похуже :)
# http://docs.ggplot2.org
ggplot(data = adv) + 
  geom_point(aes(x = Radio, 
                 y = Newspaper,
                 size = Sales),
                 alpha = 0.3) +
  xlab("Расходы на радио (тыс. у.е.)") +
  ylab("Газеты :)")


base <- ggplot(data = adv) + 
  geom_point(aes(x = Radio, 
                 y = Newspaper,
                 size = Sales))

base
base + xlab("Привет! :)") + ggtitle("Нано-шедевр")

# критерий хорошего графика :)

ggplot(data = adv) + 
  geom_point(aes(x = Radio, alpha = TV, 
                 y = Newspaper,
                 size = Sales))

base + theme_bw()
# https://cran.r-project.org/web/packages/ggthemes/vignettes/ggthemes.html
# GOOGLE: ggplot2 + themes

library(ggthemes)
base + theme_stata()
base + theme_excel()

hist_base <- ggplot(data = adv) + 
  geom_histogram(aes(x = Sales))
hist_base

# то же самое, но по-быстрому
qplot(data = adv, 
      geom = "histogram",
      x = Sales)

qplot(data = adv, 
      geom = "point",
      x = Sales,
      y = TV,
      xlab = "Подпись по горизонтали") 
??qplot
?qplot

# GOOGLE: ggplot2 -> вкладка Images
# Хочу такой же, только с золотыми пуговицами

# преобразования переменных

# mutate {dplyr}
adv2 <- mutate(adv, 
               sales2 = Sales^2,
               ln_sales = log(Sales),
               sales_scaled = scale(Sales),
               sales_scaled_2 = 
                 (Sales - mean(Sales)) / sd(Sales))
glimpse(adv2)

write_csv(adv2, path = "adv_2.csv")
# узнать рабочую папку:
getwd()
# установить рабочую папку:
setwd("~/Downloads/")
# Session - Set working directory - Choose

# отбор наблюдений по нескольким критериям:
adv3 <- filter(adv, 
               Sales > mean(Sales),
               TV < quantile(TV, 0.9) )

# быстрый взгляд на табличку:
glimpse(adv3)

# особая переменная: rownames
# извлечь имя строки (если оно по старой традиции есть)
rownames(adv)

# упорядочиваем табличку adv3 по убыванию Sales
# добавляем переменную nomer равную номеру строки
adv4 <- arrange(adv3, -Sales) %>% 
          mutate(nomer = row_number())

# список функций пакета:
help(package = "dplyr")

library(psych)
adv %>% select(Sales) %>% describe() %>% 
  select(min, max)

describe(adv) # 
describe(adv$Sales)

min(adv$TV) # минимум переменной TV из табличку adv
mean(adv$TV) # среднее 
