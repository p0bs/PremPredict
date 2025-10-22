# Code to prepare `example_thisSeason` dataset
# Committed on 2025-10-20

data("teams")

example_thisSeason <- get_openData(
  value_path = 'https://raw.githubusercontent.com/openfootball/football.json/refs/heads/master/2025-26/en.1.json',
  table_teams = teams,
  value_yearEnd = 2026L
)

usethis::use_data(example_thisSeason, overwrite = TRUE)
