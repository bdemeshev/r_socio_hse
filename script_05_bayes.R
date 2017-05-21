library(rstanarm) # байесовские аналоги классических моделей
# в частности иерархические
library(tidyverse) # манипуляции с данными и графики
library(bayesplot) # графики для байесовского подхода
library(loo) # сравнение прогнозной силы моделей в байесовском подходе
library(shinystan) # кнопочный интерфейс для графического анализа байесовских моделей

# классический частотный подход
model_lm <- lm(data = diamonds, price ~ carat)
summary(model_lm)


# байесовский подход
model_lm_bayes <- stan_lm(data = diamonds, 
                          price ~ carat,
                          prior = R2(location = 0.2,
                                     what = "mean"),
                          seed = 777)

summary(model_lm_bayes)

model_lm_array <- as.array(model_lm_bayes)
mcmc_intervals(model_lm_array, 
               pars = c("carat", "(Intercept)"))
mcmc_intervals(model_lm_array, pars = "carat")
mcmc_hist(model_lm_array, pars = "carat")
posterior_interval(model_lm_bayes, pars = "carat")

posterior_vs_prior(model_lm_bayes, pars = "carat")

# посчитать elpd
# сравниваем две модели по elpd (лучше, где больше)
loo_1 <- loo(model_lm_bayes)

loo_2 <- loo(конкурирующая модель)

compare_models(loo_1, loo_2)

# прогнозы
two_diamonds = data_frame(carat = c(1, 3, mean(diamonds$carat)))
forecasted_price <- posterior_predict(model_lm_bayes, 
                  newdata = two_diamonds)
summary(forecasted_price)

str(forecasted_price)

qplot(forecasted_price[, 1])


# иерархические модели
library(lme4)
data("sleepstudy")

glimpse(sleepstudy)

d <- sleepstudy
count(d, Subject)


#model_1 <- stan_lmer(data = sleepstudy, 
#                     Reaction ~ 1 + Days, seed = 777)
model_2 <- stan_lmer(data = sleepstudy, 
                     Reaction ~ (1|Subject) + Days, seed = 777)
model_3 <- stan_lmer(data = sleepstudy, 
                     Reaction ~ (1 + Days|Subject), seed = 777)
model_3_bis <- stan_lmer(data = sleepstudy, 
                     Reaction ~ (1|Subject) + (0 + Days|Subject), 
                     seed = 777)
summary(model_3_bis)

posterior_interval(model_3_bis, pars = "b[Days Subject:349]")
# https://socserv.socsci.mcmaster.ca/jfox/Books/Companion/appendix/Appendix-Mixed-Models.pdf


