?install.packages

# Привет всем!

# ставим пакет в нужную папку
install.packages("ggplot2", lib = "~/Downloads/")

# куда R ставит пакеты по умолчанию
.libPaths()


# посмотреть рабочую папку
getwd()

7 + 9
9 * 11

# указать рабочую папку
# Session - Set working directory - Choose 
setwd("~/Downloads")

# читаем файл с данными в память компьютера
# File - Import dataset - From csv
library(readr)
pokemon <- read_csv("~/Downloads/pokemon.csv")

# присваивание переменной значения
x = 8 # простое равно
x=8 # так очень некрасиво
x <- 8 # так сделает сама Her Majesty
x + x
9 -> y # и так тоже супер!



