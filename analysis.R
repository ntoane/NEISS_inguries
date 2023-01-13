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