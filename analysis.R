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

# Compare the number of people injured with the total population and calculating an injury rate
summary <- selected %>% 
  count(age, sex, wt = weight) %>% 
  left_join(population, by = c("age", "sex")) %>% 
  mutate(rate = n / population * 1e4)

summary

# Plot the rate
summary %>% 
  ggplot(aes(age, rate, colour = sex)) + 
  geom_line(na.rm = TRUE) + 
  labs(y = "Injuries per 10,000 people")

# Look at some random narratives
selected %>% 
  sample_n(10) %>% 
  pull(narrative)