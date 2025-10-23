# Code to prepare `schedule_thisSeason` dataset

data("teams")

value_path_schedule = system.file(
  "extdata",
  "en1_2526_schedule.json",
  package = "PremPredict",
  mustWork = TRUE
)

schedule_thisSeason <- get_openData_schedule(
  value_path = value_path_schedule,
  table_teams = data("teams"),
  value_yearEnd = 2026L
)

usethis::use_data(schedule_thisSeason, overwrite = TRUE)
