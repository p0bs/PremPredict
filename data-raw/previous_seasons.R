# Code to prepare `previous_seasons` dataset
data("teams")

results_lastSeason <- get_openData(
  value_path = system.file("extdata", "en1_2324.json", package = "PremPredict"),
  table_teams = teams,
  value_yearEnd = 2024L
)

# I could add more seasons in due course (but will only do the most recent for now)
previous_seasons <- results_lastSeason

usethis::use_data(previous_seasons, overwrite = TRUE)
