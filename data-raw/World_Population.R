library(tidyverse)
library(readxl)

# Read in the data. Do some cleaning
data <- read_excel("data-raw/World_Population.xlsx", sheet = 'ESTIMATES', range='A17:BZ306')

WorldPopulation <- data %>%
  filter(!(Index %in% c(1:26,47,57,63,81,82,90,109,110,116,126,127,136,148,149,178,187,202,205,206,212,220,230:232,243,257,274,284))) %>%
  select('Region, subregion, country or area *','1950':'2020')

colnames(WorldPopulation)[1] <- 'Country Name'

WorldPopulation <- WorldPopulation %>%
  select('1950':'2020') %>%
  apply(MARGIN=2,FUN=as.numeric) %>%
  apply(MARGIN=2,FUN=round) %>%
  as.data.frame() %>%
  mutate('Country Name' = WorldPopulation$'Country Name') %>%
  select('Country Name', '1950':'2020')

# Save the data frame to the data/ directory
usethis::use_data(WorldPopulation)
