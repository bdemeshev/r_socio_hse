library(tidyverse) # обработка данных
library(broom) # представление всех результатов табличками
library(sjPlot) # симпатичные графики для моделей
library(feather) # сохранение данных в feather формат
library(readr) # чтение/запись csv

glimpse(diamonds)

# сохранение результатов в файл
# свой собственный .Rds
write_rds(diamonds, path = "~/Downloads/diamonds.Rds")
# old classic style 
# saveRDS(diamonds, file = "~/Downloads/diamonds.Rds")

getwd()
setwd("~/Downloads")

# для экспорта в тьму-таракань (eviews, spss, ...)
write_csv(diamonds, path = "~/Downloads/diamonds.csv")

# обмен данных между китами анализа данных
# python - R - Julia
write_feather(diamonds, path = "~/Downloads/diamonds.feather")

# список встроенных наборов данных:
data()
dia <- diamonds

# прочитать обратно
dia_rds <- read_rds("~/Downloads/diamonds.Rds")


setwd("~/Downloads/")
getwd()


# как реализовывать взвешивание для репрезентативных выборок?
# направить взор к пакету survey
library(survey)
des <- svydesign() # 
model <- svyglm() # 

# метод наименьших квадратов и его визуализация
glimpse(diamonds)

model <- lm(data = diamonds, log(price) ~ log(carat) + cut)

# bad syntax style
# model<-lm(data=diamonds,log(price)~log(carat)+cut)
summary(model)
levels(diamonds$cut)

# ? короткие коды для факторной переменной

# вспомним прошлое
# 1. объединим уровни Premium и Ideal в preideal
# 2. за базовый уровень возьмем Good

library(forcats)
# 1. объединим уровни Premium и Ideal в preideal
d2 <- mutate(diamonds, cut2 = fct_collapse(cut, 
                          preideal = c("Premium", "Ideal")))
# 2. за базовый уровень возьмем Good
?fct_relevel
d3 <- mutate(d2, cut3 = fct_relevel(cut2, "Good"))

glimpse(d3) 
View(d3) # как в экселе
