# Code to prepare `previous_seasons` dataset
# As run on 2025-05-12

data("teams")

example_thisSeason <- get_openData(
  value_path = 'https://raw.githubusercontent.com/openfootball/football.json/refs/heads/master/2024-25/en.1.json',
  table_teams = teams,
  value_yearEnd = 2025L
)

usethis::use_data(example_thisSeason, overwrite = TRUE)
