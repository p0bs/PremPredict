# Code to prepare `example_thisSeason` dataset
# Committed on 2025-10-26

data("teams")
data("schedule_thisSeason")

example_thisSeason <- get_footballData(
  value_link = "https://www.football-data.co.uk/mmz4281/2526/E0.csv",
  table_schedule = schedule_thisSeason,
  table_teams = teams,
  value_yearEnd = 2026L
)

usethis::use_data(example_thisSeason, overwrite = TRUE)
