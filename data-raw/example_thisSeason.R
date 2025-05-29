# Code to prepare `example_thisSeason` dataset
# Committed on 2025-04-21

data("teams")

example_thisSeason <- get_openData(
  value_path = 'https://raw.githubusercontent.com/openfootball/football.json/abbe4d33bc2234c895d36654c542b10066856b4e/2024-25/en.1.json',
  table_teams = teams,
  value_yearEnd = 2025L
)

usethis::use_data(example_thisSeason, overwrite = TRUE)
