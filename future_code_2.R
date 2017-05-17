
library(tidyverse)


library(gapminder)
gapminder

group_data <- gapminder %>% group_by(continent)
group_data
nested_data <- gapminder %>% group_by(continent) %>% nest(.key = by_continent)
nested_data
?nest


nested_again <-
  nested_data %>% mutate(by_continent = map(by_continent, ~.x %>% 
                                            nest(-country, .key = by_country)))

a <- nested_again$by_continent[[1]]
a

sol2<-nested_again %>% mutate(by_continent = map(by_continent, ~.x %>% 
                                                   mutate(models = map(by_country, ~lm(lifeExp ~ year, data = .x) )) ))
sol2

gapminder %>% group_by(continent) %>% nest()

nested2 <- gapminder %>% nest(-continent, .key = "by_continent")
nested2

iris
res <- iris %>% nest(-Species)
res$data[[1]]

chickwts %>% nest(weight)

library(reprex)
reprex(si = TRUE)

gapminder %>% nest(-country, -continent)


?nest


mtcars %>%
  split(.$cyl) %>%
  map(~ lm(mpg ~ wt, data = .x)) %>%
  map(summary) %>%
  map_dbl("r.squared")


mtcars %>%
  split(.$cyl)
?split



map(1:10, ~ rnorm(10, .x))
1:10 %>% map(~ cos(.x))



df <- tibble(x = 1:2, y = list(NA, NA))
df$y[[1]] <- as_tibble(cars[1:20, ])
df$y[[2]] <- as_tibble(cars[21:50, ])

df_res <- df %>% mutate(ols = y %>% map(~ lm(data = .x, formula = dist ~ speed)))


?pmap

test1 <- tibble(x = 1:2, from = 1:2, to = c(10, 20), eq = c(dist ~ speed, speed ~ dist))
test1

test2 <- test1 %>% mutate(df = map2(from, to, ~ cars[.x:.y, ] %>% as_tibble))
test3 <- test2 %>% mutate(ols_res = map2(df, eq, ~ lm(data = .x, formula = .y)))
test4 <- test3 %>% mutate(ols_sum = map(ols_res, ~ summary(.x)))
test4$ols_sum[[2]]

test3
test2_un <- test2 %>% unnest


estimate_one_model <- function(from, to, eq) {
  data <- cars[from:to, ]
  model <- lm(data, formula = eq)
}


test2b <- test1 %>% mutate(ols_res = pmap(.l = list(from, to, eq), estimate_one_model))

test1 %>% select(from, to, eq) %>% pmap(estimate_one_model)


test3$df[[1]]

test3$ols_res[[2]]

library(stargazer)
stargazer(test4$ols_res, type = "text")

test1 %>% mutate(ols_res = pm)

?pmap


ans <- mtcars %>% by_row(sum)

library(listviewer)
listview(test4)

jsonedit(test4)

jsonedit(cars)

cars2 <- jsonedit(cars)

cars2 <- cars
cars2

jsonedit(cars2)

?jsonedit


map(1:10, ~ cos(.x))
map(1:10, ~ cos(.))


map(1:10, cos)


estimate_it <- function(formula, from, to) {
  cars_subset <- cars[from:to, ]
  model <- lm(data = cars_subset, formula)
  return(model)
}

(speed ~ dist) %>% estimate_it(from = 1, to = 40)

df <- tribble(~x, ~y, ~f,
              1, 10, dist ~ speed,
              2, 20, speed ~ dist, 
              1, 40, dist ~ poly(speed, 2),
              1, 50, dist ~ poly(speed, 3, raw = TRUE))

df_ols <- df %>% mutate(ols = pmap(
  list(from = x, to = y, formula = f), estimate_it))

df_ols




