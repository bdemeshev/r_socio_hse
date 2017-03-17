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


library(tidyverse)
library(psych)

# Google: CRAN Task View
# Google: dplyr CRAN -> manual / vignette
?read_csv

# смотрим на нашу табличку с данными
glimpse(pokemon)
head(pokemon, 10)
tail(pokemon, 5)

describe(pokemon)
?mad
?skew

# Inf
2 / (Inf + 5) 
1 / 0
# NaN = Not A Number
0 / 0

# текстовые переменные
"Привет"

# из таблицы извлечём вектор-столбец
y <- pokemon$attack # из таблицы pokemon извлёк вектор attack
y
# самостоятельно создадим маленький вектор
z <- c(7, 8, NA)
z

mean(y)
median(y)
max(y)
sd(y)
?sd

mean(z)
mean(z, na.rm = TRUE)

# y <- "Ура!!!"

attack <- 7


pok2 <- read_csv("~/Downloads/pokemon.csv")

# операции с табличками

# порядок функций
cos(log(20))
20 %>% log %>% cos 

# 1. отбор переменных
fight <- select(pokemon, attack, defense, hp) 
fight <- dplyr::select(pokemon, attack, defense, hp) 
fight2 <- select(fight, -hp)

# глянул на новую табличку
glimpse(fight2)

fight <- pokemon %>% select(attack, defense, hp)

pokemon %>% select(attack) %>% describe
describe(select(pokemon, attack))


a <- pokemon %>% select(attack, defense, hp) %>%
  arrange(-attack) %>% head(10) %>% describe 
a

describe(head(arrange(select(pokemon, 
                             attack, defense, hp), -attack), 10))






