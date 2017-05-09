library(tidyverse)
library(survey)
library(broom)

set.seed(777)
pc <- mutate(cars, ipw = runif(nrow(cars), min = 1, max = 10),
             id = row_number(),
             d01 = sample(0:1, size = nrow(cars), replace = TRUE))
glimpse(pc)

# code:
# http://stackoverflow.com/questions/28445295/inverse-probability-weights-in-r
# theory:
# http://www.parisschoolofeconomics.eu/docs/dupraz-yannick/using-weights-in-stata(1).pdf

des_1 <- svydesign(id = ~id, weights = ~ipw, data = pc)
ols_example <- svyglm(dist ~ speed, design = des_1)  
logit_example <- svyglm(d01 ~ speed, design = des_1, 
                        family = binomial(link = "logit"))
summary(ols_example)
summary(logit_example)
tidy(ols_example)
tidy(logit_example)

# the difference?
des_2 <- svydesign(id = ~1, weights = ~ipw, data = pc)
ols_example_2 <- svyglm(dist ~ speed, design = des_2)  
logit_example_2 <- svyglm(d01 ~ speed, design = des_2, 
                        family = binomial(link = "logit"))
tidy(logit_example)
tidy(logit_example_2)
tidy(ols_example)
tidy(ols_example_2)

library(purrr)
help(package = "purrr")

svymean(pc, design = des_1)
svymean(pc$speed, design = des_2)

