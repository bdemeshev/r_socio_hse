library(tidyverse)
library(forcats)
library(readr)

ivanov_example <- read_csv("~/Downloads/ivanov_examle.csv")
glimpse(ivanov_example)
iv_sorted <- ivanov_example %>% filter(RN < 11)  %>% 
   arrange(RN, -PROPORTION) 
        
iv_factor <- mutate(iv_sorted, 
                    MARKET_KEY = 
                      fct_reorder(MARKET_KEY, row_number()))



iv_factor %>% ggplot + 
        geom_point(aes(x = MARKET_KEY, 
                       y = factor(RN),
                       size = PROPORTION,
                       color = -PROPORTION,
                       alpha = 0.7)) +                    
        xlab("Регионы") +
        ylab("Ранг") +
        theme(axis.text.x = element_text(size = 8, angle = 90, hjust = 1, vjust = 0.5)) +
        ggtitle("Регионы, где Иванов в топ 10 по популярности") 
