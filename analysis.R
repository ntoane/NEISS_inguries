library(vroom)
library(tidyverse)

# Load injuries
injuries <- vroom::vroom("neiss/injuries.tsv.gz")
injuries

# Load products
products <- vroom::vroom("neiss/products.tsv")
products

# Load population
population <- vroom::vroom("neiss/population.tsv")
population

# Injuries with product code 649
selected <- injuries %>% filter(prod_code == 649)
nrow(selected)

# Injuries involving toilets most often occur at home by falling, diagonis are varied
selected %>% count(location, wt = weight, sort = TRUE)
selected %>% count(body_part, wt = weight, sort = TRUE)
selected %>% count(diag, wt = weight, sort = TRUE)

# Explore patterns across age and sex
summary <- selected %>% count(age, sex, wt = weight)
summary

# Plot the patterns
summary %>% 
  ggplot(aes(age, n, colour = sex)) + 
  geom_line() + 
  labs(y = "Estimated number of injuries")