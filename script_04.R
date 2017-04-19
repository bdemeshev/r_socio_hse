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

