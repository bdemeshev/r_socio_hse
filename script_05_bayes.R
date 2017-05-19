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
