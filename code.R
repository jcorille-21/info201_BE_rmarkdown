# Load libraries
library(dplyr)
library(usmap)
library(ggplot2)

# Read data
incarceration_data <- read.csv('incarceration_trends.csv', stringsAsFactors = F)

# Filter data by...
# - total population in Washington in 2008
# - max county population in Washington in 2008
# - total state populations in 2008

wa_pop_2008 <- incarceration_data %>%
  filter(state == 'WA' & year == '2008')

max_wa_pop_2008 <- wa_pop_2008 %>%
  filter(total_pop == max(total_pop)) %>%
  pull(total_pop)

us_pop_2008 <- incarceration_data %>%
  filter(year == '2008') %>%
  group_by(state) %>%
  summarize(total_state_pop = sum(total_pop))

# Map data using plot_usmap()

wa_map <- plot_usmap(data = wa_pop_2008,
                     values = 'total_pop',
                     include = 'WA',
                     color = 'white') +
  scale_fill_continuous(low = 'blue', high = 'red')
wa_map

us_map <- plot_usmap(data = us_pop_2008,
                     values = 'total_state_pop',
                     color = 'black') +
  scale_fill_continuous(low = 'white', high = 'green')
us_map
