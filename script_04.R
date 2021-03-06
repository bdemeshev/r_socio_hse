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
View(d3) # как в экселе: можно filter использовать

model <- lm(data = d3, log(price) ~ log(carat) + cut3)
summary(model)

d4 <- mutate(d3, cut_info = (cut3 > "Good"))

sjp.lm(model)

diamonds %>% group_by(cut) %>% 
  summarise(av = mean(price))

# для парной регрессии — график в осях x-y
mod_0 <- lm(data = diamonds, 
            price ~ carat)
summary(mod_0)
sjp.lm(mod_0)

# что извлечь из модели
library(broom) # три уровня информации о любой модел
# общие показатели / коэффициенты / дополнение реальных данных
glance(model) # общие показатели
tidy(model) # коэффициенты

library(modelr) # работа с моделями

# добавим предсказанные y (игрек с крышкой)
d_new <- add_predictions(d3, model) 

# добавим предсказанные y (игрек с крышкой)
# и остатки за одно действие
d_new <- add_predictions(d3, model) %>%
                       add_residuals(model)

# добавить всё к исходным данным
d_super <- augment(model, d3)

# стандартизованные коэффициенты:
# нормируем все переменные 
# и строим регрессию для нормированных переменных
# стандартизированные коэффициенты:
sjp.lm(model, type = "std")
# исходные коэффициенты:
sjp.lm(model)

lm(data = diamonds, scale(price) ~ scale(carat))
# достать стандартизированные коэффициенты в одну строку и быстро?

# грамотное программирование / literate programming
# Tools - Install packages - rmarkdown




