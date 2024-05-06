library(tidyverse)
library(rvest)

# Read in the url from Wikipedia
url = "https://en.wikipedia.org/wiki/FIFA_World_Cup"

wikipediaPage <- read_html(url)

attendanceTable <- wikipediaPage %>%
  html_nodes('table') %>%
  .[[4]] %>%
  html_table(header=TRUE, fill=TRUE)

World_Cup <- attendanceTable %>%
  select(Year,Hosts,Matches,"Totalattendance †",Averageattendance) %>%
  filter(!(Year %in% c('Year','2026','2030[n 1]','2034','Overall')))

colnames(World_Cup) <- c('Year','Hosts','Matches','Totalattendance','Averageattendance')

World_Cup <- World_Cup %>%
  mutate(Totalattendance = str_replace_all(Totalattendance, pattern=',',replacement='')) %>%
  mutate(Averageattendance = str_replace_all(Averageattendance, pattern=',',replacement=''))

World_Cup$Totalattendance <- as.numeric(World_Cup$Totalattendance)
World_Cup$Averageattendance <- as.numeric(World_Cup$Averageattendance)

# Save the data frame to the data/ directory
usethis::use_data(World_Cup)
